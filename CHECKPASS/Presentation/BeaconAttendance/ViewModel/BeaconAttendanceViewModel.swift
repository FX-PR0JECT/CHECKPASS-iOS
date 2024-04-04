//
//  BeaconAttendanceViewModel.swift
//  CHECKPASS
//
//  Created by 이정훈 on 3/5/24.
//

import Combine
import CoreLocation

protocol BeaconAttendanceViewModel {
    var beacons: [CLBeacon]? { get set }
    var lectures: [Lecture]? { get set }
    
    func startScan()
    func stopScan()
    func attend(lectureId: Int)
}

final class DefaultBeaconAttendanceViewModel: AttendanceViewModel {
    @Published var result: Bool?
    @Published var resultSet = ""
    @Published var isProgress = false
    @Published var beacons: [CLBeacon]?
    @Published var lectures: [Lecture]?
    
    private var beaconScanUseCase: BeaconScanUseCase
    private let lectureUseCase: GetLectureByBeaconInfoUseCase
    private let attendanceUseCase: AttendanceUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(beaconScanUseCase: BeaconScanUseCase,
         lectureUseCase: GetLectureByBeaconInfoUseCase,
         attendanceUseCase: AttendanceUseCase) {
        self.beaconScanUseCase = beaconScanUseCase
        self.lectureUseCase = lectureUseCase
        self.attendanceUseCase = attendanceUseCase
    }
}

extension DefaultBeaconAttendanceViewModel: BeaconAttendanceViewModel {
    //MARK: - start beaconc scan
    func startScan() {
        beaconScanUseCase.execute()
        
        beaconScanUseCase.subscribeBeacons()
            .sink(receiveValue: { [weak self] beacons in
                self?.beacons = beacons
            })
            .store(in: &cancellables)
        
        $beacons
            .dropFirst()
            .sink(receiveValue: { [weak self] beacons in
                beacons?.forEach { beacon in
                    self?.executeForFetchingLecture(by: beacon)
                }
            })
            .store(in: &cancellables)
    }
    
    //MARK: - stop beacons scan
    func stopScan() {
        beaconScanUseCase.abort()
    }
    
    private func executeForFetchingLecture(by beacon: CLBeacon) {
        lectureUseCase.execute(by: beacon)
            .sink(receiveCompletion: {completion in
                switch completion {
                case .finished:
                    print("Successfully request to fetch lecture data")
                case .failure(let error):
                    print("DefaultBeaconAttendanceViewModel.executeFetchingLecture(by:) error: ", error)
                }
            }, receiveValue: { [weak self] lectures in
                //lectures is Array type that contains only one value
                if let viewModelLectures = self?.lectures {
                    if !viewModelLectures.contains(lectures[0]) {
                        self?.lectures?.append(lectures[0])
                    }
                } else {
                    self?.lectures = [lectures[0]]
                }
            })
            .store(in: &self.cancellables)
    }
    
    func attend(lectureId: Int) {
        attendanceUseCase.executeForBeaconAttendance(byId: lectureId)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("successfully request to attend by beacon information")
                case .failure(let error):
                    print("DefaultBeaconAttendanceViewModel.executeAttedance(lectureCode:) error:", error)
                }
            }, receiveValue: { [weak self] in
                self?.result = $0.result
                self?.resultSet = $0.resultSet
            })
            .store(in: &cancellables)
    }
}
