//
//  Models.swift
//  Resumer
//
//  Created by Danila Kokin on 11/28/24.
//

import SwiftUI

struct Template: Codable {
    let id: String
}

struct BasicInfoBlock: Codable {
    let avatar: Data?
    let name: String
    let surname: String
    let jobTitle: String
}

struct ContactInfoBlock: Codable {
    let email: String
    let phoneNumber: String
    let address: String
    let additionalLinks: [Link]
}

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
    var id: UUID
    var key: LinkDomain
    var value: String
    
    init(
        id: UUID = UUID(),
        key: LinkDomain,
        value: String
    ) {
        self.id = id
        self.key = key
        self.value = value
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "id": id.uuidString,
            "key": key.rawValue,
            "value": value
        ]
    }
}

enum Degree: String, Identifiable, Codable, CaseIterable {
    case undergraduate = "UG"
    case postgraduate = "PG"
    case doctoral = "DOC"
    case other = "Other"
    
    var id: String { rawValue.capitalized }
}

struct Education: Codable {
    let affiliation: String
    let specialisation: String
    let degree: Degree
    let startDate: Date
    let endDate: Date
    let isPresent: Bool
    let description: String
}

struct EducationBlock: Codable {
    let education: [Education]
}

struct WorkExperiance: Codable {
    let company: String
    let position: String
    let startDate: Date
    let endDate: Date
    let isPresent: Bool
    let description: String
}

struct WorkBlock: Codable {
    let workExperiance: [WorkExperiance]
}

struct SkillBlock: Codable {
    let skills: [String]
}

enum ProfficiencyLevel: String, Codable, CaseIterable {
    case a1, a2
    case b1, b2
    case c1, c2
    case native
}

struct Language: Codable {
    let name: String
    let level:ProfficiencyLevel
}

struct LanguageBlock: Codable {
    let languages: [Language]
}

struct Profile: Codable {
    let basicInfoBlock: BasicInfoBlock?
    let contactInfoBlock: ContactInfoBlock?
    let educationBlock: EducationBlock?
    let workBlock: WorkBlock?
    let skillBlock: SkillBlock?
    let languageBlock: LanguageBlock?
}

struct ResumeInstance: Codable, Identifiable {
    let id: UUID
    let template: Template?
    let profile: Profile?
    let createdAt: Date
}
