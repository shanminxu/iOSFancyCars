//
//  CarService.swift
//  WalmartTest
//
//  Created by Shanmin on 2018-12-12.
//  Copyright © 2018 Heavenbrook. All rights reserved.
//

import Foundation
import Moya

class CarService {
    func getCarsResponse() -> String {
        return "[ {\"id\": 1, \"img\": \"FordEscape\", \"name\": \"My Fancy Car1\", \"make\": \"Ford\", \"model\": \"Escape\", \"year\": \"2017\"}, {\"id\": 2, \"img\": \"BMW_X5\", \"name\": \"My Fancy Car2\", \"make\": \"BMW\", \"model\": \"X5\", \"year\": \"2018\"},{\"id\": 3, \"img\": \"DodgeGrandCaravan\", \"name\": \"My Fancy Car3\", \"make\": \"Dodge\", \"model\": \"Grand Caravan\", \"year\": \"2015\"}, {\"id\": 4, \"img\": \"FordEscape\", \"name\": \"My Fancy Car4\", \"make\": \"Ford\", \"model\": \"Escape\", \"year\": \"2017\"}, {\"id\": 5, \"img\": \"BMW_X5\", \"name\": \"My Fancy Car5\", \"make\": \"BMW\", \"model\": \"X5\", \"year\": \"2018\"},{\"id\": 6, \"img\": \"DodgeGrandCaravan\", \"name\": \"My Fancy Car6\", \"make\": \"Dodge\", \"model\": \"Grand Caravan\", \"year\": \"2015\"} ]"
    }

    func getCarAvailabilityResponse(carId: Int) -> String {
        switch carId % 3 {
        case 0 :
            return "{\"available\": \"In Dealership\"}"
        case 1 :
            return "{\"available\": \"Unavailable\"}"
        default :
            return "{\"available\": \"Out of Stock\"}"
        }
    }
}

let CarServiceProvider = MoyaProvider<CarAPI>()

enum CarAPI {
    case carService
    case availabilityService(Int)
}

extension CarAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://myfancycar")!
    }
    
    var path: String {
        switch self {
        case .carService:
            return "/cars"
        case .availabilityService(_):
            return "/availability"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .carService:
            return .requestPlain
        case .availabilityService(let carId):
            var params: [String: Any] = [:]
            params["id"] = carId
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    var validate: Bool {
        return false
    }
    
    var headers: [String: String]? {
        return nil
    }
}
