import SwiftUI


protocol Fillable {
    var isFilled: Bool { get }
}

class BasicInfoBlockVM: ObservableObject, Fillable {
    @Published var avatar: Image?
    @Published var name: String {
        didSet { updateIsFilled() }
    }
    @Published var surname: String {
        didSet { updateIsFilled() }
    }
    @Published var jobTitle: String {
        didSet { updateIsFilled() }
    }
    
    @Published private(set) var isFilled: Bool = false // `private(set)` ensures only this class can modify `isFilled`
    
    init(
        avatar: Image? = nil,
        name: String = "",
        surname: String = "",
        jobTitle: String = ""
    ) {
        self.avatar = avatar
        self.name = name
        self.surname = surname
        self.jobTitle = jobTitle
        updateIsFilled() // Initialize `isFilled` based on default values
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
        
        // Convert avatar to Base64 string if available
        guard let avatar = avatar else { return dictionary }
        
        let uiImage = ImageToUIImageConverter(image: avatar).asUIImage()
        
        guard let imageData = uiImage.jpegData(compressionQuality: 0.8) else { return dictionary }
        
        let base64String = imageData.base64EncodedString()
        dictionary["avatar"] = base64String
        
        return dictionary
    }
}
