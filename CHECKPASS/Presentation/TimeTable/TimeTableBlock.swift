//
//  TimeTableBlock.swift
//  CHECKPASS
//
//  Created by 이정훈 on 3/12/24.
//

import SwiftUI

struct TimeTableBlock: View {
    let lectureIndex: Int    //for Color
    let xCoordinate: Int    //Mon: 0, Tue: 1...
    let title: String
    let scheduleArray: [Bool]?
    
    var body: some View {
        if let yCoordinate, let lectureHours {
            Rectangle()
                .fill(backgroundColor)
                .overlay {
                    VStack {
                        Text(title)
                            .font(.caption)
                            .foregroundColor(.white)
                        
                        Spacer()
                    }
                    .padding(3)
                }
                .frame(width: 55, height: CGFloat(35 * lectureHours - 1))
                .offset(x: CGFloat(-125 + (55 * xCoordinate)), y: height + CGFloat(35 * yCoordinate - 5))
        }
    }
}

extension TimeTableBlock {
    private var backgroundColor: Color {
        let colors: [Color] = [
            Color(red: 193 / 255, green: 120 / 255, blue: 106 / 255),
            Color(red: 206 / 255, green: 150 / 255, blue: 99 / 255),
            Color(red: 198 / 255, green: 169 / 255, blue: 103 / 255),
            Color(red: 174 / 255, green: 200 / 255, blue: 123 / 255),
            Color(red: 120 / 255, green: 172 / 255, blue: 123 / 255),
            Color(red: 125 / 255, green: 178 / 255, blue: 166 / 255),
            Color(red: 133 / 255, green: 116 / 255, blue: 188 / 255),
            Color(red: 175 / 255, green: 132 / 255, blue: 199 / 255)
        ]
        
        return colors[lectureIndex]
    }
    
    private var height: CGFloat {
        var oddCount = 0, evenCount = 0
        
        lectureHours.map { hour in
            if hour > 1 {
                for i in 2..<hour + 1 {
                    if i % 2 == 0 {
                        evenCount += 1
                    } else {
                        oddCount += 1
                    }
                }
            }
        }
        
        return CGFloat(-283 + 17 * oddCount + 18 * evenCount)
    }
    
    private var lectureHours: Int? {
        guard let scheduleArray else{
            return nil
        }
        
        return scheduleArray.filter { $0 == true }.count
    }
    
    private var yCoordinate: Int? {
        guard let scheduleArray else {
            return nil
        }
        
        return scheduleArray.firstIndex(of: true)
    }
}

#Preview {
    TimeTableBlock(lectureIndex: 0,
                   xCoordinate: 2,
                   title: "소프트웨어공학", 
                   scheduleArray: [
                    false,
                    false,
                    false,
                    false,
                    false,
                    false,
                    false,
                    true,
                    true,
                    false,
                    false,
                    false,
                    false,
                    false,
                    false,
                    false,
                    false,
                    false
                ])
}
