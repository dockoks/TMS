import UIKit

// MARK: 1. Написать функцию, которая:
// - Будет просто выводить в консоль ”Hello, world!”.
// - Будет принимать аргумент “имя” и выводить в консоль “Hello, имя” (вызов функции должен быть следующим - printHi(“Misha”)).
// - Будет принимать аргумент имя и возвращать строку приветствия “Hello! имя”.
func printHelloWorld() {
    print("Hello, world!")
}

func printHi(_ name: String) {
    print("Hello, \(name)")
}

func helloString(_ name: String) -> String {
    return "Hello, \(name)!"
}

// MARK: 2. Написать функцию, которая принимает две строки и возвращает сумму количества символов двух строк.
func sumOfStrings(_ str1: String, _ str2: String) -> Int {
    return str1.count + str2.count
}

// MARK: 3. Написать функцию, которая выводит в консоль квадрат переданного числа.
func printSquare(of number: Int) {
    print(number * number)
}

// MARK: 4. Создать функции, которые будут суммировать, вычитать, умножать и делить числа sum(num1:num2:).
func sum(num1: Int, num2: Int) -> Int {
    return num1 + num2
}

func subtract(num1: Int, num2: Int) -> Int {
    return num1 - num2
}

func multiply(num1: Int, num2: Int) -> Int {
    return num1 * num2
}

func divide(num1: Int, num2: Int) -> Int {
    if num2 != 0 {
        return num1 / num2
    } else {
        print("Division by zero is not allowed.")
        return 0
    }
}

// MARK: 5. Создать функцию, которая принимает параметры и вычисляет площадь круга.
func getCircleArea(_ radius: Int) -> Double {
    return 3.14 * Double(radius) * Double(radius)
}

// MARK: 6. Создать функцию, которая принимает логический тип “ночь ли сегодня” и возвращает строку с описанием времени суток.
func describeEnvironment(_ isNight: Bool) -> String {
    if isNight {
        return "Currently its night"
    }
    return "Currently its day"
}

// MARK: 7. Создать функцию, принимающую 1 аргумент — число от 0 до 100, и возвращающую true, если оно простое, и false, если сложное.
func isPrime(_ number: Int) -> Bool {
    assert(number > 0, "Invalid input")
    if number <= 3 { return true }
    if number % 2 == 0 || number % 3 == 0 { return false }
    
    var i = 5
    while i * i <= number { // Up to sq root of number
        if number % i == 0 {
            return false
        }
        i += 1
    }
    return true
}

// MARK: 8. Создать функцию, принимающую 1 аргумент — номер месяца (от 1 до 12), и возвращающую время года, которому этот месяц принадлежит (зима, весна, лето или осень).
func getSeason(month number: Int) -> String {
    switch number {
    case 1...2, 12: return "Winter"
    case 3...5: return "Spring"
    case 6...8: return "Summer"
    case 9...11: return "Autumn"
    default: return "Incorrect input"
    }
}

// MARK: 9*. Создать функцию, которая считает факториал введённого числа.
func factorize(_ n: Int) -> Int {
    // corner case handling
    if n < 0 { return 0 }
    var factorial = 1
    for i in 1...n {
        factorial *= i
    }
    return factorial
}

// recursive option
func factorizeRecursive(_ n: Int) -> Int {
    // corner case handling
    if n < 0 {
        return 0
    } else if n == 0 {
        return 1
    } else {
        return n * factorizeRecursive(n - 1)
    }
}

// MARK: 10*. Создать функцию, которая выводит все числа последовательности Фибоначчи до введённого индекса. Например fib(n:6) -> 0, 1, 1, 2, 3, 5, 8
func getFibSequence(_ n: Int) -> [Int] {
    var a = 0
    var b = 1
    var sequence = [Int]()

    for _ in 0...n {
        sequence.append(a)
        (a, b) = (b, a + b)
    }

    return sequence
}

// recursive option
func getFibSequenceRecursive(_ n: Int) -> [Int] {
    func fib(_ k: Int) -> Int {
        if k <= 1 {
            return k
        }
        return fib(k - 1) + fib(k - 2)
    }
    
    return (0...n).map { fib($0) }
}
// MARK: 11*. Создать функцию, которая считает сумму цифр четырехзначного числа, переданного в параметры функции
func sumOfDigits(_ number: Int) -> Int {
    let digits = String(abs(number))
    return digits.reduce(0) { $0 + (Int(String($1)) ?? 0) }
}
