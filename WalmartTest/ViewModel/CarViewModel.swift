//
//  CarViewModel.swift
//  WalmartTest
//
//  Created by Shanmin on 2018-12-12.
//  Copyright © 2018 Heavenbrook. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import ObjectMapper

class CarViewModel {
    
    let carService = CarService()
    var carArr: [CarModel] = []
    var cars: BehaviorRelay<[CarModel]> = BehaviorRelay(value: [])
    let navigationTitle: Observable<String>
    
    init() {
        let jsonResponse = carService.getCarsResponse()
        self.carArr = Mapper<CarModel>().mapArray(JSONString: jsonResponse) ?? []
        for i in 0..<self.carArr.count {
            // get availability
            let jsonResponse = carService.getCarAvailabilityResponse(carId: self.carArr[i].id)
            let carTemp = Mapper<CarModel>().map(JSONString: jsonResponse)
            self.carArr[i].available = carTemp?.available ?? .unavailable
        }
        self.cars.accept(self.carArr)

        self.navigationTitle = self.cars.map{"\($0.count) Cars"}
    }
    
    func sortBy(path: KeyPath<CarModel, String>) {
        self.cars.accept(self.carArr.sorted(by: { $0[keyPath: path] < $1[keyPath: path] }))
    }
}
