import Foundation
import CoreData


extension BirthdayModel {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<BirthdayModel> {
        return NSFetchRequest<BirthdayModel>(entityName: "BirthdayModel")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var surname: String
    @NSManaged public var birthday: Date

}

extension BirthdayModel : Identifiable { }
