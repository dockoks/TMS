import Foundation

enum LinkDomain: String, Codable, CaseIterable {
    case github
    case linkedIn
    case twitter
    case instagram
    case website
    
    var icon: RIcon {
        return switch self {
        case .github: .link
        case .linkedIn: .link
        case .twitter: .link
        case .instagram: .link
        case .website: .link
        }
    }
}

struct Link: Codable, Identifiable {
    var id: String
    var key: LinkDomain
    var value: String
    
    init(
        id: UUID = UUID(),
        key: LinkDomain,
        value: String
    ) {
        self.id = id.uuidString
        self.key = key
        self.value = value
    }
}

struct ContactBlockModel: Codable {
    let email: String
    let phone: String
    let address: String
    let additionalLinks: [Link]
    
    init(from viewModel: ContactBlockVM) {
        self.email = viewModel.email
        self.phone = viewModel.phone
        self.address = viewModel.address
        self.additionalLinks = viewModel.additionalLinks
    }
}
