import UIKit
import CoreData

protocol BirthdayStorageProtocol {
    func fetchBirthdayModels() -> [BirthdayInfo]
    func getBirthday(by id: UUID) -> BirthdayInfo?
    func deleteBirthday(by id: UUID)
    func addBirthday(_ birthdayInfo: BirthdayInfo)
    func editBirthday(_ birthdayInfo: BirthdayInfo)
}

final class CoreDataStorage: BirthdayStorageProtocol {
    static let shared = CoreDataStorage()
    
    var appDelegate: AppDelegate? {
        UIApplication.shared.delegate as? AppDelegate
    }
    
    var coreDataContext: NSManagedObjectContext? {
        appDelegate?.persistentContainer.viewContext
    }
    
    private init() {}
    
    func fetchBirthdayModels() -> [BirthdayInfo] {
        let request = BirthdayModel.fetchRequest()
        do {
            let birthdays = try coreDataContext?.fetch(request)
            return birthdays?.map { .init(birtdayModel: $0) } ?? []
        } catch {
            print("Error fetching birthday models: \(error)")
            return []
        }
    }
    
    func getBirthday(by id: UUID) -> BirthdayInfo? {
        let request = BirthdayModel.fetchRequest()
        request.fetchLimit = 1
        request.predicate = NSPredicate(format: "id = %@", argumentArray: [id])
        do {
            let birthdays = try coreDataContext?.fetch(request)
            return birthdays?.first.map { .init(birtdayModel: $0) }
        } catch {
            print("Error fetching birthday by id \(id): \(error)")
            return nil
        }
    }
    
    func deleteBirthday(by id: UUID) {
        guard let coreDataContext else { return }
        
        let request: NSFetchRequest<BirthdayModel> = BirthdayModel.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", argumentArray: [id])
        do {
            let results = try coreDataContext.fetch(request)
            if let birthdayToDelete = results.first {
                coreDataContext.delete(birthdayToDelete)
                try coreDataContext.save()
            }
        } catch {
            print("Error deleting birthday: \(error)")
        }
    }
    
    func addBirthday(_ birthdayInfo: BirthdayInfo) {
        guard let coreDataContext else { return }
        _ = birthdayInfo.convertToBirthdayModel(with: coreDataContext)
        do {
            try coreDataContext.save()
        } catch {
            print("Error adding birthday: \(error)")
        }
    }
    
    func editBirthday(_ birthdayInfo: BirthdayInfo) {
        guard let coreDataContext else { return }
        
        let request = BirthdayModel.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", argumentArray: [birthdayInfo.id])
        do {
            let results = try coreDataContext.fetch(request)
            if let birthdayToEdit = results.first {
                birthdayToEdit.name = birthdayInfo.name
                birthdayToEdit.surname = birthdayInfo.surname
                birthdayToEdit.birthday = birthdayInfo.birthday
                try coreDataContext.save()
            }
        } catch {
            print("Error editing birthday: \(error)")
        }
    }
}
