import Foundation
import FirebaseFirestore


struct WorkTileModel: Codable {
    let id: String
    let company: String
    let position: String
    let startDate: Timestamp
    let endDate: Timestamp?
    let isPresent: Bool
    let description: String
    
    init(from viewModel: WorkTileVM) {
        self.id = viewModel.id
        self.company = viewModel.company
        self.position = viewModel.position
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
