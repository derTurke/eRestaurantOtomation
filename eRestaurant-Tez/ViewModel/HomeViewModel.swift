//
//  HomeViewModel.swift
//  eRestaurant-Tez
//
//  Created by GÜRHAN YUVARLAK on 30.12.2021.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var products : [HomeProductModel] = []
    func getHomeProducts(){
        Webservice().getHomeProducts{ result in
            switch result{
                case .success(let products):
                    DispatchQueue.main.async {
                        self.products = products
                    }
                case .failure(let hata):
                    print(hata)
            }
        }
    }
}

