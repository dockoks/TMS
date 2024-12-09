//
//  PDFGenerator.swift
//  Resumer
//
//  Created by Danila Kokin on 12/5/24.
//


import SwiftUI
import PDFKit

struct PDFGenerator {
    static func createPDF(from view: some View, fileName: String = "ResumePreview.pdf") -> URL? {
        let hostingController = UIHostingController(rootView: view)
        let pdfBounds = CGRect(x: 0, y: 0, width: 612, height: 792)
        
        hostingController.view.frame = pdfBounds
        
        let pdfRenderer = UIGraphicsPDFRenderer(bounds: pdfBounds)
        let pdfData = pdfRenderer.pdfData { context in
            context.beginPage()
            hostingController.view.layer.render(in: context.cgContext)
        }

        let fileURL = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
        do {
            try pdfData.write(to: fileURL)
            return fileURL
        } catch {
            print("Error saving PDF: \(error.localizedDescription)")
            return nil
        }
    }
}
