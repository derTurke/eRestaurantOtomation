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
    
    //getOrderDetail
    @Published var user_name : String = ""
    @Published var header : String = ""
    @Published var address : String = ""
    @Published var building_no : String = ""
    @Published var floor : String = ""
    @Published var apartment_no : String = ""
    @Published var specification : String = ""
    @Published var phone : String = ""
    @Published var total : Double = 0.0
    @Published var note : String = ""
    @Published var table_name : Int = 0
    @Published var created_at : String = ""
    
    
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
    func getOrderDetail(order_id: Int){
        Webservice().getOrderDetail(order_id: order_id) { result in
            switch result{
                case .success(let orderDetail):
                    DispatchQueue.main.async {
                        if(orderDetail.table_name == nil){
                            self.user_name = orderDetail.user_name ?? ""
                            self.header = orderDetail.header ?? ""
                            self.address = orderDetail.address ?? ""
                            self.building_no = orderDetail.building_no ?? ""
                            self.floor = orderDetail.floor ?? ""
                            self.apartment_no = orderDetail.apartment_no ?? ""
                            self.specification = orderDetail.specification ?? ""
                            self.phone = orderDetail.phone ?? ""
                        } else {
                            self.table_name = orderDetail.table_name ?? 0
                            
                        }
                        self.total = orderDetail.total ?? 0.0
                        self.note = orderDetail.note ?? ""
                        self.created_at = orderDetail.created_at ?? ""
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
                    }
                case .failure(let hata):
                    print(hata)
            }
        }
    }
}
