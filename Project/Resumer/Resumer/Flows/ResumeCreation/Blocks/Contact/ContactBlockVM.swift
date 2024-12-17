import SwiftUI
import Combine

class ContactBlockVM: ObservableObject, Fillable {
    @Published var email: String
    @Published var phone: String
    @Published var address: String
    @Published var additionalLinks: [Link]
    @Published var isPhoneValid: Bool = true
    
    init(
        email: String = "",
        phone: String = "",
        address: String = "",
        additionalLinks: [Link] = []
    ) {
        self.email = email
        self.phone = phone
        self.address = address
        self.additionalLinks = additionalLinks
        
        validatePhone()
    }
    
    init(from model: ContactBlockModel) {
        self.email = model.email
        self.phone = model.phone
        self.address = model.address
        self.additionalLinks = model.additionalLinks
    }
    
    // MARK: - Computed Properties
    var isFilled: Bool {
        !email.isEmpty &&
        !phone.isEmpty &&
        !address.isEmpty &&
        !additionalLinks.isEmpty &&
        isPhoneValid
    }
    
    var isEmailValid: Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    // MARK: - Methods
    func addLink() {
        let existingKeys = Set(additionalLinks.map { $0.key })
        let availableKeys = LinkDomain.allCases.filter { !existingKeys.contains($0) }
        
        if let newKey = availableKeys.first {
            additionalLinks.append(Link(key: newKey, value: ""))
        } else {
            let fallbackKey = LinkDomain.allCases[additionalLinks.count % LinkDomain.allCases.count]
            additionalLinks.append(Link(key: fallbackKey, value: ""))
        }
    }
    
    func changeLinkDomain(by id: String) {
        guard let index = additionalLinks.firstIndex(where: { $0.id == id }) else { return }
        let currentKey = additionalLinks[index].key
        let allKeys = LinkDomain.allCases
        if let currentIndex = allKeys.firstIndex(of: currentKey) {
            let nextKey = allKeys[(currentIndex + 1) % allKeys.count]
            additionalLinks[index].key = nextKey
        }
    }
    
    func removeLink(by id: String) {
        additionalLinks.removeAll { $0.id == id }
    }
    
    private func validatePhone() {
        $phone
            .map { phone in
                let phoneRegex = "^[+]?[0-9]{10,15}$"
                return NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: phone)
            }
            .assign(to: &$isPhoneValid)
    }
}

extension ContactBlockVM: Uploadable {
    func toModel() -> ContactBlockModel {
        return ContactBlockModel(from: self)
    }
}
