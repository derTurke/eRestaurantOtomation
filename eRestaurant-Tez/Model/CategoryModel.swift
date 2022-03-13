//
//  CategoryModel.swift
//  eRestaurant-Tez
//
//  Created by GÜRHAN YUVARLAK on 7.01.2022.
//

import SwiftUI

struct CategoryModel: Codable {
    let id : Int
    let parent_id : Int
    let name : String
    let image : String
}


