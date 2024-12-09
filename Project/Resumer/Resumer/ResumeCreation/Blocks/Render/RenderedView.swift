//
//  RenderedView.swift
//  Resumer
//
//  Created by Danila Kokin on 12/5/24.
//

import SwiftUI
import PDFKit

struct RenderedView: View {
    @ObservedObject var resumeVM: ResumeCreationVM
    @State private var pdfURL: URL?

    var body: some View {
        VStack {
            ResumePreview(resumeVM: resumeVM)
            RButton(style: .primary, title: "Export PDF") {
                exportPDF()
            }
        }
    }

    @MainActor
    private func exportPDF() {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }

        let renderedUrl = documentDirectory.appending(path: "prerview.pdf")

        if let consumer = CGDataConsumer(url: renderedUrl as CFURL),
           let pdfContext = CGContext(consumer: consumer, mediaBox: nil, nil) {

            let content = ResumePreview(resumeVM: resumeVM)
            let renderer = ImageRenderer(content: content)
            renderer.render { size, renderer in
                let options: [CFString: Any] = [
                    kCGPDFContextMediaBox: CGRect(origin: .zero, size: size)
                ]

                pdfContext.beginPDFPage(options as CFDictionary)

                renderer(pdfContext)
                pdfContext.endPDFPage()
                pdfContext.closePDF()
            }
        }

        print("Saving PDF to \(renderedUrl.path())")
    }
}
