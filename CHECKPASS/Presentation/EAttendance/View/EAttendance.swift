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
    
    var lecture: SimpleLecture
    
    var body: some View {
        ZStack {
            TextField("", text: $inputs)
                .focused($focusedField, equals: true)
                .autocorrectionDisabled()
                .keyboardType(.asciiCapable)
                .frame(width: 0)
            
            VStack {
                HStack(spacing: 25) {
                    CodeInput(input: $inputs, index: 0)
                    
                    CodeInput(input: $inputs, index: 1)
                    
                    CodeInput(input: $inputs, index: 2)
                    
                    CodeInput(input: $inputs, index: 3)
                }
                .onTapGesture {
                    focusedField = true
                }
                
                Spacer()
                
                Button(action: {}, label: {
                    Text("출석하기")
                        .bold()
                        .padding(.all, 15)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(.blue)
                        .cornerRadius(30)
                })
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
    }
}

extension View {
    func modifier<ModifiedContent: View>(
        @ViewBuilder body: (_ content: Self) -> ModifiedContent
    ) -> ModifiedContent {
        body(self)
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

#Preview {
    EAttendance(lecture: SimpleLecture(id: "103834", name: "Java 프로그래밍", professor: "홍길동", division: "1분반"))
}
