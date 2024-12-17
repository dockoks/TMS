import SwiftUI

enum Degree: String, Identifiable, Codable, CaseIterable {
    case undergraduate = "UG"
    case postgraduate = "PG"
    case doctoral = "DOC"
    case other = "Other"
    
    var id: String { rawValue.capitalized }
}

enum ProfficiencyLevel: String, Codable, CaseIterable {
    case a1, a2
    case b1, b2
    case c1, c2
    case native
}
