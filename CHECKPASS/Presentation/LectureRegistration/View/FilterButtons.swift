//
//  FilterButtons.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/19/24.
//

import SwiftUI

struct FilterButtons<LRVM: LectureRegistrationViewModel>: View {
    @EnvironmentObject private var viewModel: LRVM
    @Binding var showSearchStandardPicker: Bool
    @Binding var showGradePicker: Bool
    @Binding var showLectureTypePicker: Bool
    @Binding var showCreditPicker: Bool
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Button(action: {
                    showSearchStandardPicker.toggle()
                }, label: {
                    Text("검색 기준: \(viewModel.searchStandard)")
                        .font(.caption)
                })
                .buttonStyle(.bordered)
                .tint(.red)
                
                Button(action: {
                    showGradePicker.toggle()
                }, label: {
                    Text("학년: \(viewModel.selectedGrade ?? "없음")")
                        .font(.caption)
                })
                .buttonStyle(.bordered)
                .tint(.green)
                
                Button(action: {
                    showLectureTypePicker.toggle()
                }, label: {
                    Text("구분: \(viewModel.selectedLectureType ?? "없음")")
                        .font(.caption)
                })
                .buttonStyle(.bordered)
                .tint(.blue)
                
                Button(action: {
                    showCreditPicker.toggle()
                }, label: {
                    Text("학점: \(viewModel.selectedCredit ?? "없음")")
                        .font(.caption)
                })
                .buttonStyle(.bordered)
                .tint(.purple)
                
                Spacer()
            }
        }
    }
}

#Preview {
    FilterButtons<DefaultLectureRegistrationViewModel>(
        showSearchStandardPicker: .constant(false),
        showGradePicker: .constant(false),
        showLectureTypePicker: .constant(false),
        showCreditPicker: .constant(false)
    )
    .environmentObject(AppDI.shared().getLectureSearchViewModel())
}
