import UIKit
import CoreData

struct BirthdayInfo {
    let id: UUID
    let name: String
    let surname: String
    let birthday: Date
    
    init(
        id: UUID,
        name: String,
        surname: String,
        birthday: Date
    ) {
        self.id = id
        self.name = name
        self.surname = surname
        self.birthday = birthday
    }
    
    init(birtdayModel: BirthdayModel) {
        self.id = birtdayModel.id
        self.name = birtdayModel.name
        self.surname = birtdayModel.surname
        self.birthday = birtdayModel.birthday
    }
    
    func convertToBirthdayModel(with context: NSManagedObjectContext) -> BirthdayModel {
        let birthdayModel = BirthdayModel(context: context)
        birthdayModel.id = id
        birthdayModel.name = name
        birthdayModel.surname = surname
        birthdayModel.birthday = birthday
        return birthdayModel
    }
}
