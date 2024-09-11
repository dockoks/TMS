import Foundation

struct Region {
    let name: String
    let cities: [City]
}

struct City {
    let icon: String
    let name: String
    let utcDifference: Double
    
    func currentLocalTime() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        
        let timeZone = TimeZone(secondsFromGMT: Int(utcDifference * 3600))
        formatter.timeZone = timeZone
        
        return formatter.string(from: date)
    }
}

final class RegionFactory {
    static func generateData() -> [Region] {
        // North America
        let newYork = City(icon: "🇺🇸", name: "New York", utcDifference: -5)
        let losAngeles = City(icon: "🇺🇸", name: "Los Angeles", utcDifference: -8)
        let chicago = City(icon: "🇺🇸", name: "Chicago", utcDifference: -6)
        let toronto = City(icon: "🇨🇦", name: "Toronto", utcDifference: -5)
        
        // Europe
        let london = City(icon: "🇬🇧", name: "London", utcDifference: 0)
        let paris = City(icon: "🇫🇷", name: "Paris", utcDifference: 1)
        let berlin = City(icon: "🇩🇪", name: "Berlin", utcDifference: 1)
        let moscow = City(icon: "🇷🇺", name: "Moscow", utcDifference: 3)
        
        // Asia
        let tokyo = City(icon: "🇯🇵", name: "Tokyo", utcDifference: 9)
        let beijing = City(icon: "🇨🇳", name: "Beijing", utcDifference: 8)
        let seoul = City(icon: "🇰🇷", name: "Seoul", utcDifference: 9)
        let mumbai = City(icon: "🇮🇳", name: "Mumbai", utcDifference: 5.5)
        let dubai = City(icon: "🇦🇪", name: "Dubai", utcDifference: 4)
        
        // Australia and Oceania
        let sydney = City(icon: "🇦🇺", name: "Sydney", utcDifference: 10)
        let melbourne = City(icon: "🇦🇺", name: "Melbourne", utcDifference: 10)
        let auckland = City(icon: "🇳🇿", name: "Auckland", utcDifference: 13)
        
        // South America
        let saoPaulo = City(icon: "🇧🇷", name: "São Paulo", utcDifference: -3)
        let buenosAires = City(icon: "🇦🇷", name: "Buenos Aires", utcDifference: -3)
        let lima = City(icon: "🇵🇪", name: "Lima", utcDifference: -5)
        
        // Africa
        let cairo = City(icon: "🇪🇬", name: "Cairo", utcDifference: 2)
        let johannesburg = City(icon: "🇿🇦", name: "Johannesburg", utcDifference: 2)
        let lagos = City(icon: "🇳🇬", name: "Lagos", utcDifference: 1)
        let nairobi = City(icon: "🇰🇪", name: "Nairobi", utcDifference: 3)
        
        // Middle East
        let riyadh = City(icon: "🇸🇦", name: "Riyadh", utcDifference: 3)
        let telAviv = City(icon: "🇮🇱", name: "Tel Aviv", utcDifference: 2)
        let tehran = City(icon: "🇮🇷", name: "Tehran", utcDifference: 3.5)
        
        let northAmerica = Region(name: "North America", cities: [newYork, losAngeles, chicago, toronto])
        let europe = Region(name: "Europe", cities: [london, paris, berlin, moscow])
        let asia = Region(name: "Asia", cities: [tokyo, beijing, seoul, mumbai, dubai])
        let oceania = Region(name: "Australia and Oceania", cities: [sydney, melbourne, auckland])
        let southAmerica = Region(name: "South America", cities: [saoPaulo, buenosAires, lima])
        let africa = Region(name: "Africa", cities: [cairo, johannesburg, lagos, nairobi])
        let middleEast = Region(name: "Middle East", cities: [riyadh, telAviv, tehran])
        
        return [northAmerica, europe, asia, oceania, southAmerica, africa, middleEast]
    }
}
