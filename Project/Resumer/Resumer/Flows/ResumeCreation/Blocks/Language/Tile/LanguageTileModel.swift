import Foundation


struct LanguageTileModel: Codable {
    let id: String
    let name: String
    let proficiency: String
    
    init(from viewModel: LanguageTileVM) {
        self.id = viewModel.id
        self.name = viewModel.name
        self.proficiency = viewModel.proficiency.rawValue
    }
}
