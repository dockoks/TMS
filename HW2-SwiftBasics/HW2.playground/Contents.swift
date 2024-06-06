// MARK: 1. Создать новый Playground

let separator = String(repeating: String("="), count: 120)
print("\n\(separator)\nTask 1.\n")

import Foundation

// MARK: 2. Написать переменные и константы всех базовых типов данных: Int, Bool, Float, Double, String. У чисел вывести их минимальные и максимальные значения (Int8/16…, UInt…), а у строки – количество символов.

print("\n\(separator)\nTask 2.\n")

var intValue: Int = 42
let boolValue: Bool = true
var floatValue: Float = 3.14
let doubleValue: Double = 3.141592653589793
var stringValue: String = "Hello, Swift!"

print("Int8: min = \(Int8.min), max = \(Int8.max)")
print("UInt8: min = \(UInt8.min), max = \(UInt8.max)")
print("Int16: min = \(Int16.min), max = \(Int16.max)")
print("UInt16: min = \(UInt16.min), max = \(UInt16.max)")
print("Int32: min = \(Int32.min), max = \(Int32.max)")
print("UInt32: min = \(UInt32.min), max = \(UInt32.max)")
print("Int64: min = \(Int64.min), max = \(Int64.max)")
print("UInt64: min = \(UInt64.min), max = \(UInt64.max)")
print("String length: \(stringValue.count) characters")

// MARK: 3. Написать различные выражения с приведением типа. Минимум 8 выражений.

print("\n\(separator)\nTask 3.\n")

// 1. Преобразование Int в Float
let intValue1: Int = 42
let floatValue1: Float = Float(intValue1)
print("Float value: \(floatValue1)")

// 2. Преобразование Float в Int
let floatValue2: Float = 3.14
let шntValue2: Int = Int(floatValue2)
print("Int value: \(шntValue2)")

// 3. Преобразование Int в Double
let doubleValue3: Double = Double(intValue)
print("Double value: \(doubleValue)")

// 4. Преобразование Double в Int
let doubleValue4: Double = 3.99
let шntValue4: Int = Int(doubleValue4)
print("Int value: \(шntValue4)")

// 5. Преобразование String в Int
let stringValue5: String = "123"
if let intFromString = Int(stringValue) {
    print("Int from String: \(intFromString)")
} else {
    print("Conversion failed")
}

// 6. Преобразование Int в String
let stringValue6: String = String(intValue1)
print("String from Int: \(stringValue6)")

// 7. Преобразование String в Double
let stringValue7: String = "123.45"
if let doubleFromString = Double(stringValue7) {
    print("Double from String: \(doubleFromString)")
} else {
    print("Conversion failed")
}

// 8. Преобразование Double в String
let stringValue8: String = String(doubleValue)
print("String from Double: \(stringValue8)")

// MARK: 4. Произвести различные вычисления с математическими операторами (умножение, деление, сложение, вычитание). Выводить результат в консоль в таком виде: 3 + 2 = 5 (использовать интерполяцию строк).

print("\n\(separator)\nTask 4.\n")

let a = 28
let b = 5

let additionResult = a + b
print("\(a) + \(b) = \(additionResult)")

let subtractionResult = a - b
print("\(a) - \(b) = \(subtractionResult)")

let multiplicationResult = a * b
print("\(a) * \(b) = \(multiplicationResult)")

let divisionResult = a / b
print("\(a) / \(b) = \(divisionResult)")

let divisionResult2 = a % b
print("\(a) % \(b) = \(divisionResult2)")

// MARK: 5. С помощью if-else необходимо вывести в консоль, ночь ли сегодня (isNight).

print("\n\(separator)\nTask 5.\n")

func isNight() -> Bool {
    let currentHour = Calendar.current.component(.hour, from: Date())
    return currentHour < 6 || currentHour >= 23
}

func printTime() {
    if isNight() {
        print("Сейчас ночь.")
    } else {
        print("Сейчас не ночь.")
    }
}

printTime()

// MARK: 6. Дана строка, сделать копию этой строки. Вывести копию строки в консоль. Помним, что строка – это коллекция символов, по которым можно "пробегаться". Решение let str2 = str1; print(str2) не принимается.

print("\n\(separator)\nTask 6.\n")

let str1 = "Hello, Swift!"

var str2 = ""
for character in str1 {
    str2.append(character)
}

print("Копия строки: \(str2)")

// MARK: 7*. Сделать проверку: является ли число четным: 13, 2, 20, 21, 76.

print("\n\(separator)\nTask 7.\n")

func isEven(_ number: Int) -> Bool {
    return number % 2 == 0
}

// Проверка каждого числа и вывод результата
func validateNumbers(_ numbers: Array<Int>) {
    for number in numbers {
        if isEven(number) {
            print("\(number) является четным числом.")
        } else {
            print("\(number) является нечетным числом.")
        }
    }
}

validateNumbers([13, 2, 20, 21, 76])

// MARK: 8*. В переменной day лежит какое-то число от 1 до 31 (вы задаете сами любое). Определить, в какую декаду месяца попадает это число (в первую, вторую или третью).

print("\n\(separator)\nTask 8.\n")

let day = 15

let decade: String
switch day {
case 1...10:
    decade = "первая декада"
case 11...20:
    decade = "вторая декада"
case 21...31:
    decade = "третья декада"
default:
    decade = "unknown"
}

// Вывод результата
print("День \(day) попадает в \(decade) месяца.")


// MARK: 9*. Дана строка, состоящая из символов, например, “bbppeeyy”. Проверить, что первым символом этой строки является буква “a” (или любая другая). Если это так – вывести 'да', в противном случае - ‘нет’. Затем поменяйте строку, чтобы условие соблюдалось. Поэкспериментируйте с разными строками.

print("\n\(separator)\nTask 9.\n")

var str = "bbppeeyy"

func checkFirstCharacter(of string: String, is character: Character) -> Bool {
    return string.first == character
}

let checkCharacter: Character = "a"
if checkFirstCharacter(of: str, is: checkCharacter) {
    print("да")
} else {
    print("нет")
}

if !checkFirstCharacter(of: str, is: checkCharacter) {
    str = "\(checkCharacter)\(str.dropFirst())"
    print("Измененная строка: \(str)")
}

let testStrings = ["apple", "banana", "mango", "ananas"]
for testStr in testStrings {
    if checkFirstCharacter(of: testStr, is: checkCharacter) {
        print("\(testStr): да")
    } else {
        print("\(testStr): нет")
    }
}

// MARK: 10*. Вывести таблицу умножения в консоль с помощью циклов for in.

print("\n\(separator)\nTask 10.\n")

let range = 1...9
for i in range {
    for j in range {
        let result = i * j
        print("\(i) * \(j) = \(result)", terminator: "\t")
    }
    print()
}
