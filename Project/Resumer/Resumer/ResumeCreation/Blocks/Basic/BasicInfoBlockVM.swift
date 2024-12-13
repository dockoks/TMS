//
//  BasicInfoBlockVM.swift
//  Resumer
//
//  Created by Danila Kokin on 12/3/24.
//

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
}
