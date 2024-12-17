import SwiftUI


class WorkTileVM: ObservableObject, Identifiable, Fillable {
    @Published var company: String
    @Published var position: String
    @Published var startDate: Date
    @Published var endDate: Date?
    @Published var isPresent: Bool
    @Published var description: String
    let id: String
    
    init(
        company: String = "",
        position: String = "",
        startDate: Date = Date(),
        endDate: Date? = nil,
        isPresent: Bool = false,
        description: String = ""
    ) {
        self.id = UUID().uuidString
        self.company = company
        self.position = position
        self.startDate = startDate
        self.endDate = endDate
        self.isPresent = isPresent
        self.description = description
    }
    
    init(from model: WorkTileModel) {
        self.id = model.id
        self.company = model.company
        self.position = model.position
        self.startDate = model.startDate.dateValue()
        self.endDate = model.endDate?.dateValue()
        self.isPresent = model.isPresent
        self.description = model.description
    }
    
    var isFilled: Bool {
        return !company.isEmpty &&
        !position.isEmpty &&
        (isPresent ? (startDate <= Date()) : (startDate < endDate ?? Date()))
    }
}
