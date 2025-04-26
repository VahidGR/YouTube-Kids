//
//  NumberStyleFormatter.swift
//  YouTube Kids
//
//  Created by Vahid Ghanbarpour on 4/23/25.
//

import Foundation

struct NumberStyleFormatter {
    
    func time(for seconds: Int) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.formattingContext = .standalone
        return unwrap(formatter.string(from: TimeInterval(seconds)))
    }
    
    func shortenNumber(_ number: Int) -> String {
        let num = Double(number)
        let suffixes = ["", "K", "M", "B", "T"]
        
        for (index, suffix) in suffixes.enumerated().reversed() {
            let divisor = pow(1000.0, Double(index))
            if num >= divisor {
                let value = num / divisor
                
                let formatter = NumberFormatter()
                formatter.minimumFractionDigits = 0
                formatter.maximumFractionDigits = 1
                formatter.numberStyle = .decimal
                
                if let formatted = formatter.string(from: NSNumber(value: value)) {
                    // Limit to 3 characters max (including dot), then append suffix
                    let trimmed = formatted.count > 3 ? String(formatted.prefix(3)) : formatted
                    return "\(trimmed)\(suffix)"
                }
            }
        }
        
        return "\(number)"
    }
}
