//
//  WorkTileVM.swift
//  Resumer
//
//  Created by Danila Kokin on 12/5/24.
//

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
