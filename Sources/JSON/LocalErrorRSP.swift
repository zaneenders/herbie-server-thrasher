import Foundation

struct LocalErrorRSP: Codable {
    let command, job, path: String
    let tree: Tree
}

struct Tree: Codable {
    let actualValue: [String]
    let avgError: String
    let children: [Tree]
    let e: String
    let exactValue: [String]

    enum CodingKeys: String, CodingKey {
        case actualValue = "actual-value"
        case avgError = "avg-error"
        case children, e
        case exactValue = "exact-value"
    }
}
