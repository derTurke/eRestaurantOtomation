//
//  CategoryViewModel.swift
//  eRestaurant-Tez
//
//  Created by GÜRHAN YUVARLAK on 7.01.2022.
//

import SwiftUI

class CategoryViewModel: ObservableObject {
    @Published var categories : [CategoryModel] = []
    
    @Published var products : [ProductModel] = []
    
    
    @Published var categorySheet: Bool = false
    @Published var categoryName : String = ""
    
    //Product
    @Published var productSheet : Bool = false
    @Published var productId : Int = 0
    @Published var product_id : Int = 0
    @Published var product_category_id : Int = 0
    @Published var product_name : String = ""
    @Published var product_image : String = "images/products/JgviN1ZF9bkNx3dsTzDDHyhGqEvSzqcfM5SLbWyt.webp"
    @Published var product_detail : String = ""
    @Published var product_price : Double = 0.0
    @Published var product_contents : String = ""
    
    
    //Add Basket
    
    @Published var piece : Int = 1
    @Published var sumPrice : Double = 1.0
    
    //Get Basket
    @Published var basket : [BasketModel] = []
    @Published var basketProductId : Int = 0
    //Order Submit
    
    
    //Alert And Message
    @Published var showAlert : Bool = false
    @Published var message : String = ""
    
    
    func GetCategory(){
        Webservice().getCategories { result in
            switch result{
                case .success(let categories):
                    DispatchQueue.main.async {
                        self.categories = categories
                    }
                case .failure(let hata):
                    print(hata)
            }
        }
    }
    func GetProducts(categoryId: Int){
        Webservice().getProducts(categoryId: categoryId) { result in
            switch result {
                case .success(let products):
                    DispatchQueue.main.async {
                        self.products = products
                    }
                case .failure(let hata):
                    print(hata)
            }
        }
    }
    func getProduct(product_id: Int){
        Webservice().getProduct(productId: product_id) { result in
            switch result {
                case .success(let product):
                    DispatchQueue.main.async {
                        self.product_id = product[0].id
                        self.product_category_id = product[0].category_id
                        self.product_name = product[0].name
                        self.product_image = product[0].image
                        self.product_detail = product[0].detail ?? ""
                        self.product_price = product[0].price
                        self.sumPrice = product[0].price
                        self.product_contents = product[0].contents ?? ""
                    }
                case .failure(let hata):
                    print(hata)
            }
        }
    }
    
    func addBasket(product_id: Int){
        let product_id = Double(product_id)
        let piece = Double(self.piece)
        Webservice().addBasket(product_id: product_id, price: product_price, piece: piece, total: sumPrice) { result in
            switch result{
            case .success(let basket):
                DispatchQueue.main.async {
                    withAnimation{
                        if basket == "success"{
                            self.showAlert = true
                            self.message = "Ürün sepetinize eklendi."
                        } else {
                            self.showAlert = true
                            self.message = basket
                        }
                    }
                }
            
            case .failure(let hata):
                print(hata)
            }
        }
    }
    
    func getBasket(){
        Webservice().getBasket { result in
            switch result {
                case .success(let basket):
                    DispatchQueue.main.async {
                        self.basket = basket
                    }
                case .failure(let hata):
                    print(hata)
            }
        }
    }
    
    func deleteBasket(basket_product_id: Int){
        Webservice().deleteBasket(id: basket_product_id) { result in
            switch result {
                case .success(let basket):
                    DispatchQueue.main.async {
                        self.basket = basket
                    }
                case .failure(let hata):
                    print(hata)
            }
        }
    }
    
    
    
}
