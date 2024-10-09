import Foundation

struct AnalyzeRSP: Codable {
    let command, job, path: String
    let points: [[Point]]
}

enum Point: Codable {
    case doubleArray([Double])
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([Double].self) {
            self = .doubleArray(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(
            Point.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Point"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .doubleArray(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}
