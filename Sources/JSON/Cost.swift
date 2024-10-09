import Foundation

struct CostRSP: Codable {
    let command: String
    let cost: Int
    let job, path: String
}
