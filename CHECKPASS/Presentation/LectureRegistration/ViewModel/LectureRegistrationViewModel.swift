//
//  LectureRegistrationViewModel.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/19/24.
//

import Combine

protocol LectureRegistrationViewModel: ObservableObject {
    var searchKeyword: String { get set }
    var searchStandard: String { get set }
    var selectedGrade: String? { get set }
    var selectedLectureType: String? { get set }
    var selectedCredit: String? { get set }
    var lectures: [LectureInfo]? { get set }
    
    func searchLectures()
}

final class DefaultLectureRegistrationViewModel {
    @Published var searchKeyword: String = ""
    @Published var searchStandard: String = "강의명"
    @Published var selectedGrade: String?
    @Published var selectedLectureType: String?
    @Published var selectedCredit: String?
    @Published var lectures: [LectureInfo]? = []
    
    private let usecase: LectureSearchUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(usecase: LectureSearchUseCase) {
        self.usecase = usecase
    }
}

extension DefaultLectureRegistrationViewModel: LectureRegistrationViewModel {
    func searchLectures() {
        guard let standard = SearchStandard(rawValue: searchStandard) else {
            return
        }
        
        let publisher: AnyPublisher<[LectureInfo], Error>
        
        switch standard {
        case .profName:
            publisher = usecase.execute(lectureGrade: selectedGrade,
                                        lectureKind: selectedLectureType,
                                        lectureGrades: selectedCredit,
                                        lectureCode: nil,
                                        lectureName: nil,
                                        professorName: searchKeyword)
        case .lectureCode:
            publisher = usecase.execute(lectureGrade: selectedGrade,
                                        lectureKind: selectedLectureType,
                                        lectureGrades: selectedCredit,
                                        lectureCode: searchKeyword,
                                        lectureName: nil,
                                        professorName: nil)
        case .lectureName:
            publisher = usecase.execute(lectureGrade: selectedGrade,
                                        lectureKind: selectedLectureType,
                                        lectureGrades: selectedCredit,
                                        lectureCode: nil,
                                        lectureName: searchKeyword,
                                        professorName: nil)
        }
        
        publisher.sink(receiveCompletion: { [weak self] completion in
            switch completion {
            case .finished:
                print("successfully fetched lecture information")
            case .failure(let error):
                print("DefaultLectureRegistrationViewModel.searchLectures() error: ", error)
                self?.lectures = nil
            }
        }, receiveValue: { [weak self] in
            self?.lectures = $0
        })
        .store(in: &cancellables)
    }
}
