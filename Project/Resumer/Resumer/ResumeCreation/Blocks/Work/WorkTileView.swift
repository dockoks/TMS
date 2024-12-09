//
//  WorkTileView.swift
//  Resumer
//
//  Created by Danila Kokin on 12/4/24.
//

import SwiftUI

struct WorkTileView: View {
    @Binding var tile: WorkTileVM
    @State private var textEditorHeight: CGFloat = 80
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
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
            
            Toggle("Currently working", isOn: $tile.isPresent)
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
