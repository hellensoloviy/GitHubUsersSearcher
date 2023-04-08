//
//  CustomDateFormatter.swift
//  GHUsersList
//
//  Created by Hellen Soloviy on 08.04.2023.
//

import Foundation

struct CustomDateFormatter {
    enum Formats: String {
        case simple = "MM-dd-yyyy"
        case pretty = "MM/dd/yyyy"
        case standartFrom = "yyyy-MM-dd'T'HH:mm:ssZ"
    }
    
    func stringToDate(_ string: String, fromFormat: Formats = .standartFrom, toFormat: Formats = .pretty) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat.rawValue
        if let date = dateFormatter.date(from: string) {
            dateFormatter.dateFormat = toFormat.rawValue
            let stringToReturn = dateFormatter.string(from: date)
            return stringToReturn
        }
        return "Unknown date"
        
    }
    
}
