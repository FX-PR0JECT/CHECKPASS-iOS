//
//  SignUpUseCaseTest.swift
//  CHECKPASSTests
//
//  Created by 이정훈 on 1/10/24.
//

import XCTest
import Combine
@testable import CHECKPASS

final class SignUpUseCaseTest: XCTestCase {
    private var usecase: SignUpUseCase!
    private var repository: AuthRepository!
    private var dataSource: DataSource!
    private var cancellables = Set<AnyCancellable>()
    private let colleges = Colleges(collegesDictionary: [
        "철도대학": "Railway",
        "교양학부": "FacultyOfLiberalArts",
        "인문사회대학": "HumanitiesSocialSciences",
        "미래융합대학": "FutureConvergence",
        "융합기술대학": "ConvergenceTechnology",
        "창의융합학부": "CreativeConvergence",
        "자유전공학부": "Free",
        "공과대학": "Engineering",
        "보건생명대학": "HealthLifeSciences"])
    
    private let departmens = Departments(departmentsDictionary: [
        "기계공학과": "MechanicalEngineering",
        "자동차공학과": "AutomotiveEngineering",
        "항공기계설계학과": "AircraftMechanicalDesign",
        "전기공학과": "ElectricalEngineering",
        "전자공학과": "ElectricEngineering",
        "컴퓨터공학과": "ComputerEngineering",
        "컴퓨터소프트웨어학과": "ComputerSoftware",
        "AI로봇공학과": "AIRoboticsEngineering",
        "바이오메디컬융합학과": "BiomedicalConvergence",
        "정밀의료/의료기기학과": "PrecisionMedicineMedicalDevices"
    ])

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        dataSource = DefaultDataSource()
        repository = DefaultAuthRepository(dataSource: dataSource)
        usecase = DefaultSignUpUseCase(repository: repository)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        usecase = nil
        repository = nil
        dataSource = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        test_signUpForStudent_whenValidDataGiven_sholdReturnTrue()
        test_signUpForStaff_whenValidDataGiven_sholdReturnTrue()
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            
            test_signUpForStudent_whenValidDataGiven_sholdReturnTrue()
            test_signUpForStaff_whenValidDataGiven_sholdReturnTrue()
        }
    }
    
    private func test_signUpForStudent_whenValidDataGiven_sholdReturnTrue() {
        let studentData = [
            "signUpId": "3000000", "signUpPassword": "123456a!", "signUpName": "홍길동",
            "signUpJob": "STUDENTS", "signUpCollege": "융합기술대학", "signUpDepartment": "컴퓨터공학과",
            "signUpGrade": "4학년", "signUpDayOrNight": "day", "signUpSemester": "1학기"
        ]
        
        usecase.executeForStudent(studentData, colleges: colleges, departments: departmens)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("successfully signed up")
                case .failure(let error):
                    print(error)
                }
            }, receiveValue: {
                XCTAssertTrue($0.result, "unexpected result")
            })
            .store(in: &cancellables)
    }
    
    private func test_signUpForStaff_whenValidDataGiven_sholdReturnTrue() {
        let staffData = [
            "signUpId": "2000000", "signUpPassword": "123456a!", "signUpName": "홍길동", "signUpJob": "STAFF",
            "signUpCollege": "융합기술대학", "signUpDepartment": "컴퓨터공학과", "signUpHireDate": "2024-01-03"
        ]
        
        usecase.executeForStaff(staffData, colleges: colleges, departments: departmens)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("successfully signed up")
                case .failure(let error):
                    print(error)
                }
            }, receiveValue: {
                XCTAssertTrue($0.result, "unexpected result")
            })
            .store(in: &cancellables)
    }

}
