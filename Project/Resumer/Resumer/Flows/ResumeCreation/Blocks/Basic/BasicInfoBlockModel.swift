import SwiftUI

struct BasicInfoModel: Codable {
    let avatar: Data?
    let name: String
    let surname: String
    let jobTitle: String
    
    init(from viewModel: BasicInfoBlockVM) {
        self.avatar = viewModel.avatar?.toData()
        self.name = viewModel.name
        self.surname = viewModel.surname
        self.jobTitle = viewModel.jobTitle
    }
}
