//
//  GetDepartmentsUseCase.swift
//  CHECKPASSTests
//
//  Created by 이정훈 on 1/22/24.
//

import XCTest
import Combine
@testable import CHECKPASS

final class GetDepartmentsUseCaseTest: XCTestCase {
    private var useCase: GetDepartmentsUseCase!
    private var collegesRepository: CollegesRepository!
    private var departmentsRepository: DepartmentsRepository!
    private var dataSource: DataSource!
    private var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        dataSource = DefaultDataSource()
        collegesRepository = DefaultCollegesRepository(dataSource: dataSource)
        departmentsRepository = DefaultDepartmentsRepository(dataSource: dataSource)
        useCase = DefaultGetDepartmentsUseCase(departmentsRepository: departmentsRepository, collegesRepository: collegesRepository)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        dataSource = nil
        collegesRepository = nil
        departmentsRepository = nil
        useCase = nil
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            test_getCollegeData()
        }
    }
    
    func test_getCollegeData() {
        let result = Colleges(collegesDictionary: [
            "철도대학": "Railway",
            "교양학부": "FacultyOfLiberalArts",
            "인문사회대학": "HumanitiesSocialSciences",
            "미래융합대학": "FutureConvergence",
            "융합기술대학": "ConvergenceTechnology",
            "창의융합학부": "CreativeConvergence",
            "자유전공학부": "Free",
            "공과대학": "Engineering",
            "보건생명대학": "HealthLifeSciences"
        ])
        
        useCase.executeForColleges()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("successfully fetched colleges data")
                case .failure(let error):
                    print("test_getCollegeData(): ", error)
                }
            }, receiveValue: {
                XCTAssertEqual(result, $0, "unexpected result")
            })
            .store(in: &cancellables)
    }
    
    func test_getDepartments() {
        let result = Departments(departmentsDictionary: [
            "영어영문학과": "EnglishLanguageLiterature",
            "중국어학과": "ChineseLanguage",
            "한국어문학과": "KoreanLanguageLiterature",
            "행정학과": "PublicAdministration",
            "행정정보융합학과": "AdministrativeInformationConvergence",
            "경영학과": "BusinessAdministration",
            "융합경영학과": "ConvergenceManagement",
            "국제무역학과": "InternationalTrade",
            "사회복지학과": "SocialWelfare",
            "음악학과": "Music",
            "스포츠의학과": "zSportsMedicine",
            "스포츠산업학과": "SportsIndustry",
            "항공서비스학과": "AviationService",
            "항공운항학과": "AviationOperations",
            "유야교육학과": "EarlyChildhoodEducation",
            "미디어콘텐츠학과": "MediaContents"])
        
        useCase.executeForDeparments(college: "인문사회대학")
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("successfully fetched departments data")
                case .failure(let error):
                    print("test_getDepartments(): ", error)
                }
            }, receiveValue: {
                print($0)
                XCTAssertEqual(result, $0, "unexpected result")
            })
            .store(in: &cancellables)
    }

}

extension Departments: Equatable {
    public static func == (lhs: Departments, rhs: Departments) -> Bool {
        var result: Bool = true
        
        lhs.departmentList.forEach {
            if !rhs.departmentList.contains($0) {
                result = false
            }
        }
        
        return result
    }
    
}

extension Colleges: Equatable {
    public static func == (lhs: Colleges, rhs: Colleges) -> Bool {
        var result: Bool = true
        
        lhs.collegeList.forEach {
            if !rhs.collegeList.contains($0) {
                result = false
            }
        }
        
        return result
    }
}
