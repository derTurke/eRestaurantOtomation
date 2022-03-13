//
//  BasketModel.swift
//  eRestaurant-Tez
//
//  Created by GÜRHAN YUVARLAK on 6.03.2022.
//
import SwiftUI

struct BasketModel: Codable {
    var id : Int
    var product_id : Int
    var image : String
    var name : String
    var price : Double
    var amount : Double
    var total : Double
}
