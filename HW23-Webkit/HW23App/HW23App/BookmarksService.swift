import Foundation

protocol BookmarksService: AnyObject {
    var urls: [String] { get }
    
    func add(url: String) -> Void
    
    func remove(url: String) -> Void
    
    func contains(url: String) -> Bool
}

final class BookmarksServiceImpl: BookmarksService {
    internal var urls: [String] = []
    
    func add(url: String) {
        if !urls.contains(url) {
            urls.append(url)
        }
    }
    
    func remove(url: String) {
        urls.removeAll { $0 == url }
    }
    
    func contains(url: String) -> Bool {
        return urls.contains(url)
    }
}
