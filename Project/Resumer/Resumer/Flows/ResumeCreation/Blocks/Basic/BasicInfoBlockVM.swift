import SwiftUI


protocol Fillable {
    var isFilled: Bool { get }
}

protocol Uploadable {
    associatedtype UploadableModel: Codable
    func toModel() -> UploadableModel
//    func toDictionary() -> [String: Any]
}

class BasicInfoBlockVM: ObservableObject, Fillable, Uploadable {
    @Published var avatar: Image?
    @Published var name: String
    @Published var surname: String
    @Published var jobTitle: String
    
    @Published private(set) var isFilled: Bool = false
    
    init () {
        self.name = ""
        self.surname = ""
        self.jobTitle = ""
    }
    
    init(
        from model: BasicInfoModel
    ) {
        self.avatar = model.avatar?.toImage()
        self.name = model.name
        self.surname = model.surname
        self.jobTitle = model.jobTitle
        updateIsFilled()
    }
    
    private func updateIsFilled() {
        isFilled = !(name.isEmpty || surname.isEmpty || jobTitle.isEmpty)
    }
    
    func toDictionary() -> [String: Any] {
        var dictionary: [String: Any] = [
            "name": name,
            "surname": surname,
            "jobTitle": jobTitle
        ]
        return dictionary
    }
    
    func toModel() -> BasicInfoModel {
        return BasicInfoModel(from: self)
    }
}

