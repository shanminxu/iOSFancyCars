//
//  CarModel.swift
//  WalmartTest
//
//  Created by Shanmin on 2018-12-12.
//  Copyright © 2018 Heavenbrook. All rights reserved.
//

import Foundation
import ObjectMapper

enum CarStatus: String {
    case inDealership = "In Dealership"
    case unavailable = "Unavailable"
    case outOfStock = "Out of Stock"
}

struct CarModel: Mappable {
    var id: Int!
    var img: String?
    var name: String = ""
    var make: String?
    var model: String?
    var year: String?
    var available: CarStatus = .inDealership
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        img <- map["img"]
        name <- map["name"]
        make <- map["make"]
        model <- map["model"]
        year <- map["year"]
        var availableString: String = ""
        availableString <- map["available"]
        available = CarStatus(rawValue: availableString) ?? .unavailable
    }
}
