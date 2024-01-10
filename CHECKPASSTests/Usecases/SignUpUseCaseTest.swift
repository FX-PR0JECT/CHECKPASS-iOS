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
        
        test_signUp_whenValidDataGiven_sholdReturnTrue()
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            
            test_signUp_whenValidDataGiven_sholdReturnTrue()
        }
    }
    
    private func test_signUp_whenValidDataGiven_sholdReturnTrue() {
        let studentData = [
            "signUpId": "1900000", "signUpPassword": "123456a!", "signUpName": "홍길동",
            "signUpJob": "STUDENT", "signUpCollege": "융합기술대학교", "signUpDepartment": "컴퓨터공학과",
            "signUpGrade": "4학년", "signUpDayOrNight": "day", "signUpSemester": "1학기"
        ]
        
        let staffData = [
            "signUpId": "9999999", "signUpPassword": "123456a!", "signUpName": "홍길동", "signUpJob": "STAFF",
            "signUpCollege": "융합기술대학교", "signUpDepartment": "컴퓨터공학과", "signUpHireDate": "2024-01-03"
        ]
        
        usecase.executeForStudent(studentData)
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
        
        usecase.executeForStaff(staffData)
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
