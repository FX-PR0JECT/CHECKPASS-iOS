//
//  EAttendance.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/5/24.
//

import SwiftUI

struct EAttendance: View {
    @State private var inputs: String = ""
    @FocusState private var focusedField: Bool
    
    var lecture: Lecture
    
    var body: some View {
        ZStack {
            TextField("", text: $inputs)
                .focused($focusedField, equals: true)
                .autocorrectionDisabled()
                .keyboardType(.asciiCapable)
                .frame(width: 0)
            
            VStack {
                VStack(alignment: .leading) {
                    HStack(spacing: 2) {
                        Text(lecture.lectureName)
                            .font(.largeTitle)
                            .bold()
                        
                        Spacer()
                    }
                    
                    HStack {
                        Text("\(lecture.professorName) 교수님")
                        
                        Text("•")
                        
                        Text("\(lecture.division)")
                    }
                    .font(.subheadline)
                }
                .padding(.bottom, 30)
                
                VStack(alignment: .leading) {
                    Text("출석 코드")
                        .font(.title3)
                        .bold()
                    
                    HStack(spacing: 25) {
                        CodeInput(input: $inputs, index: 0)
                        
                        CodeInput(input: $inputs, index: 1)
                        
                        CodeInput(input: $inputs, index: 2)
                        
                        CodeInput(input: $inputs, index: 3)
                    }
                    .onTapGesture {
                        focusedField = true
                    }
                }
                
                CurrentTimeView()
                    .padding(.top)
                
                Spacer()
                
                Button(action: {}, label: {
                    Text("출석하기")
                        .padding(8)
                        .frame(maxWidth: .infinity)
                })
                .buttonBorderShape(.roundedRectangle)
                .cornerRadius(30)
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .onAppear {
                focusedField = true
            }
            .modifier { view in
                if #available(iOS 17.0, *) {
                    view.onChange(of: inputs) {
                        verifyInputString(inputs)
                        
                        if inputs.count == 4 {
                            dismissKeyboard()
                        }
                    }
                } else {
                    view.onChange(of: inputs, perform: { newValue in
                        verifyInputString(newValue)
                        
                        if newValue.count == 4 {
                            dismissKeyboard()
                        }
                    })
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
    }
}

extension EAttendance {
    func verifyInputString(_ newValue: String) {
        if newValue.count > 4 {
            let start = newValue.startIndex
            let end = newValue.index(start, offsetBy: 3)
            
            self.inputs = String(newValue[start...end])
        }
    }
}

#if DEBUG
#Preview {
    EAttendance(lecture: Lecture.sampleData)
}
#endif
