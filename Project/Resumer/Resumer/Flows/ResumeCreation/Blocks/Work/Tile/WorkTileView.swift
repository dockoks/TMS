import SwiftUI


struct WorkTileView: View {
    @Binding var tile: WorkTileVM
    @State private var textEditorHeight: CGFloat = 80
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            VStack(spacing: 0) {
                RTextField(
                    text: $tile.company,
                    symbolLimit: 20,
                    placeholder: "Company"
                )
                
                RTextField(
                    text: $tile.position,
                    symbolLimit: 20,
                    placeholder: "Position"
                )
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
                    Text("Currently Working")
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
    WorkTileView(
        tile: .constant(
            WorkTileVM(
                company: "Yandex",
                position: "Junior iOS developer",
                startDate: Date(),
                endDate: Date(),
                isPresent: false,
                description: "BSc Program"
            )
        )
    )
}
