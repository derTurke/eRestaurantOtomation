//
//  ProductModel.swift
//  eRestaurant-Tez
//
//  Created by GÜRHAN YUVARLAK on 30.12.2021.
//

import SwiftUI

struct ProductModel: Codable {
    var id : Int
    var category_id : Int
    var name : String
    var image : String
    var detail : String?
    var price : Double
    var contents: String?
}

