//
//  Extensions.swift
//  ExpenseTracker
//
//  Created by HWorld on 10/15/22.
//

import Foundation
import SwiftUI

extension Color {
    static let background = Color("Background")
    static let icon = Color("Icon")
    static let text = Color("Text")
    static let systemBackground = Color(uiColor: .systemBackground)
}

// MARK: this is a lazy method, and make sure we intialize dateformatter once only, as dateformatters are expensive operations
// MARK: 'static' makes sure there's only one instance of it. To check this, we put a print in the middle to catch when this occurs
extension DateFormatter {
    static let myFavFormatter: DateFormatter = {
        print("Initializing Dateformatter")
        let myformatter = DateFormatter()
        myformatter.dateFormat = "MMM dd, yyyy"
        return myformatter
        /// call the method directly by adding ( ) at the end
    }()
//    static let allNumericEU: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "dd/MM/yyyy"
//        return formatter
//    }()
}

extension String {
    func dateParsed() -> Date {
        /// old version
        //guard let parsedDate = DateFormatter.allNumericEU.date(from: self)  else { return Date() }
        /// new version
        guard let parsedDate = DateFormatter.myFavFormatter.date(from: self) else { return Date() }
        //else { return Calendar.current.date(byAdding: .month, value: 1, to: Date()) ?? Date.distantPast }
        return parsedDate
    }
}

extension Double {
    var currencyFormat: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: Float(self) /* / 100 */ )) ?? ""
    }
}

extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    static let screenSize = UIScreen.main.bounds.size
}
