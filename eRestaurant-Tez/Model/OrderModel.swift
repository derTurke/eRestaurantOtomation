//
//  OrderModel.swift
//  eRestaurant-Tez
//
//  Created by GÜRHAN YUVARLAK on 13.03.2022.
//

import SwiftUI

struct OrderModel: Codable {
    var id : Int
    var created_at : String
    var total : Double
}

struct OrderDetailProductModel: Codable {
    var id : Int
    var image : String
    var name : String
    var price : Double
    var amount : Double
    var total : Double
}
