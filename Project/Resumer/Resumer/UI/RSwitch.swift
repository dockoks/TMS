//
//  RSwitch.swift
//  Resumer
//
//  Created by Danila Kokin on 12/10/24.
//

import SwiftUI

struct RSwitch: View {
    @Binding var isOn: Bool
    @Namespace var namespace

    var body: some View {
        ZStack(alignment: isOn ? .trailing : .leading) {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(isOn ? .black : .gray.opacity(0.2))
                .frame(width: 50, height: 28)
                .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(.white)
                .frame(width: 24, height: 24)
                .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
                .padding(2)
                .matchedGeometryEffect(id: "toggle", in: namespace)
        }
        .animation(.easeInOut(duration: 0.3), value: isOn)
        .onTapGesture {
            isOn.toggle()
        }
        .frame(width: 50, height: 28)
    }
}

#Preview {
    @Previewable @State var isSwitchOn = false

    return VStack {
        RSwitch(isOn: $isSwitchOn)
            .padding()

        Text("Switch is \(isSwitchOn ? "On" : "Off")")
            .typographyStyle(.caption)
    }
    .padding()
}
