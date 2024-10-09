import AsyncHTTPClient
import Foundation
import NIOCore
@preconcurrency import _NIOFileSystem

// let serverURL = "https://herbie.uwplse.org/demo"
let serverURL = "http://localhost:8000"
let readBufferSize = 10 * 1024 * 1024  // 10 MB because sometimes fat json

@main
struct HerbieServerThrasher {
    public static func main() async throws {
        print("Hello from Herbie server thrasher.")

        try await up()
        let fpcore = det44
        let sampleRSP = try await sample(fpcore)
        // Maybe just sample one point.
        let point = sampleRSP.points[420]
        let localErrorTree = try await localError(fpcore, point)
        let explain = try await explain(fpcore, point)
        let analysis = try await analyze(fpcore, sampleRSP.points)
        let cost = try await cost(fpcore, sampleRSP.points)
        let alts = try await alternatives(fpcore, sampleRSP.points)
        let mathjs = try await mathJS(fpcore)
        print(alts)

        // let cwd = try await FileSystem.shared.currentWorkingDirectory
        // let fh = try await FileSystem.shared.openFile(
        //     forWritingAt: cwd.appending("sample.json"), options: .modifyFile(createIfNecessary: true))
        // var writer = fh.bufferedWriter()
        // try await writer.write(contentsOf: sampleBody.utf8)
        // try await writer.flush()
        // try await fh.close()
    }
}

func cost(_ fpCore: String, _ samples: [[PointElement]]) async throws -> CostRSP {
    let jsonPoints = try JSONEncoder().encode(samples)
    var sampleReq = HTTPClientRequest(url: "\(serverURL)/api/cost")
    sampleReq.method = .POST
    let bodyString = """
        {"formula":"\(jsonReady(fpCore))","sample":\(String(data: jsonPoints, encoding: .utf8)!)}
        """
    sampleReq.body = HTTPClientRequest.Body.bytes(ByteBuffer(string: bodyString))
    let sampleRes = try await HTTPClient.shared.execute(sampleReq, timeout: .seconds(30))
    let sampleResBuffer = try await sampleRes.body.collect(upTo: readBufferSize)
    let sampleBody = String(buffer: sampleResBuffer)
    guard sampleRes.status == .ok else {
        print(sampleBody)
        throw ServerThrasherError.sampleFailed
    }
    return try JSONDecoder().decode(CostRSP.self, from: sampleResBuffer)
}

func analyze(_ fpCore: String, _ samples: [[PointElement]]) async throws -> AnalyzeRSP {
    let jsonPoints = try JSONEncoder().encode(samples)
    var sampleReq = HTTPClientRequest(url: "\(serverURL)/api/analyze")
    sampleReq.method = .POST
    let bodyString = """
        {"formula":"\(jsonReady(fpCore))","sample":\(String(data: jsonPoints, encoding: .utf8)!)}
        """
    sampleReq.body = HTTPClientRequest.Body.bytes(ByteBuffer(string: bodyString))
    let sampleRes = try await HTTPClient.shared.execute(sampleReq, timeout: .seconds(30))
    let sampleResBuffer = try await sampleRes.body.collect(upTo: readBufferSize)
    let sampleBody = String(buffer: sampleResBuffer)
    guard sampleRes.status == .ok else {
        print(sampleBody)
        throw ServerThrasherError.sampleFailed
    }
    return try JSONDecoder().decode(AnalyzeRSP.self, from: sampleResBuffer)
}

// Maybe just sample one point as Odyssey does right now.
func localError(_ fpCore: String, _ sample: [PointElement]) async throws -> LocalErrorRSP {
    let jsonPoints = try JSONEncoder().encode([sample])
    var sampleReq = HTTPClientRequest(url: "\(serverURL)/api/localerror")
    sampleReq.method = .POST
    let bodyString = """
        {"formula":"\(jsonReady(fpCore))","sample":\(String(data: jsonPoints, encoding: .utf8)!)}
        """
    sampleReq.body = HTTPClientRequest.Body.bytes(ByteBuffer(string: bodyString))
    let sampleRes = try await HTTPClient.shared.execute(sampleReq, timeout: .seconds(30))
    let sampleResBuffer = try await sampleRes.body.collect(upTo: readBufferSize)
    let sampleBody = String(buffer: sampleResBuffer)
    guard sampleRes.status == .ok else {
        print(sampleBody)
        throw ServerThrasherError.sampleFailed
    }
    return try JSONDecoder().decode(LocalErrorRSP.self, from: sampleResBuffer)
}

