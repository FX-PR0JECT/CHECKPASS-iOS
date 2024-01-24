//
//  Colleges.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/22/24.
//

import Foundation

struct Colleges {
    private var collegesDictionary: Dictionary<String, String>
    var collegeList: [String] {
        return Array(collegesDictionary.keys)
    }
    
    init(collegesDictionary: Dictionary<String, String>) {
        self.collegesDictionary = collegesDictionary
    }
    
    subscript (key: String) -> String {
        if let value = collegesDictionary[key] {
            return value
        } else {
            fatalError()
        }
    }
}
