import Foundation
import FirebaseFirestore


struct EducationTileModel: Codable, Identifiable {
    let id: String
    let affiliation: String
    let specialisation: String
    let degree: String
    let startDate: Timestamp
    let endDate: Timestamp?
    let isPresent: Bool
    let description: String
    
    init(from viewModel: EducationTileVM) {
        self.id = viewModel.id
        self.affiliation = viewModel.affiliation
        self.specialisation = viewModel.specialisation
        self.degree = viewModel.degree.rawValue
        self.startDate = Timestamp(date: viewModel.startDate)
        self.isPresent = viewModel.isPresent
        self.description = viewModel.description
        
        if let endDate = viewModel.endDate {
            self.endDate = Timestamp(date: endDate)
        } else {
            self.endDate = nil
        }
    }
}
