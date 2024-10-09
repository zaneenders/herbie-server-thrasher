import AsyncHTTPClient
import NIOCore
import Foundation
@preconcurrency import _NIOFileSystem

@main
struct HerbieServerThrasher {
    public static func main() async throws {

        print("Hello from Herbie server thrasher.")

        enum ServerThrasherError: Error {
            case noServer
            case sampleFailed
        }
        // let serverURL = "https://herbie.uwplse.org/demo"
        let serverURL = "http://localhost:8000"
        let readBufferSize = 10 * 1024 * 1024  // 10 MB because sometimes fat json
        let req = HTTPClientRequest(url: "\(serverURL)/up")
        let res = try await HTTPClient.shared.execute(req, timeout: .seconds(30))
        guard res.status == .ok else {
            print("Server is not up")
            throw ServerThrasherError.noServer
        }

        var sampleReq = HTTPClientRequest(url: "\(serverURL)/api/sample")
        sampleReq.method = .POST
        let bodyString = """
            {"formula":"\(simple)","seed":5}
            """
        sampleReq.body = HTTPClientRequest.Body.bytes(ByteBuffer(string: bodyString))
        let sampleRes = try await HTTPClient.shared.execute(sampleReq, timeout: .seconds(30))
        let sampleResBuffer = try await sampleRes.body.collect(upTo: readBufferSize)  // 10 MB because sometimes fat json
        let sampleBody = String(buffer: sampleResBuffer)
        guard sampleRes.status == .ok else {
            print(sampleBody)
            throw ServerThrasherError.sampleFailed
        }
        let json = try JSONDecoder().decode(SampleRSP.self, from: sampleResBuffer)
        print(json.points.count)
        let cwd = try await FileSystem.shared.currentWorkingDirectory
        let fh = try await FileSystem.shared.openFile(
            forWritingAt: cwd.appending("sample.json"), options: .modifyFile(createIfNecessary: true))
        var writer = fh.bufferedWriter()
        try await writer.write(contentsOf: sampleResBuffer)
        try await writer.flush()
        try await fh.close()
    }
}
