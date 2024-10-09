import Foundation

struct SampleRSP: Codable {
    let command, job, path: String
    let points: [[PointElement]]
}

enum PointElement: Codable {
    case double(Double)
    case doubleArray([Double])
    case other(Other)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([Double].self) {
            self = .doubleArray(x)
            return
        }
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Other.self) {
            self = .other(x)
            return
        }
        throw DecodingError.typeMismatch(
            PointElement.self,
            DecodingError.Context(
                codingPath: decoder.codingPath,
                debugDescription: "Wrong type for PointElement"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .doubleArray(let x):
            try container.encode(x)
        case .other(let x):
            try container.encode(x)
        }
    }
}

struct Other: Codable {
    let type: Type
    let value: Value
}

enum Type: String, Codable {
    case real = "real"
}

enum Value: String, Codable {
    case inf = "-inf"
    case valueInf = "+inf"
}
