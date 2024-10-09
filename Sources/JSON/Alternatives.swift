import Foundation

// TODO fix generated code

struct AlternativesRSP: Codable {
    let alternatives: [String]
    let command: String
    let derivations: [Derivation]
    let histories: [String]
    let job, path: String
    let splitpoints: [[[Double]]]
}

struct Derivation: Codable {
    let error: Double
    let preprocessing: [JSONAny]
    let prev: DerivationPrev
    let program: String
    let trainingError: Double
    let type: DerivationType

    enum CodingKeys: String, CodingKey {
        case error, preprocessing, prev, program
        case trainingError = "training-error"
        case type
    }
}

struct DerivationPrev: Codable {
    let error: Double
    let prev: PurplePrev
    let program: String
    let trainingError: Double
    let type: PurpleType
    let loc: [JSONAny]?
    let proof: [FluffyProof]?

    enum CodingKeys: String, CodingKey {
        case error, prev, program
        case trainingError = "training-error"
        case type, loc, proof
    }
}

struct PurplePrev: Codable {
    let conditions: [[String]]?
    let prevs: [PrevElement]?
    let program: String
    let type: DerivationType
    let error: ErrorUnion?
    let loc: [Int]?
    let prev: FluffyPrev?
    let proof: [FluffyProof]?
    let trainingError: ErrorUnion?
    let preprocessing: [JSONAny]?
    let pt, prevVar: String?

    enum CodingKeys: String, CodingKey {
        case conditions, prevs, program, type, error, loc, prev, proof
        case trainingError = "training-error"
        case preprocessing, pt
        case prevVar = "var"
    }
}

