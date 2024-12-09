//
//  ContinuousCornerShape.swift
//  Resumer
//
//  Created by Danila Kokin on 12/2/24.
//

import SwiftUI

struct ContinuousCornerShape: Shape {
    var cornerRadius: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let topLeftRadius = cornerRadius
        let topRightRadius = cornerRadius
        let bottomLeftRadius = cornerRadius
        let bottomRightRadius = cornerRadius

        let width = rect.width
        let height = rect.height

        // Ensure corner radii don't exceed dimensions
        let topLeft = min(topLeftRadius, min(width, height) / 2)
        let topRight = min(topRightRadius, min(width, height) / 2)
        let bottomLeft = min(bottomLeftRadius, min(width, height) / 2)
        let bottomRight = min(bottomRightRadius, min(width, height) / 2)

        // Start at top-left corner
        path.move(to: CGPoint(x: rect.minX + topLeft, y: rect.minY))

        // Top edge
        path.addLine(to: CGPoint(x: rect.maxX - topRight, y: rect.minY))
        path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.minY + topRight),
                          control: CGPoint(x: rect.maxX, y: rect.minY))

        // Right edge
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - bottomRight))
        path.addQuadCurve(to: CGPoint(x: rect.maxX - bottomRight, y: rect.maxY),
                          control: CGPoint(x: rect.maxX, y: rect.maxY))

        // Bottom edge
        path.addLine(to: CGPoint(x: rect.minX + bottomLeft, y: rect.maxY))
        path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.maxY - bottomLeft),
                          control: CGPoint(x: rect.minX, y: rect.maxY))

        // Left edge
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + topLeft))
        path.addQuadCurve(to: CGPoint(x: rect.minX + topLeft, y: rect.minY),
                          control: CGPoint(x: rect.minX, y: rect.minY))

        return path
    }
}
