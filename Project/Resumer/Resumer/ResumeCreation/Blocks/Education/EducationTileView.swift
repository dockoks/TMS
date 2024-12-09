import SwiftUI

struct EducationTileView: View {
    @Binding var tile: EducationTileVM
    @State private var textEditorHeight: CGFloat = 80
    @State private var currentTab: Int = 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            RTextField(
                text: $tile.affiliation,
                symbolLimit: 20,
                placeholder: "Affiliation"
            )
            
            RTextField(
                text: $tile.specialisation,
                symbolLimit: 20,
                placeholder: "Specialisation"
            )
            
            TabBarView(
                currentTab: $currentTab,
                tabBarOptions: Degree.allCases.map { $0.rawValue } 
            )
            .padding(.vertical, 16)
            .onChange(of: currentTab) {
                tile.degree = Degree.allCases[currentTab]
            }
            
            VStack {
                DatePicker("Start Date", selection: $tile.startDate, displayedComponents: .date)
                    .typographyStyle(.body)
                    .tint(.black)
                if !tile.isPresent {
                    DatePicker("End Date", selection: $tile.endDate, displayedComponents: .date)
                        .typographyStyle(.body)
                        .tint(.black)
                }
            }
            
            Toggle("Currently Enrolled", isOn: $tile.isPresent)
                .typographyStyle(.body)
                .tint(.black)
                .padding(.vertical, 16)
                .onChange(of: tile.isPresent) {
                    if tile.isPresent {
                        tile.endDate = Date()
                    }
                }
            
            RTextEditorDynamicView(text: $tile.description)
        }
        .padding(12)
        .background {
            RoundedRectangle(cornerRadius: 28)
                .fill(ColorPalette.Bg.layerThree)
        }
        .dismissKeyboardOnTap()
    }
}

#Preview {
    EducationTileView(
        tile: .constant(
            EducationTileVM(
                affiliation: "University A",
                specialisation: "Computer Science",
                degree: .bachelors,
                startDate: Date(),
                endDate: Date(),
                isPresent: false,
                description: "BSc Program"
            )
        )
    )
}
