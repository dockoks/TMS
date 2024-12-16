import SwiftUI


class WorkTileVM: ObservableObject, Identifiable {
    @Published var company: String
    @Published var position: String
    @Published var startDate: Date
    @Published var endDate: Date
    @Published var isPresent: Bool
    @Published var description: String?
    let id = UUID()
    
    init(
        company: String = "",
        position: String = "",
        startDate: Date = Date(),
        endDate: Date = Date(),
        isPresent: Bool = false,
        description: String? = nil
    ) {
        self.company = company
        self.position = position
        self.startDate = startDate
        self.endDate = endDate
        self.isPresent = isPresent
        self.description = description
    }
    
    var isFilled: Bool {
        return !company.isEmpty &&
        !position.isEmpty &&
        (isPresent ? (startDate <= Date()) : (startDate < endDate))
    }
}

import FirebaseFirestore

extension WorkTileVM {
    func toDictionary() -> [String: Any] {
        return [
            "id": id.uuidString,
            "company": company,
            "position": position,
            "startDate": Timestamp(date: startDate),
            "endDate": isPresent ? nil : Timestamp(date: endDate),
            "isPresent": isPresent,
            "description": description ?? ""
        ]
    }
}
