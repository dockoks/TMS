//
//  LanguageTileView.swift
//  Resumer
//
//  Created by Danila Kokin on 12/5/24.
//

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
            
            TabBarView(
                currentTab: $tile.chosenProficiency,
                tabBarOptions: ProfficiencyLevel.allCases.map {
                    $0.rawValue.capitalized
                }
            )
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
    LanguageTileView(
        tile: .constant(
            LanguageTileVM(
                name: "English",
                proficiency: .b2
            )
        )
    )
}
