import Foundation

struct GeoDTO: Codable {
    let lat: String
    let lng: String
}

struct AddressDTO: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: GeoDTO
}

struct CompanyDTO: Codable {
    let name: String
    let catchPhrase: String
    let bs: String
}

struct UserDTO: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: AddressDTO
    let phone: String
    let website: String
    let company: CompanyDTO
}