func explain(_ fpCore: String, _ sample: [PointElement]) async throws -> ExplanationRSP {
    let jsonPoints = try JSONEncoder().encode([sample])
    var sampleReq = HTTPClientRequest(url: "\(serverURL)/api/explanations")
    sampleReq.method = .POST
    let bodyString = """
        {"formula":"\(jsonReady(fpCore))","sample":\(String(data: jsonPoints, encoding: .utf8)!)}
        """
    sampleReq.body = HTTPClientRequest.Body.bytes(ByteBuffer(string: bodyString))
    let sampleRes = try await HTTPClient.shared.execute(sampleReq, timeout: .seconds(30))
    let sampleResBuffer = try await sampleRes.body.collect(upTo: readBufferSize)  // 10 MB because sometimes fat json
    let sampleBody = String(buffer: sampleResBuffer)
    guard sampleRes.status == .ok else {
        print(sampleBody)
        throw ServerThrasherError.sampleFailed
    }
    return try JSONDecoder().decode(ExplanationRSP.self, from: sampleResBuffer)
}

func alternatives(_ fpCore: String, _ samples: [[PointElement]]) async throws -> sending AlternativesRSP {
    let jsonPoints = try JSONEncoder().encode(samples)
    var sampleReq = HTTPClientRequest(url: "\(serverURL)/api/alternatives")
    sampleReq.method = .POST
    let bodyString = """
        {"formula":"\(jsonReady(fpCore))","sample":\(String(data: jsonPoints, encoding: .utf8)!)}
        """
    sampleReq.body = HTTPClientRequest.Body.bytes(ByteBuffer(string: bodyString))
    let sampleRes = try await HTTPClient.shared.execute(sampleReq, timeout: .seconds(30))
    let sampleResBuffer = try await sampleRes.body.collect(upTo: readBufferSize)  // 10 MB because sometimes fat json
    let sampleBody = String(buffer: sampleResBuffer)
    guard sampleRes.status == .ok else {
        print(sampleBody)
        throw ServerThrasherError.sampleFailed
    }
    return try JSONDecoder().decode(AlternativesRSP.self, from: sampleResBuffer)
}

func mathJS(_ fpCore: String) async throws -> MathJSRSP {
    var sampleReq = HTTPClientRequest(url: "\(serverURL)/api/mathjs")
    sampleReq.method = .POST
    let bodyString = """
        {"formula":"\(jsonReady(fpCore))"}
        """
    sampleReq.body = HTTPClientRequest.Body.bytes(ByteBuffer(string: bodyString))
    let sampleRes = try await HTTPClient.shared.execute(sampleReq, timeout: .seconds(30))
    let sampleResBuffer = try await sampleRes.body.collect(upTo: readBufferSize)  // 10 MB because sometimes fat json
    let sampleBody = String(buffer: sampleResBuffer)
    guard sampleRes.status == .ok else {
        print(sampleBody)
        throw ServerThrasherError.sampleFailed
    }
    return try JSONDecoder().decode(MathJSRSP.self, from: sampleResBuffer)
}

func sample(_ fpCore: String, _ seed: Int = 5) async throws -> SampleRSP {
    var sampleReq = HTTPClientRequest(url: "\(serverURL)/api/sample")
    sampleReq.method = .POST
    let bodyString = """
        {"formula":"\(jsonReady(fpCore))","seed":\(seed)}
        """
    sampleReq.body = HTTPClientRequest.Body.bytes(ByteBuffer(string: bodyString))
    let sampleRes = try await HTTPClient.shared.execute(sampleReq, timeout: .seconds(30))
    let sampleResBuffer = try await sampleRes.body.collect(upTo: readBufferSize)  // 10 MB because sometimes fat json
    let sampleBody = String(buffer: sampleResBuffer)
    guard sampleRes.status == .ok else {
        print(sampleBody)
        throw ServerThrasherError.sampleFailed
    }
    return try JSONDecoder().decode(SampleRSP.self, from: sampleResBuffer)
}

func up() async throws {
    let req = HTTPClientRequest(url: "\(serverURL)/up")
    let res = try await HTTPClient.shared.execute(req, timeout: .seconds(30))
    guard res.status == .ok else {
        print("Server is not up")
        throw ServerThrasherError.noServer
    }
}

enum ServerThrasherError: Error {
    case noServer
    case sampleFailed
}
