//
//  AttendanceResultView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 3/18/24.
//

import SwiftUI

struct AttendanceResultView<T: AttendanceViewModel>: View {
    @EnvironmentObject private var viewModel: T
    @State private var animationCount = 0
    
    var body: some View {
        VStack {
            Spacer()
            
            if let result = viewModel.result {
                if result {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width * 0.3)
                        .foregroundColor(Color(red: 56 / 255, green: 229 / 255, blue: 77 / 255))
                        .modifier { view in
                            if #available(iOS 17, *) {
                                view.symbolEffect(.bounce, value: animationCount)
                            } else {
                                view
                            }
                        }
                        .padding(.bottom, 40)
                    
                    Text("출석이 완료 되었습니다 :)")
                        .bold()
                        .foregroundColor(.gray)
                } else {
                    Image(systemName: "x.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width * 0.3)
                        .foregroundColor(Color(red: 187 / 255, green: 37 / 255, blue: 37 / 255))
                        .modifier { view in
                            if #available(iOS 17, *) {
                                view.symbolEffect(.bounce, value: animationCount)
                            } else {
                                view
                            }
                        }
                        .padding(.bottom, 40)
                    
                    Text("출석에 실패했습니다\n다시 시도해 주세요")
                        .bold()
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
            
            Button(action: {
                withAnimation(.bouncy(duration: 1)) {
                    viewModel.result = nil
                }
            }, label: {
                Text("확인")
                    .padding(8)
                    .frame(maxWidth: .infinity)
            })
            .buttonBorderShape(.roundedRectangle)
            .cornerRadius(30)
            .buttonStyle(.borderedProminent)
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { _ in
                animationCount += 1
            }
        }
        .padding()
    }
}

#Preview {
    AttendanceResultView<DefaultEAttendanceViewModel>()
        .environmentObject(AppDI.shared().getEAttendanceViewModel())
}
