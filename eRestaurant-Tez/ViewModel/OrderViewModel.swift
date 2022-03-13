//
//  OrderViewModel.swift
//  eRestaurant-Tez
//
//  Created by GÜRHAN YUVARLAK on 13.03.2022.
//

import SwiftUI

class OrderViewModel: ObservableObject{
    @Published var orders : [OrderModel] = []
    @Published var orderDetailProducts : [OrderDetailProductModel] = []
    func getOrders(){
        Webservice().getOrders { result in
            switch result {
                case .success(let orders):
                    DispatchQueue.main.async {
                        self.orders = orders
                    }
                case .failure(let hata):
                    print(hata)
            }
        }
    }
    func getOrderProducts(order_id: Int){
        Webservice().getOrderProducts(order_id: order_id) { result in
            switch result {
                case .success(let orderDetailProducts):
                    DispatchQueue.main.async {
                        self.orderDetailProducts = orderDetailProducts
                        print(orderDetailProducts)
                    }
                case .failure(let hata):
                    print(hata)
            }
        }
    }
}
