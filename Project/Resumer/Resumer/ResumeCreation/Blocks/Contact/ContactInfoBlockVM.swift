//
//  BasicInfoBlockVM 2.swift
//  Resumer
//
//  Created by Danila Kokin on 12/3/24.
//


import SwiftUI

class ContactInfoBlockVM: ObservableObject {
    @Published var email: String
    @Published var phone: String
    @Published var address: String
    @Published var additionalLinks: [Link]
    
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
    }
    
    var isFilled: Bool {
        return !(email.isEmpty || phone.isEmpty || address.isEmpty || additionalLinks.isEmpty) && isPhoneValid
    }
    
    var isPhoneValid: Bool {
        let phoneRegex = "^[+]?[0-9]{10,15}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phone)
    }
    
    var isEmailValid: Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
}
