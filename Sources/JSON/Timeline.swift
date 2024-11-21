typealias Serializable = Sendable & Codable

typealias TimeLine = [TimeLineElement]

struct TimeLineElement: Serializable {
    let bogosity: [Bogosity]?
    let memory: [[Int]]
    let mixsample: [[Mixsample]]?
    let outcomes: [[OutcomeElement]]?
    let time: Double
    let type: String
    let count: [[Int]]?
    let method: [Method]?
    let stop: [[Stop]]?
    let compiler: [[Int]]?
    let accuracy, baseline, oracle: [Double]?
    let times, series: [[Mixsample]]?
    let confusion: [[Int]]?
    let explanations: [[Explanation]]?
    let freqs, maybeConfusion, totalConfusion: [[Int]]?
    let sampling: [[SamplingElement]]?

    enum CodingKeys: String, CodingKey {
        case bogosity, memory, mixsample, outcomes, time, type, count, method, stop, compiler, accuracy, baseline,
            oracle, times, series, confusion, explanations, freqs
        case maybeConfusion = "maybe-confusion"
        case totalConfusion = "total-confusion"
        case sampling
    }
}

extension TimeLineElement {

    struct Bogosity: Serializable {
        let exit, infinite, invalid, precondition: Double
        let valid: Double
    }

    enum Explanation: Serializable {
        case bool(Bool)
        case integer(Int)
        case string(String)
        case unionArrayArray([[Stop]])

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let x = try? container.decode(Bool.self) {
                self = .bool(x)
                return
            }
            if let x = try? container.decode(Int.self) {
                self = .integer(x)
                return
            }
            if let x = try? container.decode([[Stop]].self) {
                self = .unionArrayArray(x)
                return
            }
            if let x = try? container.decode(String.self) {
                self = .string(x)
                return
            }
            throw DecodingError.typeMismatch(
                Explanation.self,
                DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Explanation"))
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .bool(let x):
                try container.encode(x)
            case .integer(let x):
                try container.encode(x)
            case .string(let x):
                try container.encode(x)
            case .unionArrayArray(let x):
                try container.encode(x)
            }
        }
    }

    enum Stop: Serializable {
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
                Stop.self,
                DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Stop"))
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

    enum Method: String, Serializable {
        case binarySearch = "binary-search"
        case eggHerbie = "egg-herbie"
        case leftValue = "left-value"
        case random = "random"
        case search = "search"
    }

    enum Mixsample: Serializable {
        case double(Double)
        case string(String)

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let x = try? container.decode(Double.self) {
                self = .double(x)
                return
            }
            if let x = try? container.decode(String.self) {
                self = .string(x)
                return
            }
            throw DecodingError.typeMismatch(
                Mixsample.self,
                DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Mixsample"))
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .double(let x):
                try container.encode(x)
            case .string(let x):
                try container.encode(x)
            }
        }
    }

    enum OutcomeElement: Serializable {
        case double(Double)
        case enumeration(OutcomeEnum)

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let x = try? container.decode(Double.self) {
                self = .double(x)
                return
            }
            if let x = try? container.decode(OutcomeEnum.self) {
                self = .enumeration(x)
                return
            }
            throw DecodingError.typeMismatch(
                OutcomeElement.self,
                DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for OutcomeElement")
            )
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .double(let x):
                try container.encode(x)
            case .enumeration(let x):
                try container.encode(x)
            }
        }
    }

    enum OutcomeEnum: String, Serializable {
        case exit = "exit"
        case invalid = "invalid"
        case valid = "valid"
    }

    enum SamplingElement: Serializable {
        case integer(Int)
        case samplingClass(SamplingClass)

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let x = try? container.decode(Int.self) {
                self = .integer(x)
                return
            }
            if let x = try? container.decode(SamplingClass.self) {
                self = .samplingClass(x)
                return
            }
            throw DecodingError.typeMismatch(
                SamplingElement.self,
                DecodingError.Context(
                    codingPath: decoder.codingPath, debugDescription: "Wrong type for SamplingElement"))
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .integer(let x):
                try container.encode(x)
            case .samplingClass(let x):
                try container.encode(x)
            }
        }
    }

    struct SamplingClass: Serializable {
        let invalid, precondition, unknown, valid: Double
    }

}
