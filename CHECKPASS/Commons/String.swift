//
//  String.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/14/24.
//

import Foundation

extension String {
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }
}

extension String {
    func subCharacter(at index: Int) -> Character {
        let idx = self.index(self.startIndex, offsetBy: index)
        return self[idx]
    }
}