enum ErrorUnion: Codable {
    case double(Double)
    case enumeration(ErrorEnum)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(ErrorEnum.self) {
            self = .enumeration(x)
            return
        }
        throw DecodingError.typeMismatch(
            ErrorUnion.self,
            DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ErrorUnion"))
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

enum ErrorEnum: String, Codable {
    case nA = "N/A"
}

struct FluffyPrev: Codable {
    let error: ErrorUnion
    let loc: [Int]?
    let prev: TentacledPrev?
    let program: String
    let proof: [PurpleProof]?
    let trainingError: ErrorUnion
    let type: DerivationType
    let pt: Pt?
    let prevVar: String?
    let preprocessing: [[String]]?

    enum CodingKeys: String, CodingKey {
        case error, loc, prev, program, proof
        case trainingError = "training-error"
        case type, pt
        case prevVar = "var"
        case preprocessing
    }
}

struct TentacledPrev: Codable {
    let error: ErrorUnion
    let loc: [Int]?
    let prev: StickyPrev?
    let program: String
    let pt: Pt?
    let trainingError: ErrorUnion
    let type: DerivationType
    let prevVar: String?
    let proof: [PurpleProof]?

    enum CodingKeys: String, CodingKey {
        case error, loc, prev, program, pt
        case trainingError = "training-error"
        case type
        case prevVar = "var"
        case proof
    }
}

struct StickyPrev: Codable {
    let error: ErrorUnion
    let loc: [Int]
    let prev: IndigoPrev
    let program: String
    let proof: [PurpleProof]?
    let trainingError: ErrorUnion
    let type: DerivationType
    let pt: Pt?
    let prevVar: FluffyVar?

    enum CodingKeys: String, CodingKey {
        case error, loc, prev, program, proof
        case trainingError = "training-error"
        case type, pt
        case prevVar = "var"
    }
}

struct IndigoPrev: Codable {
    let error: ErrorUnion
    let loc: [Int]
    let prev: IndecentPrev
    let program: String
    let pt: Pt?
    let trainingError: ErrorUnion
    let type: DerivationType
    let prevVar: FluffyVar?
    let proof: [PurpleProof]?

    enum CodingKeys: String, CodingKey {
        case error, loc, prev, program, pt
        case trainingError = "training-error"
        case type
        case prevVar = "var"
        case proof
    }
}

struct IndecentPrev: Codable {
    let error: ErrorUnion
    let loc: [JSONAny]
    let prev: HilariousPrev
    let program: String
    let proof: [PurpleProof]?
    let trainingError: ErrorUnion
    let type: DerivationType
    let pt: Pt?
    let prevVar: PurpleVar?

    enum CodingKeys: String, CodingKey {
        case error, loc, prev, program, proof
        case trainingError = "training-error"
        case type, pt
        case prevVar = "var"
    }
}

struct HilariousPrev: Codable {
    let error: ErrorUnion
    let loc: [JSONAny]?
    let prev: AmbitiousPrev?
    let program: String
    let pt: String?
    let trainingError: ErrorUnion
    let type: DerivationType
    let prevVar: PurpleVar?
    let preprocessing: [JSONAny]?

    enum CodingKeys: String, CodingKey {
        case error, loc, prev, program, pt
        case trainingError = "training-error"
        case type
        case prevVar = "var"
        case preprocessing
    }
}

struct AmbitiousPrev: Codable {
    let error: Double
    let preprocessing: [[String]]?
    let prev: CunningPrev?
    let program: String
    let trainingError: Double
    let type: DerivationType

    enum CodingKeys: String, CodingKey {
        case error, preprocessing, prev, program
        case trainingError = "training-error"
        case type
    }
}

struct CunningPrev: Codable {
    let error: Double
    let program: String
    let trainingError: Double
    let type: DerivationType

    enum CodingKeys: String, CodingKey {
        case error, program
        case trainingError = "training-error"
        case type
    }
}

enum DerivationType: String, Codable {
    case addPreprocessing = "add-preprocessing"
    case regimes = "regimes"
    case rr = "rr"
    case start = "start"
    case taylor = "taylor"
}

enum PurpleVar: String, Codable {
    case r = "r"
    case y5 = "y5"
}

struct PurpleProof: Codable {
    let direction: Direction
    let error: ErrorEnum
    let loc: [JSONAny]
    let program: String
    let rule: Rule
    let tag: Tag
}

enum Direction: String, Codable {
    case goal = "goal"
    case ltr = "ltr"
}

enum Rule: String, Codable {
    case associateR = "associate-*r*"
    case commutative = "*-commutative"
    case distributeLftOut = "distribute-lft-out"
    case f = "#f"
    case fluffyLowerF64 = "lower-+.f64"
    case lowerF64 = "lower-*.f64"
    case lowerFabsF64 = "lower-fabs.f64"
    case lowerFmaF64 = "lower-fma.f64"
    case lowerNegF64 = "lower-neg.f64"
    case lowerSqrtF64 = "lower-sqrt.f64"
    case metadataEval = "metadata-eval"
    case mul1Neg = "mul-1-neg"
    case purpleLowerF64 = "lower--.f64"
    case ruleCommutative = "+-commutative"
    case ruleLowerF64 = "lower-/.f64"
    case subNeg = "sub-neg"
}

enum Tag: String, Codable {
    case nANA = " ↑ N/A ↓ N/A"
    case the00 = " ↑ 0 ↓ 0"
}

enum Pt: String, Codable {
    case inf = "inf"
}

enum FluffyVar: String, Codable {
    case p = "p"
    case r = "r"
    case y2 = "y2"
}

struct PrevElement: Codable {
    let error: Double
    let loc: [Int]?
    let prev: MagentaPrev
    let program: String
    let proof: [FluffyProof]?
    let trainingError: Double
    let type: DerivationType
    let preprocessing: [JSONAny]?

    enum CodingKeys: String, CodingKey {
        case error, loc, prev, program, proof
        case trainingError = "training-error"
        case type, preprocessing
    }
}

struct MagentaPrev: Codable {
    let error: ErrorUnion
    let loc: [Int]?
    let prev: FriskyPrev?
    let program: String
    let pt: String?
    let trainingError: ErrorUnion
    let type: DerivationType
    let prevVar: String?
    let proof: [PurpleProof]?

    enum CodingKeys: String, CodingKey {
        case error, loc, prev, program, pt
        case trainingError = "training-error"
        case type
        case prevVar = "var"
        case proof
    }
}

struct FriskyPrev: Codable {
    let error: ErrorUnion
    let preprocessing: [[String]]?
    let prev: MischievousPrev
    let program: String
    let trainingError: ErrorUnion
    let type: DerivationType
    let loc: [Int]?
    let proof: [FluffyProof]?
    let pt, prevVar: String?

    enum CodingKeys: String, CodingKey {
        case error, preprocessing, prev, program
        case trainingError = "training-error"
        case type, loc, proof, pt
        case prevVar = "var"
    }
}

struct MischievousPrev: Codable {
    let error: ErrorUnion
    let program: String
    let trainingError: ErrorUnion
    let type: DerivationType
    let loc: [Int]?
    let prev: BraggadociousPrev?
    let pt, prevVar: String?
    let proof: [FluffyProof]?

    enum CodingKeys: String, CodingKey {
        case error, program
        case trainingError = "training-error"
        case type, loc, prev, pt
        case prevVar = "var"
        case proof
    }
}

struct BraggadociousPrev: Codable {
    let error: ErrorUnion
    let preprocessing: [[String]]?
    let prev: Prev1
    let program: String
    let trainingError: ErrorUnion
    let type: DerivationType
    let loc: [Int]?
    let proof: [PurpleProof]?
    let pt: String?
    let prevVar: FluffyVar?

    enum CodingKeys: String, CodingKey {
        case error, preprocessing, prev, program
        case trainingError = "training-error"
        case type, loc, proof, pt
        case prevVar = "var"
    }
}

struct Prev1: Codable {
    let error: ErrorUnion
    let program: String
    let trainingError: ErrorUnion
    let type: DerivationType
    let loc: [JSONAny]?
    let prev: HilariousPrev?
    let pt: Pt?
    let prevVar: TentacledVar?
    let proof: [PurpleProof]?
    let preprocessing: [[String]]?

    enum CodingKeys: String, CodingKey {
        case error, program
        case trainingError = "training-error"
        case type, loc, prev, pt
        case prevVar = "var"
        case proof, preprocessing
    }
}

enum TentacledVar: String, Codable {
    case b = "b"
    case i = "i"
    case y4 = "y4"
    case y5 = "y5"
}

struct FluffyProof: Codable {
    let direction: Direction
    let error: ErrorUnion
    let loc: [Int]
    let program: String
    let rule: Rule
    let tag: Tag
}

enum PurpleType: String, Codable {
    case finalSimplify = "final-simplify"
    case rr = "rr"
}

struct JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        true
    }

    public var hashValue: Int {
        0
    }

    public init() {}

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(
                JSONNull.self,
                DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

struct JSONCodingKey: CodingKey {
    let key: String

    init?(intValue: Int) {
        return nil
    }

    init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        nil
    }

    var stringValue: String {
        key
    }
}

struct JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(
        from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey
    ) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
