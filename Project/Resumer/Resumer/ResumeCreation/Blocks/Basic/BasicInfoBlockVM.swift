//
//  BasicInfoBlockVM.swift
//  Resumer
//
//  Created by Danila Kokin on 12/3/24.
//

import SwiftUI

class BasicInfoBlockVM: ObservableObject {
    @Published var avatar: Image?
    @Published var name: String
    @Published var surname: String
    @Published var jobTitle: String
    
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
    }
    
    var isFilled: Bool {
        return !(name.isEmpty || surname.isEmpty || jobTitle.isEmpty)
    }
}
