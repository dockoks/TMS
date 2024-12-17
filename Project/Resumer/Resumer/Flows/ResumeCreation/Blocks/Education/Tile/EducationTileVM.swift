import SwiftUI
import FirebaseFirestore


class EducationTileVM: ObservableObject, Identifiable, Fillable {
    @Published var affiliation: String
    @Published var specialisation: String
    @Published var degree: Degree
    @Published var startDate: Date
    @Published var endDate: Date?
    @Published var isPresent: Bool
    @Published var description: String
    let id: String
    
    init(
        affiliation: String = "",
        specialisation: String = "",
        degree: Degree = .undergraduate,
        startDate: Date = Date(),
        endDate: Date? = nil,
        isPresent: Bool = false,
        description: String = ""
    ) {
        self.id = UUID().uuidString
        self.affiliation = affiliation
        self.specialisation = specialisation
        self.degree = degree
        self.startDate = startDate
        self.endDate = endDate
        self.isPresent = isPresent
        self.description = description
    }
    
    init(from model: EducationTileModel) {
        self.id = model.id
        self.affiliation = model.affiliation
        self.specialisation = model.specialisation
        self.degree = Degree(rawValue: model.degree) ?? .undergraduate
        self.startDate = model.startDate.dateValue()
        self.endDate = model.endDate?.dateValue()
        self.isPresent = model.isPresent
        self.description = model.description
    }
    
    var isFilled: Bool {
        return !affiliation.isEmpty &&
        !specialisation.isEmpty &&
        (endDate == nil && isPresent ? (startDate <= Date()) : (startDate < endDate ?? Date()))
    }
}

extension EducationTileVM: Uploadable {
    func toModel() -> EducationTileModel {
        return EducationTileModel(from: self)
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "affiliation": affiliation,
            "specialisation": specialisation,
            "degree": degree.rawValue,
            "startDate": Timestamp(date: startDate),
            "endDate": isPresent ? nil : Timestamp(date: endDate ?? Date()),
            "isPresent": isPresent,
            "description": description
        ]
    }
}
