//
//  Extension.swift
//  WeatherApp
//
//  Created by Trung Nguyễn on 3/18/23.
//

import Foundation
import SwiftUI
extension Date {
    func toShortWeekday() -> String {
//        let dateFormater = DateFormatter()
//        dateFormater.dateFormat = "EEE"
//        let isToday = Calendar.current.compare(Date(), to: self, toGranularity: .day)
//        switch isToday {
//        case .orderedSame:
//            return "Today"
//        default:
//            return dateFormater.string(from: self)
//        }
        return toString("EEE")
    }
    func toHour() -> String {
        return toString("HH:mm")
    }
    func toString(_ format: String = "EEE, MMM d, yyyy") -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = format
        return dateFormater.string(from: self)
    }
}
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
    static let ui = Color.UI()
    
    struct UI {
        let primary = Color(hex: "1E203B")
        //1E203B
        let secondary = Color(hex: "2C2B4C")
    }
}

extension Double {
    func toString() -> String {
        return String(format: "%.0f", self)
    }
}
