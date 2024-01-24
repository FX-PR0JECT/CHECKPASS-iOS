//
//  Departments.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/22/24.
//

import Foundation

struct Departments {
    private let departmentsDictionary: Dictionary<String, String>
    var departmentList: [String] {
        return Array(departmentsDictionary.keys)
    }
    
    init(departmentsDictionary: Dictionary<String, String>) {
        self.departmentsDictionary = departmentsDictionary
    }
    
    subscript (key: String) -> String {
        if let value = departmentsDictionary[key] {
            return value
        } else {
            fatalError()
        }
    }
}
