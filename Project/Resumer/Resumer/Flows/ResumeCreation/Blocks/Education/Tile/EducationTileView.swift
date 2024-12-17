import SwiftUI


struct EducationTileView: View {
    @Binding var tile: EducationTileVM
    @State private var textEditorHeight: CGFloat = 80
    @State private var currentTab: Int = 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            VStack(spacing: 0) {
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
            }
            RSegmentedControlView(
                currentTab: $currentTab,
                tabBarOptions: Degree.allCases.map { $0.rawValue }
            )
            .padding(.bottom, 8)
            .onChange(of: currentTab) {
                tile.degree = Degree.allCases[currentTab]
            }
            Divider()
            VStack(spacing: 8) {
                DatePicker("Start Date", selection: $tile.startDate, displayedComponents: .date)
                    .typographyStyle(.body)
                    .tint(.black)
                if !tile.isPresent {
                    DatePicker(
                        "End Date",
                        selection: Binding(
                            get: { tile.endDate ?? Date() },
                            set: { newValue in tile.endDate = newValue }
                        ),
                        displayedComponents: .date
                    )
                    .typographyStyle(.body)
                    .tint(.black)
                }
                HStack {
                    Text("Currently Enrolled")
                        .typographyStyle(.body)
                        .tint(.black)
                    Spacer()
                    RSwitch(isOn: $tile.isPresent)
                        .onChange(of: tile.isPresent) {
                            if tile.isPresent {
                                tile.endDate = Date()
                            }
                        }
                }
            }
            .padding(.vertical, 8)
            Divider()
            
            RTextEditorDynamicView(text: $tile.description)
                .scrollDisabled(true)
        }
        .padding(16)
        .background {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(ColorPalette.Bg.accent)
        }
        .dismissKeyboardOnTap()
    }
}

#Preview {
    @Previewable @State var vm = EducationTileVM(
        affiliation: "University A",
        specialisation: "Computer Science",
        degree: .postgraduate,
        startDate: Date(),
        endDate: Date(),
        isPresent: false,
        description: "BSc Program"
    )
    
    EducationTileView(tile: $vm)
}
