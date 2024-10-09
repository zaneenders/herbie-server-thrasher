import Foundation

struct ExplanationRSP: Codable {
    let command: String
    let explanation: [[Explanation]]
    let job, path: String
}

enum Explanation: Codable {
    case integer(Int)
    case string(String)
    case unionArrayArray([[ExplanationExplanation]])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode([[ExplanationExplanation]].self) {
            self = .unionArrayArray(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(
            Explanation.self,
            DecodingError.Context(
                codingPath: decoder.codingPath, debugDescription: "Wrong type for TopLevelExplanation"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        case .unionArrayArray(let x):
            try container.encode(x)
        }
    }
}

enum ExplanationExplanation: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(
            ExplanationExplanation.self,
            DecodingError.Context(
                codingPath: decoder.codingPath, debugDescription: "Wrong type for ExplanationExplanation"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}
