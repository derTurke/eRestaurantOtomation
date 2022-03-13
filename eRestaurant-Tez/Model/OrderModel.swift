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

struct OrderDetailModel : Codable {
    var id : Int
    var user_name : String?
    var header : String?
    var address : String?
    var building_no : String?
    var floor : String?
    var apartment_no : String?
    var specification : String?
    var phone : String?
    var total : Double?
    var note : String?
    var table_name : Int?
    var created_at : String?
}

struct OrderDetailProductModel: Codable {
    var id : Int
    var image : String
    var name : String
    var price : Double
    var amount : Double
    var total : Double
}
