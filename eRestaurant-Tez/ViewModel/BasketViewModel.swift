//
//  BasketViewModel.swift
//  eRestaurant-Tez
//
//  Created by GÜRHAN YUVARLAK on 12.03.2022.
//

import SwiftUI
class BasketViewModel: ObservableObject {
    @Published var isExpanded : Bool = false
    @Published var isConfirm : Bool = false;
    @Published var showSheet : Bool = false
    @Published var showAlert : Bool = false
    @Published var message : String = ""
    
    @Published var selectedTableId : Int = 0
    @Published var selectedAddressId : Int = 0
    @Published var selectedAddress : String = ""
    @Published var selectedTable : String = ""
    @Published var orderText : String = ""
    
    @Published var addresses : [AddressModel] = []
    @Published var basketSummary : [BasketModel] = []
    @Published var basketTotal : Double = 0.0
    @Published var tables : [TableModel] = []
    
    
    @Published var isActiveLink : Bool = false
    
    func getBasketSummary(){
        Webservice().getBasketSummary { result in
            switch result {
                case .success(let basketSummary):
                    DispatchQueue.main.async {
                        self.basketTotal = basketSummary
                    }
                case .failure(let hata):
                    print(hata)
            }
        }
    }
    
    func getAddresses(){
        Webservice().getAddresses { result in
            switch result {
                case .success(let addresses):
                    DispatchQueue.main.async {
                        self.addresses = addresses
                    }
                case .failure(let hata):
                    print(hata)
            }
        }
    }
    func getTables(){
        Webservice().getTables { result in
            switch result {
                case .success(let tables):
                    DispatchQueue.main.async {
                        self.tables = tables
                    }
                case .failure(let hata):
                    print(hata)
            }
        }
    }
    
    func addOrder(){
        Webservice().addOrder(address_id: "\(selectedAddressId)", table_id: "\(selectedTableId)", total: "\(basketTotal)", note: orderText, tableConfirm: isConfirm) { result in
            switch result {
                case .success(let order):
                    DispatchQueue.main.async {
                        withAnimation{
                            if order == "success"{
                                self.showAlert = true
                                self.message = "Siparişiniz alınmıştır."
                            } else {
                                self.showAlert = true
                                self.message = order
                            }
                        }
                    }
                
                case .failure(let hata):
                    print(hata)
            }
        }
    }
    
}
