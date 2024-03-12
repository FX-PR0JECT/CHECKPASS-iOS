//
//  Date.swift
//  CHECKPASS
//
//  Created by 이정훈 on 3/11/24.
//

import Foundation

extension Date {
    func formatDateToString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: self)
    }
}
