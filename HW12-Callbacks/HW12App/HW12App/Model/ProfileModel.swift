import Foundation

enum PropertyType: String {
    case text
    case number
    case segmented
    case date
}

enum PropertyKey: String {
    case name
    case surname
    case age
    case sex
    case birthday
    case interests
}

protocol ProfileModelDelegate: AnyObject {
    func didUpdateProfile()
}

final class ProfileModel: Codable {
    enum Sex: String, Codable {
        case male
        case female
    }
    
    var name: String? {
        didSet {
            delegate?.didUpdateProfile()
            save()
        }
    }
    var surname: String? {
        didSet {
            delegate?.didUpdateProfile()
            save()
        }
    }
    var age: String? {
        didSet {
            delegate?.didUpdateProfile()
            save()
        }
    }
    var sex: Sex? {
        didSet {
            delegate?.didUpdateProfile()
            save()
        }
    }
    var birthday: Date? {
        didSet {
            delegate?.didUpdateProfile()
            save()
        }
    }
    var interests: [String]? {
        didSet {
            delegate?.didUpdateProfile()
            save()
        }
    }
    
    weak var delegate: ProfileModelDelegate?
    
    private init(
        name: String?,
        surname: String?,
        age: String?,
        sex: Sex?,
        birthday: Date?,
        interests: [String]?
    ) {
        self.name = name
        self.surname = surname
        self.age = age
        self.sex = sex
        self.birthday = birthday
        self.interests = interests
    }
    
    static var shared: ProfileModel = {
        if let data = UserDefaults.standard.data(forKey: "ProfileModel"),
           let profile = try? JSONDecoder().decode(ProfileModel.self, from: data) {
            return profile
        } else {
            return ProfileModel(
                name: nil,
                surname: nil,
                age: nil,
                sex: nil,
                birthday: nil,
                interests: nil
            )
        }
    }()
    
    func save() {
        if let data = try? JSONEncoder().encode(self) {
            UserDefaults.standard.set(data, forKey: "ProfileModel")
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case name, surname, age, sex, birthday, interests
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: CodingKeys.name)
        surname = try container.decodeIfPresent(String.self, forKey: CodingKeys.surname)
        age = try container.decodeIfPresent(String.self, forKey: CodingKeys.age)
        sex = try container.decodeIfPresent(Sex.self, forKey: CodingKeys.sex)
        birthday = try container.decodeIfPresent(Date.self, forKey: CodingKeys.birthday)
        interests = try container.decodeIfPresent([String].self, forKey: CodingKeys.interests)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(surname, forKey: .surname)
        try container.encodeIfPresent(age, forKey: .age)
        try container.encodeIfPresent(sex, forKey: .sex)
        try container.encodeIfPresent(birthday, forKey: .birthday)
        try container.encodeIfPresent(interests, forKey: .interests)
    }
    
    func stringValue(for property: PropertyKey) -> String? {
        switch property {
        case .name:
            return name
        case .surname:
            return surname
        case .age:
            return age
        case .sex:
            guard let sex = self.sex else { return nil }
            return sex.rawValue.capitalized
        case .birthday:
            guard let birthday = self.birthday else { return nil }
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            return formatter.string(from: birthday)
        case .interests:
            guard let interests = self.interests, !interests.isEmpty else { return nil }
            return interests.joined(separator: ", ")
        }
    }
    
    func update(propertyKey: PropertyKey, value: Any?) {
        switch propertyKey {
        case .name:
            self.name = value as? String
        case .surname:
            self.surname = value as? String
        case .age:
            self.age = value as? String
        case .sex:
            if let sexValue = value as? String {
                self.sex = Sex(rawValue: sexValue.lowercased())
            }
        case .birthday:
            self.birthday = value as? Date
        case .interests:
            self.interests = value as? [String]
        }
    }
}
