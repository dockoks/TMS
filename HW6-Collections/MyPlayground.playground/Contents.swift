import Foundation

func printTaskOutput(
    task number: Int,
    input: Any?...,
    output: Any?...,
    printSeparately: Bool = true
) {
    print("Задание #\(number)")
    print("-------")
    if printSeparately {
        input.forEach {
            print("Ввод: \($0 ?? "")")
        }
        print("-------")
        output.forEach {
            print("Вывод: \($0 ?? "")")
        }
    } else {
        for (i, (a, b)) in zip(input, output).enumerated() {
            print("· \(number).\(i)")
            print("-------")
            print("Ввод: \(a ?? "")")
            print("Вывод: \(b ?? "")")
            print("-------")
        }
    }
    print("\n")
}

// MARK: 1.Создайте два массива. Первый от 0 до 14, второй от 14 до 30. Объедините их в один массив.

let arrA: [Int] = Array(0..<14)
let arrB: [Int] = Array(14..<30)

let arrC: [Int] = arrA + arrB

printTaskOutput(
    task: 1,
    input: arrA, arrB,
    output: arrC
)

// MARK: 2.Создать функцию, которая принимает массив int. Возвести все Int в квадрат. Возвратить новый массив.

func sqaureArray(_ arr: [Int]) -> [Int] {
    return arr.map { $0 * $0 }
}

printTaskOutput(
    task: 2,
    input: arrA,
    output: sqaureArray(arrA)
)

// MARK: 3.Создать функцию, которая принимает массив int. Возвратить новый массив с только четными элементами.

func getEvenNumbers(_ arr: [Int]) -> [Int] {
    return arr.filter { $0 % 2 == 0 }
}

printTaskOutput(
    task: 3,
    input: arrA,
    output: getEvenNumbers(arrA)
)

// MARK: 4.Написать 3 примера с использованием .map

// конвертация элементов Int в String
var numbers: [Int] = Array(1...30)
let strings: [String] = numbers.map { String($0) }

// возведение в квадрат элементов
let squares: [Int] = numbers.map { $0 * $0 }


struct Person: CustomStringConvertible {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    var description: String {
        return "Person(name: \(name), age: \(age))"
    }
}

let pairs: [(String,Int)] = [("Bob", 29), ("Maria", 20), ("Alex", 34)]
let people: [Person] = pairs.map {
    .init(
        name: $0.0,
        age: $0.1
    )
}

printTaskOutput(
    task: 4,
    input: numbers, numbers, pairs,
    output: strings, squares, people,
    printSeparately: false
)

// MARK: 5.Написать 2 примера с использованием .filter

func isPrime(_ number: Int) -> Bool {
    assert(number > 0, "Invalid input")
    if number <= 3 { return true }
    if number % 2 == 0 || number % 3 == 0 { return false }
    
    var i = 5
    while i * i <= number {
        if number % i == 0 {
            return false
        }
        i += 1
    }
    return true
}

let primes: [Int] = numbers.filter { isPrime($0) }
let outliers: [Int] = numbers.filter { $0 < 5 || $0 > 25 }

printTaskOutput(
    task: 5,
    input: numbers, numbers,
    output: primes, outliers,
    printSeparately: false
)

// MARK: 6.Написать 2 примера с использованием .compactMap

let optionalIntegers: [Int?] = [1, 2, nil, 4, nil, 6]
let integers = optionalIntegers.compactMap { $0 }

let stringNumbers: [String] = ["10", "twenty", "30", "forty", "50", "csdc", "2", "23"]
numbers = stringNumbers.compactMap { Int($0) }

printTaskOutput(
    task: 6,
    input: optionalIntegers, stringNumbers,
    output: integers, numbers,
    printSeparately: false
)

// MARK: 7.Написать 2 примера с .sort

let numbersInput = numbers
numbers.sort()

var fruits = ["Banana", "Apple", "Mango", "Cherry", "Strawberry", "Aloe"]
let fruitsInput = fruits
fruits.sort { $0 > $1 }

printTaskOutput(
    task: 7,
    input: numbersInput, fruitsInput,
    output: numbers, fruits,
    printSeparately: false
)

// MARK: 8.Написать 2 примера с .sorted

numbers.shuffle()
fruits.shuffle()

let outputNumbers = numbers.sorted()
let outputFruits = fruits.sorted { $0.count < $1.count }

printTaskOutput(
    task: 8,
    input: numbers, fruits,
    output: outputNumbers, outputFruits,
    printSeparately: false
)

// MARK: 9.(*) Задание с собеседования, которое не получалось

let a: [Any?] = [1, 2, [3, [4, [[[5]]], 6]], [7, 8], 9, [10], nil, [[[nil]]]]

extension Collection {
    func ultraFlatMap<T>() -> [T] {
        var result: [T] = []
        
        for element in self {
            if let value = element as? T {
                result.append(value)
            }
            else if let subArray = element as? [Any?] {
                result.append(contentsOf: subArray.ultraFlatMap() as [T])
            }
        }
        return result
    }
}

let out: [Int] = a.ultraFlatMap()

printTaskOutput(
    task: 9,
    input: a,
    output: out
)
