//
//  EAttendance.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/5/24.
//

import SwiftUI

struct EAttendance<T: AttendanceViewModel>: View {
    @ObservedObject private var viewModel: T
    @FocusState private var focusedField: Bool
    
    private var lecture: Lecture
    
    init(viewModel: T, lecture: Lecture) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
        self.lecture = lecture
    }
    
    var body: some View {
        if viewModel.result != nil {
            AttendanceResultView<T>()
                .environmentObject(viewModel)
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("전자출석")
                .toolbar(.hidden, for: .tabBar)
        } else {
            ZStack {
                if viewModel.isProgress {
                    CustomProgressView()
                }
                
                if var viewModel = viewModel as? EAttendanceViewModel {
                    TextField("", text: Binding(get: {
                        viewModel.input
                    }, set: { newValue in
                        viewModel.input = newValue
                    }))
                    .focused($focusedField, equals: true)
                    .autocorrectionDisabled()
                    .keyboardType(.decimalPad)
                    .frame(width: 0)
                    
                    VStack(alignment: .leading) {
                        HStack(spacing: 0) {
                            Text(lecture.lectureName)
                                .font(.largeTitle)
                                .bold()
                            
                            Text("(\(lecture.division))")
                        }
                        .padding(.bottom, 30)
                        
                        HStack {
                            Spacer()
                            
                            VStack(alignment: .leading) {
                                Text("출석 코드")
                                    .font(.title3)
                                    .bold()
                                
                                HStack(spacing: 25) {
                                    CodeInput(input: Binding(get: {
                                        viewModel.input
                                    }, set: { newValue in
                                        viewModel.input = newValue
                                    }), index: 0)
                                    
                                    CodeInput(input: Binding(get: {
                                        viewModel.input
                                    }, set: { newValue in
                                        viewModel.input = newValue
                                    }), index: 1)
                                    
                                    CodeInput(input: Binding(get: {
                                        viewModel.input
                                    }, set: { newValue in
                                        viewModel.input = newValue
                                    }), index: 2)
                                    
                                    CodeInput(input: Binding(get: {
                                        viewModel.input
                                    }, set: { newValue in
                                        viewModel.input = newValue
                                    }), index: 3)
                                }
                                .onTapGesture {
                                    focusedField = true
                                }
                            }
                            
                            Spacer()
                        }
                        
                        CurrentTimeView()
                            .padding([.top, .bottom])
                        
                        Divider()
                        
                        Spacer()
                        
                        Button(action: {
                            viewModel.executeForEAttendance()
                        }, label: {
                            Text("출석하기")
                                .padding(8)
                                .frame(maxWidth: .infinity)
                        })
                        .buttonBorderShape(.roundedRectangle)
                        .cornerRadius(30)
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                    .modifier { view in
                        if #available(iOS 17.0, *) {
                            view.onChange(of: viewModel.input) {
                                viewModel.verifyInput(viewModel.input)
                                
                                if viewModel.input.count == 4 {
                                    dismissKeyboard()
                                }
                            }
                        } else {
                            view.onChange(of: viewModel.input, perform: { newValue in
                                viewModel.verifyInput(newValue)
                                
                                if newValue.count == 4 {
                                    dismissKeyboard()
                                }
                            })
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("전자출석")
            .toolbar(.hidden, for: .tabBar)
            .onAppear {
                focusedField = true
            }
                
        }
    }
}

#if DEBUG
#Preview {
    EAttendance<DefaultEAttendanceViewModel>(viewModel: AppDI.shared().getEAttendanceViewModel(),
                                             lecture: Lecture.sampleData)
}
#endif
