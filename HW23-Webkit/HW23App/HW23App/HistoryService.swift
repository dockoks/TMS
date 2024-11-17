import Foundation

protocol HistoryService: AnyObject {
    var urls: [String] { get }
    
    func add(url: String) -> Void
    
    func remove(url: String) -> Void
}

final class HistoryServiceImpl: HistoryService {
    internal var urls: [String] = []
    
    func add(url: String) {
        urls.append(url)
    }
    
    func remove(url: String) {
        urls.removeAll { $0 == url }
    }
}
