import UIKit
import UserNotifications

protocol NotificationProtocol {
    func schedule(birthday: BirthdayInfo)
    func reschedule(birthday: BirthdayInfo)
    func unschedule(by id: UUID)
}

final class NotificationService: NotificationProtocol {
    static let shared = NotificationService()
    
    private init() {
        checkForPermission()
    }
    
    private func checkForPermission() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .authorized: return
            case .denied: return
            case .notDetermined: self.requestNotificationAuthorization()
            default:
                return
            }
        }
    }
    
    private func requestNotificationAuthorization() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Error requesting notification authorization: \(error)")
            } else if granted {
                print("Notification permission granted")
            } else {
                print("Notification permission denied")
            }
        }
    }
    
    func schedule(birthday: BirthdayInfo) {
        let content = UNMutableNotificationContent()
        content.title = NSLocalizedString("birthday_title", comment: "Title for birthday notification")
        content.body = String(format: NSLocalizedString("birthday_message", comment: ""), birthday.name, birthday.surname)
        content.sound = .default

        guard let oneDayBeforeBirthday = Calendar.current.date(byAdding: .day, value: -1, to: birthday.birthday) else { return }
        var dateComponents = Calendar.current.dateComponents([.month, .day], from: oneDayBeforeBirthday)
        dateComponents.hour = 9
        dateComponents.minute = 0

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let requestIdentifier = birthday.id.uuidString
        let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            } else {
                print("Notification scheduled for \(birthday.name) \(birthday.surname)")
            }
        }
    }
    
    func reschedule(birthday: BirthdayInfo) {
        unschedule(by: birthday.id)
        schedule(birthday: birthday)
    }
    
    func unschedule(by id: UUID) {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [id.uuidString])
        notificationCenter.removeDeliveredNotifications(withIdentifiers: [id.uuidString])
        print("Notification unscheduled for ID: \(id.uuidString)")
    }
}
