import SwiftUI


struct RTextEditorDynamicView: View {
    @Binding private var text: String
    let placeholder: String = ""
    
    init(
        text: Binding<String>
    ) {
        self._text = text
    }
    
    var body: some View {
        VStack {
            ScrollView {
                ZStack(alignment: .topLeading) {
                    Text(text.isEmpty ? placeholder : text)
                        .opacity(text.isEmpty ? 1 : 0)
                        .foregroundStyle(.gray)
                        .typographyStyle(.footnote)
                        .padding(.vertical, 8)
                    TextEditor(text: $text)
                        .scrollContentBackground(.hidden)
                        .scrollIndicators(.hidden)
                        .typographyStyle(.footnote)
                        .padding(.horizontal, -4)
                        .frame(minHeight: 30, alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .tint(.black)
                }
            }
        }
    }
}

public extension Binding where Value: Equatable {
    init(_ source: Binding<Value?>, replacingNilWith nilProxy: Value) {
        self.init(
            get: { source.wrappedValue ?? nilProxy },
            set: { newValue in
                if newValue == nilProxy {
                    source.wrappedValue = nil
                } else {
                    source.wrappedValue = newValue
                }
            }
        )
    }
}
