//
//  LectureEnrollmentView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/19/24.
//

import SwiftUI

struct LectureEnrollmentView<T: LectureSearchViewModel, U: LectureHistoryViewModel>: View {
    @StateObject private var lectureSearchViewModel: T
    @EnvironmentObject private var lectureHistoryViewModel: U
    @State private var showSearchStandardPicker: Bool = false
    @State private var showGradePicker: Bool = false
    @State private var showLectureTypePicker: Bool = false
    @State private var showCreditPicker: Bool = false
    @Binding private var showEnrollmentView: Bool
    
    init(viewModel: T, showEnrollmentView: Binding<Bool>) {
        _lectureSearchViewModel = StateObject(wrappedValue: viewModel)
        _showEnrollmentView = showEnrollmentView
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                FilterButtons<T>(
                    showSearchStandardPicker: $showSearchStandardPicker,
                    showGradePicker: $showGradePicker,
                    showLectureTypePicker: $showLectureTypePicker,
                    showCreditPicker: $showCreditPicker)
                .environmentObject(lectureSearchViewModel)
                .padding(.leading)
                
                List {
                    ForEach(lectureSearchViewModel.lectures ?? []) { lecture in
                        SearchedLectureListRow(viewModel: AppDI.shared().getLectureEnrollmentViewModel(),
                                               lecture: lecture)
                        .listRowSeparator(.hidden)
                    }
                }
            }
            .searchable(text: $lectureSearchViewModel.searchKeyword, placement: .toolbar)
            .navigationTitle("개설 강좌 확인")
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.plain)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showEnrollmentView.toggle()
                    }, label: {
                        Text("완료")
                    })
                }
            }
            .sheet(isPresented: $showSearchStandardPicker) {
                Picker("", selection: $lectureSearchViewModel.searchStandard) {
                    ForEach(SearchStandard.allCases) {
                        Text($0.rawValue).tag($0.rawValue as String)
                    }
                }
                .pickerStyle(.wheel)
                .presentationDetents([.height(UIScreen.main.bounds.height * 0.2)])
                .presentationDragIndicator(.visible)
            }
            .sheet(isPresented: $showGradePicker) {
                Picker("", selection: $lectureSearchViewModel.selectedGrade) {
                    Text("없음").tag(nil as String?)
                    
                    ForEach(Grades.allCases) {
                        Text($0.rawValue).tag($0.rawValue as String?)
                    }
                }
                .pickerStyle(.wheel)
                .presentationDetents([.height(UIScreen.main.bounds.height * 0.2)])
                .presentationDragIndicator(.visible)
            }
            .sheet(isPresented: $showLectureTypePicker) {
                Picker("", selection: $lectureSearchViewModel.selectedLectureType) {
                    Text("없음").tag(nil as String?)
                    
                    ForEach(LectureType.allCases) {
                        Text($0.rawValue).tag($0.rawValue as String?)
                    }
                }
                .pickerStyle(.wheel)
                .presentationDetents([.height(UIScreen.main.bounds.height * 0.2)])
                .presentationDragIndicator(.visible)
            }
            .sheet(isPresented: $showCreditPicker) {
                Picker("", selection: $lectureSearchViewModel.selectedCredit) {
                    Text("없음").tag(nil as String?)
                    
                    ForEach(Credit.allCases) {
                        Text($0.rawValue).tag($0.rawValue as String?)
                    }
                }
                .pickerStyle(.wheel)
                .presentationDetents([.height(UIScreen.main.bounds.height * 0.2)])
                .presentationDragIndicator(.visible)
            }
            .onAppear {
                lectureSearchViewModel.observe()
            }
            .onDisappear {
                lectureHistoryViewModel.fetchHistory()
            }
        }
    }
}

#Preview {
    LectureEnrollmentView<DefaultLectureSearchViewModel, DefaultLectureHistoryViewModel>(viewModel: AppDI.shared().getLectureSearchViewModel(), showEnrollmentView: .constant(true))
        .environmentObject(AppDI.shared().getLectureHistoryViewModel())
}
