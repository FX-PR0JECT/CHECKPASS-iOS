//
//  AttendanceLegend.swift
//  CHECKPASS
//
//  Created by 이정훈 on 3/26/24.
//

import SwiftUI

struct AttendanceLegend: View {
    enum LegendPosition {
        case leading
        case trailing
        case center
    }
    
    let pos: LegendPosition
    
    var body: some View {
        HStack {
            if pos == .trailing {
                Spacer()
            }
            
            Circle()
                .fill(.gray)
                .frame(width: 10)
                .padding(.trailing, -5)
            
            Text("미입력")
            
            Circle()
                .fill(.attended)
                .frame(width: 10)
                .padding(.trailing, -5)
            
            Text("출석")
            
            Circle()
                .fill(.late)
                .frame(width: 10)
                .padding(.trailing, -5)
            
            Text("지각")
            
            Circle()
                .fill(.absence)
                .frame(width: 10)
                .padding(.trailing, -5)
            
            Text("결석")
            
            if pos == .leading {
                Spacer()
            }
        }
        .font(.caption2)
    }
}

#Preview {
    AttendanceLegend(pos: .center)
}
