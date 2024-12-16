import SwiftUI


struct LanguageTileView: View {
    @Binding var tile: LanguageTileVM
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            RTextField(
                text: $tile.name,
                symbolLimit: 20,
                placeholder: "Language"
            )
            
            RSegmentedControlView(
                currentTab: $tile.chosenProficiency,
                tabBarOptions: ProfficiencyLevel.allCases.map {
                    $0.rawValue.capitalized
                }
            )
        }
        .padding(12)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(ColorPalette.Bg.accent)
        }
        .dismissKeyboardOnTap()
    }
}

#Preview {
    @Previewable @State var tile: LanguageTileVM = .init(name: "English", proficiency: .b2)
    
    LanguageTileView(
        tile: $tile
    )
}
