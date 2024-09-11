import Foundation

class Person {
    let name: String
    let age: Int
    weak var apartment: Apartment?

    init(name: String, age: Int) {
        self.name = name
        self.age = age
        print("- Person \(name) init")
    }

    deinit {
        print("- Person \(name) deinit")
    }
}

class Apartment {
    let id: UUID
    let address: String
    let rent: Double
    var tenant: Person? = nil

    init(id: UUID = UUID(), address: String, rent: Double, tenant: Person? = nil) {
        self.id = id
        self.address = address
        self.rent = rent
        self.tenant = tenant
        print("- Apartment \(id) init")
    }

    deinit {
        print("- Apartment \(id) deinit")
    }
}

print("\nInitialisation\n")

var john: Person? = Person(name: "John Doe", age: 42)
var apartment101: Apartment? = Apartment(address: "123 Main St, Apt 101", rent: 1500.0)

john?.apartment = apartment101
apartment101?.tenant = john

print("\nCheck data\n")

print("John lives in: \(john?.apartment?.address ?? "no data")")
print("Apartment on \(apartment101?.address ?? "no data") lives: \(apartment101?.tenant?.name ?? "nobody")")

print("\nDeinitialisation\n")

john = nil
apartment101 = nil
