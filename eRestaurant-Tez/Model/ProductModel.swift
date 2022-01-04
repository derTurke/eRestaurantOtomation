//
//  ProductModel.swift
//  eRestaurant-Tez
//
//  Created by GÜRHAN YUVARLAK on 30.12.2021.
//

import SwiftUI

struct ProductModel: Identifiable, Hashable {
    var id = UUID().uuidString
    var title : String
    var subtitle : String
    var description : String = ""
    var price : String
    var productImage : String = ""
    var quantity: Int = 1
}

