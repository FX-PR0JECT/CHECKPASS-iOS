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
    func observeBeacons()
    func attend(lectureId: Int)
}

final class DefaultBeaconAttendanceViewModel: AttendanceViewModel {
    @Published var result: Bool?
    @Published var resultSet = ""
    @Published var isProgress = false
    @Published var beacons: [CLBeacon]?
    @Published var lectures: [Lecture]?
    
    private let beaconScanUseCase: BeaconScanUseCase
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
    func startScan() {
        beaconScanUseCase.execute()
            .sink(receiveValue: { [weak self] beacons in
                self?.beacons = beacons
            })
            .store(in: &cancellables)
    }
    
    func observeBeacons() {
        //observing beacons property
        $beacons
            .dropFirst()
            .sink(receiveValue: { [weak self] beacons in
                beacons?.forEach { beacon in
                    self?.executeForFetchingLecture(by: beacon)
                }
            })
            .store(in: &cancellables)
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
                lectures.forEach { lecture in
                    if self?.lectures?.contains(lecture) != true {
                        self?.lectures?.append(lecture)
                    }
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
