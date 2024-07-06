import Foundation

/*
Создать объект “Школа” со свойствами:
 - массив учеников,
 - название школы,
 - адрес (адрес - новый объект с координатами x, y, street name)
 - директор:
    - experience,
    - рейтинг.
    Директор наследуется от класса Person:
        - name
        - surname
        - age

У ученика хранить 
 - имя,
 - фамилию,
 - номер класса,
 - кортеж “название предмета - оценка”.
 Ученик наследуется от Person.

У ученика сделать конструктор со всеми параметрами, добавить дефолтные значения к
некоторым из них.

Написать метод для ученика, выводящий информацию о студенте в формате"
“Фамилия Имя (Класс)
предмет: оценка
предмет: оценка”.

Написать метод для школы, который выводит информацию о школе.

Уделите особое внимание выбору, что использовать: класс или структуру, var или let, private, public
*/

// MARK: Person class
// Person
class Person {
    let name: String
    let surname: String
    let age: Int

    init(
        name: String,
        surname: String,
        age: Int
    ) {
        self.name = name
        self.surname = surname
        self.age = age
    }
}

// Subject
enum Subject: String {
    case maths
    case music
    case physics
    case algebra
    case english
    case geometry
    case literature
}

// Student
final class Student: Person {
    private let grade: Int
    private let subjectGrades: [(Subject, Int)]
    
    init(
        name: String,
        surname: String,
        age: Int,
        grade: Int,
        subjectGrades: [(Subject, Int)] = []
    ) {
        self.grade = grade
        self.subjectGrades = subjectGrades
        super.init(
            name: name,
            surname: surname,
            age: age
        )
    }
    
    func printStudentInfo() {
        print("\(self.surname) \(name) - (grade \(grade))")
        let subjectsCount = subjectGrades.count
        for i in 0..<subjectsCount {
            let (subject, grade) = subjectGrades[i]
            if i == subjectsCount-1 {
                print("└── \(subject.rawValue): \(grade)")
            } else {
                print("├── \(subject.rawValue): \(grade)")
            }
        }
    }
}

// Director
final class Director: Person {
    let experience: Int
    let rating: Double

    init(
        name: String,
        surname: String,
        age: Int,
        experience: Int,
        rating: Double
    ) {
        self.experience = experience
        self.rating = rating
        super.init(
            name: name,
            surname: surname,
            age: age
        )
    }
}

// MARK: School class
// Address
struct Address {
    let x: Double
    let y: Double
    let streetName: String
}

// School
struct School {
    private let name: String
    private let address: Address
    private let director: Director
    private let students: [Student]
    
    public init(
        name: String,
        address: Address,
        director: Director,
        students: [Student]
    ) {
        self.name = name
        self.address = address
        self.director = director
        self.students = students
    }
    
    func printSchoolInfo() {
        print("School: \(name)")
        print("Address: \(address.streetName), \nCoordinates: (\(address.x), \(address.y))")
        print("Director: \(director.surname) \(director.name), Experience: \(director.experience), Rating: \(director.rating)")
        print("Number of students: \(students.count)")
        students.forEach { $0.printStudentInfo() }
    }
}

// MARK: Sample data
let schoolAddress = Address(x: 100.0, y: 200.0, streetName: "123 Academy Street")
let schoolDirector = Director(name: "John", surname: "Doe", age: 45, experience: 20, rating: 4.5)
let student1 = Student(
    name: "Alice",
    surname: "Johnson",
    age: 16,
    grade: 10,
    subjectGrades: [
        (.algebra, 95),
        (.english, 88)
    ]
)
let student2 = Student(
    name: "Bob",
    surname: "Willson",
    age: 17,
    grade: 10,
    subjectGrades: [
        (.geometry, 40),
        (.literature, 70)
    ]
)
let academySchool = School(
    name: "TMS Academy",
    address: schoolAddress,
    director: schoolDirector,
    students: [
        student1,
        student2
    ]
)

print("===== Student info =====")
student1.printStudentInfo()
print("\n===== School info =====")
academySchool.printSchoolInfo()

