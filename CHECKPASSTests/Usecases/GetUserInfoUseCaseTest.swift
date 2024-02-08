//
//  GetUserInfoUseCaseTest.swift
//  CHECKPASSTests
//
//  Created by 이정훈 on 1/18/24.
//

import XCTest
import Combine
@testable import CHECKPASS

final class GetUserInfoUseCaseTest: XCTestCase {
    private var useCase: GetUserInfoUseCase!
    private var repository: UserRepository!
    private var dataSource: DataSource!
    private var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        dataSource = DefaultDataSource()
        repository = DefaultUserRepository(dataSource: dataSource)
        useCase = DefaultGetUserInfoUseCase(repository: repository)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        dataSource = nil
        repository = nil
        useCase = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        test_simpleUserInfoRequest()
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            test_simpleUserInfoRequest()
        }
    }
    
    func test_simpleUserInfoRequest() {
        let result = SimpleUserInfo(userId: 123456789,
                                    userName: "Lee",
                                    userDepartment: "컴퓨터소프트웨어학과",
                                    jobType: .student)
        
        useCase.executeForSimpleUserInfo()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("successfully fetched user info")
                case .failure(let error):
                    print("UserInfoViewModel.getSimpleUserInfo(): ", error)
                }
            }, receiveValue: {
                XCTAssertEqual(result, $0, "unexpected result")
            })
            .store(in: &cancellables)
    }
}

extension SimpleUserInfo: Equatable {
    public static func == (lhs: SimpleUserInfo, rhs: SimpleUserInfo) -> Bool {
        if lhs.userId == rhs.userId &&
            lhs.userName == rhs.userName &&
            lhs.userDepartment == rhs.userDepartment &&
            lhs.jobType == rhs.jobType {
            return true
        } else {
            return false
        }
    }
    
}
