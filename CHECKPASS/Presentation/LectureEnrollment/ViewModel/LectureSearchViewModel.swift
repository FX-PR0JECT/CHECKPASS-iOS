//
//  LectureSearchViewModel.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/19/24.
//

import Combine
import Foundation

protocol LectureSearchViewModel: ObservableObject {
    var searchKeyword: String { get set }
    var searchStandard: String { get set }
    var selectedGrade: String? { get set }
    var selectedLectureType: String? { get set }
    var selectedCredit: String? { get set }
    var lectures: [Lecture]? { get set }
    
    func searchLectures(keyword: String)
    func observe()
}

final class DefaultLectureSearchViewModel {
    @Published var searchKeyword: String = ""
    @Published var searchStandard: String = "강의명"
    @Published var selectedGrade: String?
    @Published var selectedLectureType: String?
    @Published var selectedCredit: String?
    @Published var lectures: [Lecture]?
    
    private let usecase: LectureSearchUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(usecase: LectureSearchUseCase) {
        self.usecase = usecase
    }
}

extension DefaultLectureSearchViewModel: LectureSearchViewModel {
    func observe() {
        $selectedGrade
            .sink(receiveValue: { [weak self] _ in
                self?.search()
            })
            .store(in: &cancellables)
        
        $selectedLectureType
            .sink(receiveValue: { [weak self] _ in
                self?.search()
            })
            .store(in: &cancellables)
        
        $searchStandard
            .sink(receiveValue: { [weak self] _ in
                self?.search()
            })
            .store(in: &cancellables)
        
        $selectedCredit
            .sink(receiveValue: { [weak self] _ in
                self?.search()
            })
            .store(in: &cancellables)
        
        $searchKeyword
            .debounce(for: 0.5, scheduler: RunLoop.main)    //0.5초 이내에 새로운 값이 입력되지 않을때 값을 방출
            .sink(receiveValue: { [weak self] _ in
                self?.search()
            })
            .store(in: &cancellables)
    }
    
    private func search() {
        if !searchKeyword.isEmpty && searchKeyword.first != " " {
            searchLectures(keyword: searchKeyword)
        }
    }
    
    func searchLectures(keyword: String) {
        guard let standard = SearchStandard(rawValue: searchStandard) else {
            return
        }
        
        let publisher: AnyPublisher<[Lecture], Error>
        
        switch standard {
        case .profName:
            publisher = usecase.execute(lectureGrade: selectedGrade,
                                        lectureKind: selectedLectureType,
                                        lectureGrades: selectedCredit,
                                        lectureCode: nil,
                                        lectureName: nil,
                                        professorName: keyword)
        case .lectureCode:
            publisher = usecase.execute(lectureGrade: selectedGrade,
                                        lectureKind: selectedLectureType,
                                        lectureGrades: selectedCredit,
                                        lectureCode: keyword,
                                        lectureName: nil,
                                        professorName: nil)
        case .lectureName:
            publisher = usecase.execute(lectureGrade: selectedGrade,
                                        lectureKind: selectedLectureType,
                                        lectureGrades: selectedCredit,
                                        lectureCode: nil,
                                        lectureName: keyword,
                                        professorName: nil)
        }
        
        publisher.sink(receiveCompletion: { [weak self] completion in
            switch completion {
            case .finished:
                print("successfully fetched lecture information")
            case .failure(let error):
                print("DefaultLectureSearchViewModel.searchLectures() error: ", error)
                self?.lectures = nil
            }
        }, receiveValue: { [weak self] in
            self?.lectures = $0
        })
        .store(in: &cancellables)
    }
}
