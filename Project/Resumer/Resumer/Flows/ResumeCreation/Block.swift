import SwiftUI


enum Block: CaseIterable {
    case template
    case basic
    case contact
    case education
    case work
    case skill
    case language
    case preview
    
    var displayName: String {
        return switch self {
        case .template: "Template"
        case .basic: "Basic Info"
        case .contact: "Contacts"
        case .education: "Education"
        case .work: "Work"
        case .skill: "Skills"
        case .language: "Languages"
        case .preview: "Preview"
        }
    }
    
    var icon: Image {
        return switch self {
        case .template: Image(systemName: "paintpalette.fill")
        case .basic: Image(systemName: "person.fill")
        case .contact: Image(systemName: "phone.fill")
        case .education: Image(systemName: "graduationcap.fill")
        case .work: Image(systemName: "case.fill")
        case .skill: Image(systemName: "theatermask.and.paintbrush.fill")
        case .language: Image(systemName: "globe.europe.africa.fill")
        case .preview: Image(systemName: "text.page.fill")
        }
    }
}
