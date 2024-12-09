import SwiftUI

import SwiftUI

struct ResumePreview: View {
    @ObservedObject var resumeVM: ResumeCreationVM

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            leadingColumn
            trailingColumn
        }
        .padding(16)
        .background(Color.white)
    }
    
    var leadingColumn: some View {
        VStack(alignment: .leading, spacing: 16) {
            Group {
                Text("\(resumeVM.basicInfoVM.name) \(resumeVM.basicInfoVM.surname)")
                    .typographyStyle(.title)
                Text(resumeVM.basicInfoVM.jobTitle)
                    .typographyStyle(.caption)
            }
            
            Group {
                Text(resumeVM.contactVM.email).typographyStyle(.caption)
                Text(resumeVM.contactVM.phone).typographyStyle(.caption)
                Text(resumeVM.contactVM.address).typographyStyle(.caption)
            }
            
            if !resumeVM.educationVM.tiles.isEmpty {
                Text("Education").typographyStyle(.footnote)
                ForEach(resumeVM.educationVM.tiles) { tile in
                    Text("\(tile.affiliation) - \(tile.degree.rawValue.capitalized)").typographyStyle(.footnote)
                    Text(tile.specialisation).typographyStyle(.footnote)
                    if let description = tile.description {
                        Text(description).typographyStyle(.caption)
                    }
                }
            }
            
            if !resumeVM.workVM.tiles.isEmpty {
                Text("Work Experience").typographyStyle(.footnote)
                ForEach(resumeVM.workVM.tiles) { tile in
                    Text("\(tile.company) - \(tile.position)").typographyStyle(.footnote)
                    if let description = tile.description {
                        Text(description).typographyStyle(.caption)
                    }
                }
            }
            
            Spacer()
        }
    }
    
    var trailingColumn: some View {
        VStack(alignment: .leading, spacing: 4) {
            Group {
                Text("Contacts").typographyStyle(.footnote)
                Text(resumeVM.contactVM.email).typographyStyle(.caption)
                Text(resumeVM.contactVM.phone).typographyStyle(.caption)
                Text(resumeVM.contactVM.address).typographyStyle(.caption)
            }
            
            Group {
                Text("Languages").typographyStyle(.footnote)
                ForEach(resumeVM.languageVM.tiles) { tile in
                    Text("\(tile.name) - \(tile.proficiency.rawValue)")
                        .typographyStyle(.caption)
                }
            }
            
            if !resumeVM.skillVM.skills.isEmpty {
                Text("Skills").typographyStyle(.caption)
                Text(resumeVM.skillVM.skills.joined(separator: ", "))
            }
            
            Spacer()
        }
    }
}

#Preview {
    ResumePreview(
        resumeVM: .init(
            basicInfo: .init(
                avatar: Image(systemName: "person.circle"),
                name: "John",
                surname: "Doe",
                jobTitle: "iOS Developer"
            ),
            contact: .init(
                email: "johndoe@example.com",
                phone: "+1 (555) 123-4567",
                address: "123 Main Street, Springfield, USA",
                additionalLinks: [
                    .init(key: .linkedIn, value: "johndoe"),
                    .init(key: .github, value: "johndoe-dev")
                ]
            ),
            education: .init(
                tiles: [
                    .init(
                        affiliation: "Springfield University",
                        specialisation: "Computer Science",
                        degree: .bachelors,
                        startDate: Date(timeIntervalSinceNow: -4 * 365 * 24 * 60 * 60), // 4 years ago
                        endDate: Date(timeIntervalSinceNow: -1 * 365 * 24 * 60 * 60), // 1 year ago
                        isPresent: false,
                        description: "Learned programming, data structures, and algorithms."
                    )
                ]
            ),
            work: .init(
                tiles: [
                    .init(
                        company: "TechCorp",
                        position: "Junior iOS Developer",
                        startDate: Date(timeIntervalSinceNow: -1 * 365 * 24 * 60 * 60), // 1 year ago
                        endDate: Date(),
                        isPresent: true,
                        description: "Developed and maintained iOS applications for e-commerce clients."
                    )
                ]
            ),
            skill: .init(
                skills: ["Swift", "SwiftUI", "Combine", "Core Data"]
            ),
            language: .init(
                tiles: [
                    .init(
                        name: "English",
                        chosenProficiency: 4,
                        proficiency: .c2
                    ),
                    .init(
                        name: "Spanish",
                        chosenProficiency: 3,
                        proficiency: .b2
                    )
                ]
            )
        )
    )
}
