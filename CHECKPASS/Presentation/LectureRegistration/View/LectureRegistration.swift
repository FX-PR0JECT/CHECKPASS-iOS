//
//  LectureRegistration.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/19/24.
//

import SwiftUI

struct LectureRegistration<T: LectureRegistrationViewModel>: View {
    @ObservedObject private var viewModel: T
    @State private var showSearchStandardPicker: Bool = false
    @State private var showGradePicker: Bool = false
    @State private var showLectureTypePicker: Bool = false
    @State private var showCreditPicker: Bool = false
    @Binding private var showRegistration: Bool
    
    init(viewModel: T, showRegistration: Binding<Bool>) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
        _showRegistration = showRegistration
    }
    
    var body: some View {
        NavigationStack {
            List {
                FilterButtons<T>(
                    showSearchStandardPicker: $showSearchStandardPicker,
                    showGradePicker: $showGradePicker, 
                    showLectureTypePicker: $showLectureTypePicker, 
                    showCreditPicker: $showCreditPicker)
                .environmentObject(viewModel)
                .listRowSeparator(.hidden)
            }
            .searchable(text: $viewModel.searchKeyword, placement: .toolbar)
            .navigationTitle("개설 강좌 확인")
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.plain)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showRegistration.toggle()
                    }, label: {
                        Text("완료")
                    })
                }
            }
            .sheet(isPresented: $showSearchStandardPicker) {
                Picker("", selection: $viewModel.searchStandard) {
                    ForEach(SearchStandard.allCases) {
                        Text($0.rawValue).tag($0.rawValue as String)
                    }
                }
                .pickerStyle(.wheel)
                .presentationDetents([.height(UIScreen.main.bounds.height * 0.2)])
                .presentationDragIndicator(.visible)
            }
            .sheet(isPresented: $showGradePicker) {
                Picker("", selection: $viewModel.selectedGrade) {
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
                Picker("", selection: $viewModel.selectedLectureType) {
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
                Picker("", selection: $viewModel.selectedCredit) {
                    Text("없음").tag(nil as String?)
                    
                    ForEach(Credit.allCases) {
                        Text($0.rawValue).tag($0.rawValue as String?)
                    }
                }
                .pickerStyle(.wheel)
                .presentationDetents([.height(UIScreen.main.bounds.height * 0.2)])
                .presentationDragIndicator(.visible)
            }
            .onChange(of: viewModel.searchKeyword, perform: { _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    viewModel.searchLectures()
                }
            })
        }
    }
}

#Preview {
    LectureRegistration<DefaultLectureRegistrationViewModel>(viewModel: AppDI.shared().getLectureSearchViewModel(), showRegistration: .constant(true))
}
