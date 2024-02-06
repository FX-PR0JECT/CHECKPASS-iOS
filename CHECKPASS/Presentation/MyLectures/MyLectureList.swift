//
//  MyLectureListView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/24/24.
//

import SwiftUI

struct MyLectureList: View {
    #if DEBUG
    @State private var selectedSemester: String = SimpleLecture.sampleDataKeys.first ?? ""
    #else
    #endif
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Sectionheader(header: "학기 선택")) {
                    #if DEBUG
                    Picker("학기", selection: $selectedSemester) {
                        ForEach(SimpleLecture.sampleDataKeys, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    #else
                    #endif
                }
                
                Section(header: Sectionheader(header: "수강 중인 강의")) {
                    #if DEBUG
                    if selectedSemester.isEmpty {
                        Text("수강 중인 강의가 없습니다")
                    } else {
                        ForEach(SimpleLecture.sampleData[selectedSemester] ?? []) { lecture in
                            NavigationLink(destination: {
                                //Lecture Detail
                            }, label: {
                                SimpleLectureListRow(lecture)
                            })
                        }
                    }
                    #else
                    #endif
                }
            }
            .navigationTitle("내 강의")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    MyLectureList()
}
