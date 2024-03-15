//
//  NoLectureView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 3/15/24.
//

import SwiftUI

struct NoLectureView: View {
    var body: some View {
        VStack {
            Image("NoLecture")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width * 0.5)
                .padding(.bottom, 30)
            
            Text("수강 중인 강의가 존재하지 않습니다\n수강신청에서 강의를 추가하세요")
                .multilineTextAlignment(.center)
                .font(.subheadline)
                .foregroundColor(.gray)
                .bold()
        }
        .offset(y: -UIScreen.main.bounds.height * 0.08)
    }
}

#Preview {
    NoLectureView()
}
