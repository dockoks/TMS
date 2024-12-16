//
//  Date.swift
//  Resumer
//
//  Created by Danila Kokin on 12/5/24.
//

import SwiftUI

extension Date {
    func toString(format: String = "dd.MM.yy") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
