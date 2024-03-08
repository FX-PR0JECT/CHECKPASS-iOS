//
//  LectureHistoryList.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/24/24.
//

import SwiftUI

struct LectureHistoryList<T: LectureHistoryViewModel>: View {
    @ObservedObject private var viewModel: T
    @State private var showRegistraion: Bool = false
    @State private var showSemesterPicker: Bool = false
    @State private var selectedSemester: String?
    
    init(viewModel: T) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            List {
                //Semester Selector
                HStack {
                    Button(action: {
                        showSemesterPicker.toggle()
                    }, label: {
                        HStack(spacing: 1) {
                            Text(selectedSemester ?? "학기선택")
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
                
                //Lecture List
                Section(header: Sectionheader(header: "수강 내역")) {
                    if let selectedSemester {
                        ForEach(viewModel.history?[selectedSemester] ?? []) { lecture in
                            NavigationLink(destination: {
                                //Lecture Detail
                            }, label: {
                                SimpleLectureListRow(lecture)
                                    .padding([.top, .bottom])
                            })
                            .listRowSeparator(.hidden)
                        }
                        .listSectionSeparator(.visible, edges: .top)
                    } else {
                        Text("수강 중인 강의가 없습니다")
                            .listRowSeparator(.hidden)
                            .listSectionSeparator(.visible, edges: .top)
                    }
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
                LectureEnrollmentView<_, T>(viewModel: AppDI.shared().getLectureSearchViewModel(), showEnrollmentView: $showRegistraion
                )
                .environmentObject(viewModel)
            }
            .sheet(isPresented: $showSemesterPicker) {
                Picker("", selection: $selectedSemester) {
                    ForEach(viewModel.sortedHistoryKeys ?? [], id: \.self) {
                        Text("\($0)")
                    }
                }
                .pickerStyle(.wheel)
                .presentationDetents([.height(UIScreen.main.bounds.height * 0.2)])
                .presentationDragIndicator(.visible)
            }
            .onAppear {
                viewModel.fetchHistory()
            }
            .onChange(of: viewModel.history, perform: { newValue in
                self.selectedSemester = newValue?.keys.first
            })
        }
    }
}

#Preview {
    LectureHistoryList(viewModel: AppDI.shared().getLectureHistoryViewModel())
}
