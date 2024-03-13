//
//  TimeTableGrid.swift
//  CHECKPASS
//
//  Created by 이정훈 on 3/12/24.
//

import SwiftUI

let dayOfWeek = ["월", "화", "수", "목", "금", "토"]
let times = ["1A", "1B", "2A", "2B", "3A", "3B", "4A", "4B", "5A", "5B", "6A", "6B", "7A", "7B", "8A", "8B", "9A", "9B"]

struct TimeTableGrid: View {
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<19, id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach(0..<7, id: \.self) { column in
                        Rectangle()
                            .fill(.white)
                            .border(.gray, width: 0.5)
                            .modifier { view in
                                if row == 0 && column == 0 {
                                    view.frame(width: 25, height: 20)
                                } else if row == 0 {
                                    view.frame(width: 55, height: 20)
                                        .overlay {
                                            Text(dayOfWeek[column - 1])
                                                .font(.footnote)
                                        }
                                } else if column == 0 {
                                    view.frame(width: 25, height: 35)
                                        .overlay {
                                            Text(times[row - 1])
                                                .font(.footnote)
                                        }
                                } else {
                                    view.frame(width: 55, height: 35)
                                }
                            }
                    }
                }
            }
        }
    }
}

#Preview {
    TimeTableGrid()
}
