//
//  MainViewModel.swift
//  eRestaurant-Tez
//
//  Created by GÜRHAN YUVARLAK on 29.12.2021.
//

import SwiftUI

class MainViewModel: ObservableObject {
    @Published var currentTab : Tab = .Home
}

enum Tab: String{
    case Home = "home"
    case Basket = "basket"
    case Order = "order"
    case ClipBoard = "clipboard"
    case Person = "person"
}
