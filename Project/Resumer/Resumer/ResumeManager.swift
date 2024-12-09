//
//  ResumeManager.swift
//  Resumer
//
//  Created by Danila Kokin on 12/2/24.
//

import SwiftUI

class ResumeManager: ObservableObject {
    @Published var resumes: [ResumeInstance] = []
}
