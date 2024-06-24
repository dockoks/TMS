import Foundation

// MARK: 1.Создать enum с временами года.

enum Season {
    case spring
    case summer
    case autumn
    case winter
}

var currentSeason: Season = .summer

// MARK: 2.Написать функцию, которая будет принимать номер месяца (Int) и возвращать enum с временем года этого месяца.

func getSeason(month number: Int) -> Season {
    assert(number >= 0 && number <= 12, "Invalid month number")
    return switch number {
    case 1...2, 12: .winter
    case 3...5: .spring
    case 6...8: .summer
    case 9...11: .autumn
    default: .summer
    }
}

// MARK: 3.Написать метод, который принимает variadic parameter String?. Метод возвращает количество nil объектов и печатает в консоль одну строку всех объединенных не nil объектов.

func getSringsStats(strings: String?...) -> Int {
    var counter = 0
    var nonNilStrings = String()
    
    for str in strings {
        if let str = str {
            nonNilStrings += str
        } else {
            counter += 1
        }
    }
    print(nonNilStrings)
    return counter
}

getSringsStats(strings: "Hello", nil, nil, ",", nil, " ", "world!")
