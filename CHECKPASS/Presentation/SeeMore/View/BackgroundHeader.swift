//
//  BackgroundHeader.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/13/24.
//

import SwiftUI

struct BackgroundHeader: View {
    let name: String
    let color: Color
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Text(name)
                
                Spacer()
            }
            
            Spacer()
        }
        .frame(height: 13)
        .listRowInsets(EdgeInsets())
        .padding(0)
        .background(color)
    }
}

#Preview {
    BackgroundHeader(name: "", color: .listSeperator)
}
