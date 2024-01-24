//
//  DepartmentsDTO.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/22/24.
//

import Foundation

// MARK: - DepartmentsDTO
struct DepartmentsDTO: Codable {
    let state: String
    let code: Int
    let title: String
    let resultSet: Dictionary<String, [[String]]>
    
    func toEntity() -> Departments {
        var dictionary = [String: String]()
        
        resultSet.values.forEach { value in
            value.forEach {
                dictionary[$0[0]] = $0[1]    //key: kor deparment name, value: eng deparment name
            }
        }
        
        return Departments(departmentsDictionary: dictionary)
    }
}
