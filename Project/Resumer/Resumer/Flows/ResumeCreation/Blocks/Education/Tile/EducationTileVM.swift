import SwiftUI


class EducationTileVM: ObservableObject, Identifiable {
    @Published var affiliation: String
    @Published var specialisation: String
    @Published var degree: Degree
    @Published var startDate: Date
    @Published var endDate: Date
    @Published var isPresent: Bool
    @Published var description: String?
    
    let id = UUID()
    
    init(
        affiliation: String = "",
        specialisation: String = "",
        degree: Degree = .doctoral,
        startDate: Date = Date(),
        endDate: Date = Date(),
        isPresent: Bool = false,
        description: String? = nil
    ) {
        self.affiliation = affiliation
        self.specialisation = specialisation
        self.degree = degree
        self.startDate = startDate
        self.endDate = endDate
        self.isPresent = isPresent
        self.description = description
    }
    
    var isFilled: Bool {
        return !affiliation.isEmpty &&
        !specialisation.isEmpty &&
        (isPresent ? (startDate <= Date()) : (startDate < endDate))
    }
}

import FirebaseFirestore

extension EducationTileVM {
    func toDictionary() -> [String: Any] {
        return [
            "id": id.uuidString, // Firestore-compatible string for UUID
            "affiliation": affiliation,
            "specialisation": specialisation,
            "degree": degree.rawValue, // Assuming `Degree` is RawRepresentable
            "startDate": Timestamp(date: startDate), // Firestore Timestamp
            "endDate": isPresent ? nil : Timestamp(date: endDate), // Firestore Timestamp or nil
            "isPresent": isPresent,
            "description": description ?? "" // Default empty string if nil
        ]
    }
}
