//
//  HomeViewModel.swift
//  eRestaurant-Tez
//
//  Created by GÜRHAN YUVARLAK on 30.12.2021.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var products : [ProductModel] = [
        ProductModel(title: "Et", subtitle: "Et", description: "", price: "120₺", productImage: "home", quantity: 1),
        ProductModel(title: "Et", subtitle: "Et", description: "", price: "120₺", productImage: "home", quantity: 1),
        ProductModel(title: "Et", subtitle: "Et", description: "", price: "120₺", productImage: "home", quantity: 1),
        ProductModel(title: "Et", subtitle: "Et", description: "", price: "120₺", productImage: "home", quantity: 1),
        ProductModel(title: "Et", subtitle: "Et", description: "", price: "120₺", productImage: "home", quantity: 1),
    ]
}

