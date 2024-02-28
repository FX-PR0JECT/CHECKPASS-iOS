//
//  MyLectureListView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/24/24.
//

import SwiftUI

struct MyLectureList: View {
    @State private var showRegistraion: Bool = false
    @State private var showSemesterPicker: Bool = false
    #if DEBUG
    @State private var selectedSemester: String = SimpleLecture.sampleDataKeys.first ?? ""
    #else
    #endif
    
    var body: some View {
        NavigationStack {
            List {
                HStack {
                    Button(action: {
                        showSemesterPicker.toggle()
                    }, label: {
                        HStack(spacing: 1) {
                            Text(selectedSemester)
                                .bold()
                            
                            Image(systemName: "arrowtriangle.down.fill")
                                .font(.caption2)
                        }
                        .overlay(Rectangle()
                                    .frame(height: 1)
                                    .offset(y: 4), alignment: .bottom)
                        .foregroundColor(.black)
                    })
                    .buttonStyle(.borderless)
                    .padding(.trailing)
                    
                    Spacer()
                }
                .listRowSeparator(.hidden)
                
                Section(header: Sectionheader(header: "수강 내역")) {
                    #if DEBUG
                    if selectedSemester.isEmpty {
                        Text("수강 중인 강의가 없습니다")
                    } else {
                        ForEach(SimpleLecture.sampleData[selectedSemester] ?? []) { lecture in
                            NavigationLink(destination: {
                                //Lecture Detail
                            }, label: {
                                SimpleLectureListRow(lecture)
                                    .padding(10)
                            })
                        }
                    }
                    #else
                    #endif
                }
            }
            .listStyle(.plain)
            .navigationTitle("내 강의")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showRegistraion.toggle()
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
            }
            .fullScreenCover(isPresented: $showRegistraion) {
                LectureEnrollmentView(viewModel: AppDI.shared().getLectureSearchViewModel(), showEnrollmentView: $showRegistraion
                )
            }
            .sheet(isPresented: $showSemesterPicker) {
                Picker("", selection: $selectedSemester) {
                    ForEach(SimpleLecture.sampleDataKeys, id: \.self) {
                        Text("\($0)")
                    }
                }
                .pickerStyle(.wheel)
                .presentationDetents([.height(UIScreen.main.bounds.height * 0.2)])
                .presentationDragIndicator(.visible)
            }
        }
    }
}

#Preview {
    MyLectureList()
}
