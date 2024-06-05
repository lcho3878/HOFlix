//
//  Date+Extension.swift
//  HOFlix
//
//  Created by 이찬호 on 6/5/24.
//

import Foundation

extension Date {
    func string(_ format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
