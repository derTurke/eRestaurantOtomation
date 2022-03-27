//
//  Webservice.swift
//  eRestaurant-Tez
//
//  Created by GÜRHAN YUVARLAK on 31.12.2021.
//

import Foundation
class Webservice {
    //Category Model
    func getCategories(completion: @escaping (Result<[CategoryModel],DownloaderError>) -> Void){
        guard let url = URL(string: "http://127.0.0.1:8000/api/getCategories") else {
            completion(.failure(.yanlisUrl))
            return
        }
        let token = UserDefaults.standard.value(forKey: "token")
        var token_accept = "Bearer"
        if token != nil{
            token_accept = "Bearer \(token!)"
            
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token_accept, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.veriGelmedi))
                return
            }
            guard let categoriesResponse = try? JSONDecoder().decode([CategoryModel].self, from: data) else {
                completion(.failure(.veriIslenemedi))
                return
            }
            completion(.success(categoriesResponse))
            
        }.resume()
    }
    
    func getProducts(categoryId: Int, completion: @escaping (Result<[ProductModel],DownloaderError>) -> Void){
        guard let url = URL(string: "http://127.0.0.1:8000/api/getProducts") else {
            completion(.failure(.yanlisUrl))
            return
        }
        let token = UserDefaults.standard.value(forKey: "token")
        var token_accept = "Bearer"
        if token != nil{
            token_accept = "Bearer \(token!)"
        }
        let body : [String : Int] = ["category_id": categoryId]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token_accept, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.veriGelmedi))
                return
            }
            guard let productsResponse = try? JSONDecoder().decode([ProductModel].self, from: data) else {
                completion(.failure(.veriIslenemedi))
                return
            }
            completion(.success(productsResponse))
            
        }.resume()
    }
    
    func getProduct(productId: Int, completion: @escaping (Result<[ProductModel],DownloaderError>) -> Void){
        guard let url = URL(string: "http://127.0.0.1:8000/api/getProduct") else {
            completion(.failure(.yanlisUrl))
            return
        }
        let token = UserDefaults.standard.value(forKey: "token")
        var token_accept = "Bearer"
        if token != nil{
            token_accept = "Bearer \(token!)"
        }
        let body : [String : Int] = ["product_id": productId]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token_accept, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.veriGelmedi))
                return
            }
            guard let productsResponse = try? JSONDecoder().decode([ProductModel].self, from: data) else {
                completion(.failure(.veriIslenemedi))
                return
            }
            completion(.success(productsResponse))
            
        }.resume()
    }
    
    func addBasket(product_id: Double, price: Double, piece: Double, total: Double,completion: @escaping (Result<String,DownloaderError>) -> Void){
        guard let url = URL(string: "http://127.0.0.1:8000/api/addBasket") else {
            completion(.failure(.yanlisUrl))
            return
        }
        
        let body : [String : Double] = ["product_id": product_id, "price": price, "piece": piece, "total": total]
        
        
        let token = UserDefaults.standard.value(forKey: "token")
        var token_accept = "Bearer"
        if token != nil{
            token_accept = "Bearer \(token!)"
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token_accept, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONEncoder().encode(body)
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.veriGelmedi))
                return
            }
            guard let addBasket = try? JSONDecoder().decode(String.self, from: data) else {
                completion(.failure(.veriIslenemedi))
                return
            }
            completion(.success(addBasket))
            
        }.resume()
        
    }
    func getBasket(completion: @escaping (Result<[BasketModel],DownloaderError>) -> Void){
        guard let url = URL(string: "http://127.0.0.1:8000/api/getBasket") else {
            completion(.failure(.yanlisUrl))
            return
        }
        let token = UserDefaults.standard.value(forKey: "token")
        var token_accept = "Bearer"
        if token != nil{
            token_accept = "Bearer \(token!)"
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token_accept, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.veriGelmedi))
                return
            }
            guard let basketResponse = try? JSONDecoder().decode([BasketModel].self, from: data) else {
                completion(.failure(.veriIslenemedi))
                return
            }
            completion(.success(basketResponse))
            
        }.resume()
        
    }
    func getBasketSummary(completion: @escaping (Result<Double,DownloaderError>) -> Void){
        guard let url = URL(string: "http://127.0.0.1:8000/api/getBasketSummary") else {
            completion(.failure(.yanlisUrl))
            return
        }
        let token = UserDefaults.standard.value(forKey: "token")
        var token_accept = "Bearer"
        if token != nil{
            token_accept = "Bearer \(token!)"
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token_accept, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.veriGelmedi))
                return
            }
            guard let basketResponse = try? JSONDecoder().decode(Double.self, from: data) else {
                completion(.failure(.veriIslenemedi))
                return
            }
            completion(.success(basketResponse))
            
        }.resume()
        
    }
    func getTables(completion: @escaping (Result<[TableModel],DownloaderError>) -> Void){
        guard let url = URL(string: "http://127.0.0.1:8000/api/getTables") else {
            completion(.failure(.yanlisUrl))
            return
        }
        let token = UserDefaults.standard.value(forKey: "token")
        var token_accept = "Bearer"
        if token != nil{
            token_accept = "Bearer \(token!)"
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token_accept, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.veriGelmedi))
                return
            }
            guard let tableResponse = try? JSONDecoder().decode([TableModel].self, from: data) else {
                completion(.failure(.veriIslenemedi))
                return
            }
            completion(.success(tableResponse))
            
        }.resume()
        
    }
    
    func addOrder(address_id: String, table_id: String, total: String, note: String, tableConfirm: Bool, completion: @escaping (Result<String,DownloaderError>) -> Void){
        guard let url = URL(string: "http://127.0.0.1:8000/api/addOrder") else {
            completion(.failure(.yanlisUrl))
            return
        }
        
        var body : [String: String]
        
        if (tableConfirm){
           body = ["table_id": table_id, "total": total, "note": note]
        } else {
           body = ["address_id": address_id,"total": total, "note": note]
        }
        
        let token = UserDefaults.standard.value(forKey: "token")
        var token_accept = "Bearer"
        if token != nil{
            token_accept = "Bearer \(token!)"
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token_accept, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONEncoder().encode(body);
        
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.veriGelmedi))
                return
            }
            guard let addBasket = try? JSONDecoder().decode(String.self, from: data) else {
                completion(.failure(.veriIslenemedi))
                return
            }
            completion(.success(addBasket))
            
        }.resume()
        
    }
    

    func deleteBasket(id: Int, completion: @escaping (Result<[BasketModel],DownloaderError>) -> Void){
        guard let url = URL(string: "http://127.0.0.1:8000/api/deleteBasket") else {
            completion(.failure(.yanlisUrl))
            return
        }
        let token = UserDefaults.standard.value(forKey: "token")
        var token_accept = "Bearer"
        if token != nil{
            token_accept = "Bearer \(token!)"
        }
        
        let body : [String : Int] = ["id": id]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token_accept, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.veriGelmedi))
                return
            }
            guard let basketResponse = try? JSONDecoder().decode([BasketModel].self, from: data) else {
                completion(.failure(.veriIslenemedi))
                return
            }
            completion(.success(basketResponse))
            
        }.resume()
        
    }
    
    
    //Order Model
    func getOrders(completion: @escaping (Result<[OrderModel],DownloaderError>) -> Void){
        guard let url = URL(string: "http://127.0.0.1:8000/api/getOrders") else {
            completion(.failure(.yanlisUrl))
            return
        }
        let token = UserDefaults.standard.value(forKey: "token")
        var token_accept = "Bearer"
        if token != nil{
            token_accept = "Bearer \(token!)"
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token_accept, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.veriGelmedi))
                return
            }
            guard let orderResponse = try? JSONDecoder().decode([OrderModel].self, from: data) else {
                completion(.failure(.veriIslenemedi))
                return
            }
            completion(.success(orderResponse))
            
        }.resume()
    }
    
    func getOrderProducts(order_id:Int, completion: @escaping (Result<[OrderDetailProductModel],DownloaderError>) -> Void){
        guard let url = URL(string: "http://127.0.0.1:8000/api/getOrderProductDetail") else {
            completion(.failure(.yanlisUrl))
            return
        }
        let token = UserDefaults.standard.value(forKey: "token")
        var token_accept = "Bearer"
        if token != nil{
            token_accept = "Bearer \(token!)"
        }
        
        let body : [String : Int] = ["order_id": order_id]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token_accept, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.veriGelmedi))
                return
            }
            guard let orderProductResponse = try? JSONDecoder().decode([OrderDetailProductModel].self, from: data) else {
                completion(.failure(.veriIslenemedi))
                return
            }
            completion(.success(orderProductResponse))
            
        }.resume()
    }
    
    func getOrderDetail(order_id:Int, completion: @escaping (Result<OrderDetailModel,DownloaderError>) -> Void){
        guard let url = URL(string: "http://127.0.0.1:8000/api/getOrderDetail") else {
            completion(.failure(.yanlisUrl))
            return
        }
        let token = UserDefaults.standard.value(forKey: "token")
        var token_accept = "Bearer"
        if token != nil{
            token_accept = "Bearer \(token!)"
        }
        
        let body : [String : Int] = ["order_id": order_id]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token_accept, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.veriGelmedi))
                return
            }
            guard let orderDetailResponse = try? JSONDecoder().decode(OrderDetailModel.self, from: data) else {
                completion(.failure(.veriIslenemedi))
                return
            }
            completion(.success(orderDetailResponse))
            
        }.resume()
    }
    
    //Home Model
    
    func getHomeProducts(completion: @escaping (Result<[HomeProductModel],DownloaderError>) -> Void){
        guard let url = URL(string: "http://127.0.0.1:8000/api/getLastOrder") else {
            completion(.failure(.yanlisUrl))
            return
        }
        let token = UserDefaults.standard.value(forKey: "token")
        var token_accept = "Bearer"
        if token != nil{
            token_accept = "Bearer \(token!)"
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token_accept, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.veriGelmedi))
                return
            }
            guard let homeProductsResponse = try? JSONDecoder().decode([HomeProductModel].self, from: data) else {
                completion(.failure(.veriIslenemedi))
                return
            }
            completion(.success(homeProductsResponse))
            
        }.resume()
    }
    
    
    
    
    
    // Auth Model
    func register(name: String, email: String, password: String, completion: @escaping (Result<AuthModel,DownloaderError>) -> Void){
        guard let url = URL(string: "http://127.0.0.1:8000/api/register") else {
            completion(.failure(.yanlisUrl))
            return
        }
        
        let body : [String : String] = ["name": name, "email": email, "password": password]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.veriGelmedi))
                return
            }
            guard let registerResponse = try? JSONDecoder().decode(AuthModel.self, from: data) else {
                completion(.failure(.veriIslenemedi))
                return
            }
            completion(.success(registerResponse))
            
        }.resume()
        
    }
    func login(email: String, password: String, completion: @escaping (Result<AuthModel,DownloaderError>) -> Void){
        guard let url = URL(string: "http://127.0.0.1:8000/api/login") else {
            completion(.failure(.yanlisUrl))
            return
        }
        
        let body : [String : String] = ["email": email, "password": password]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.veriGelmedi))
                return
            }
            guard let loginResponse = try? JSONDecoder().decode(AuthModel.self, from: data) else {
                completion(.failure(.veriIslenemedi))
                return
            }
            completion(.success(loginResponse))
            
        }.resume()
        
    }
    
    func forgotPassword(email: String, completion: @escaping (Result<String,DownloaderError>)->Void){
        guard let url = URL(string: "http://127.0.0.1:8000/api/forgotPassword") else {
            completion(.failure(.yanlisUrl))
            return
        }
        let body : [String : String] = ["email": email]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.veriGelmedi))
                return
            }
            guard let forgotPasswordResponse = try? JSONDecoder().decode(String.self, from: data) else {
                completion(.failure(.veriIslenemedi))
                return
            }
            completion(.success(forgotPasswordResponse))
            
        }.resume()
    }
    
    func forgotPassword2(email: String, password: String, password_again: String, completion: @escaping (Result<AuthModel,DownloaderError>) -> Void){
        guard let url = URL(string: "http://127.0.0.1:8000/api/forgotPassword2") else {
            completion(.failure(.yanlisUrl))
            return
        }
        
        let body : [String : String] = ["email": email, "password": password, "password_again": password_again]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.veriGelmedi))
                return
            }
            guard let loginResponse = try? JSONDecoder().decode(AuthModel.self, from: data) else {
                completion(.failure(.veriIslenemedi))
                return
            }
            completion(.success(loginResponse))
            
        }.resume()
        
    }
    
    
    func logout(completion: @escaping (Result<AuthModel,DownloaderError>) -> Void){
        guard let url = URL(string: "http://127.0.0.1:8000/api/logout") else {
            completion(.failure(.yanlisUrl))
            return
        }
        let token = UserDefaults.standard.value(forKey: "token")
        var token_accept = "Bearer"
        if token != nil{
            token_accept = "Bearer \(token!)"
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token_accept, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.veriGelmedi))
                return
            }
            guard let loginResponse = try? JSONDecoder().decode(AuthModel.self, from: data) else {
                completion(.failure(.veriIslenemedi))
                return
            }
            completion(.success(loginResponse))
            
        }.resume()
        
    }
    func personelInformation(completion: @escaping (Result<PersonelModel,DownloaderError>) -> Void){
        guard let url = URL(string: "http://127.0.0.1:8000/api/personelInformation") else {
            completion(.failure(.yanlisUrl))
            return
        }
        let token = UserDefaults.standard.value(forKey: "token")
        var token_accept = "Bearer"
        if token != nil{
            token_accept = "Bearer \(token!)"
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token_accept, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.veriGelmedi))
                return
            }
            guard let personelInformationResponse = try? JSONDecoder().decode(PersonelModel.self, from: data) else {
                completion(.failure(.veriIslenemedi))
                return
            }
            completion(.success(personelInformationResponse))
            
        }.resume()
        
    }
    func updatePersonelInformation(name: String, email: String, birthdate: Date, sex: String ,completion: @escaping (Result<String,DownloaderError>) -> Void){
        guard let url = URL(string: "http://127.0.0.1:8000/api/updatePersonelInformation") else {
            completion(.failure(.yanlisUrl))
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY-MM-dd"
        let bdate = dateFormatter.string(from: birthdate)
        
        let body : [String : String] = ["name": name, "email": email, "birthdate": bdate, "sex": sex]
        
        
        let token = UserDefaults.standard.value(forKey: "token")
        var token_accept = "Bearer"
        if token != nil{
            token_accept = "Bearer \(token!)"
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token_accept, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONEncoder().encode(body)
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.veriGelmedi))
                return
            }
            guard let updatePersonelInformationResponse = try? JSONDecoder().decode(String.self, from: data) else {
                completion(.failure(.veriIslenemedi))
                return
            }
            completion(.success(updatePersonelInformationResponse))
            
        }.resume()
        
    }
    
    func addAddress(header: String, address: String, building_no: String, floor: String, apartment_no: String, specification: String, phone: String, completion: @escaping (Result<String,DownloaderError>) -> Void){
        guard let url = URL(string: "http://127.0.0.1:8000/api/addAddress") else {
            completion(.failure(.yanlisUrl))
            return
        }
        
        let body : [String : String] = ["header": header, "address": address, "building_no": building_no, "floor": floor, "apartment_no": apartment_no, "specification": specification, "phone": phone]
        
        
        let token = UserDefaults.standard.value(forKey: "token")
        var token_accept = "Bearer"
        if token != nil{
            token_accept = "Bearer \(token!)"
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token_accept, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONEncoder().encode(body)
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.veriGelmedi))
                return
            }
            guard let updatePersonelInformationResponse = try? JSONDecoder().decode(String.self, from: data) else {
                completion(.failure(.veriIslenemedi))
                return
            }
            completion(.success(updatePersonelInformationResponse))
            
        }.resume()
        
    }
    func getAddresses(completion: @escaping (Result<[AddressModel],DownloaderError>) -> Void){
        guard let url = URL(string: "http://127.0.0.1:8000/api/getAddress") else {
            completion(.failure(.yanlisUrl))
            return
        }
        let token = UserDefaults.standard.value(forKey: "token")
        var token_accept = "Bearer"
        if token != nil{
            token_accept = "Bearer \(token!)"
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token_accept, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.veriGelmedi))
                return
            }
            guard let addressResponse = try? JSONDecoder().decode([AddressModel].self, from: data) else {
                completion(.failure(.veriIslenemedi))
                return
            }
            completion(.success(addressResponse))
            
        }.resume()
        
    }
    func getAddress(id: Int, completion: @escaping (Result<AddressModel,DownloaderError>) -> Void){
        guard let url = URL(string: "http://127.0.0.1:8000/api/getSingleAddress") else {
            completion(.failure(.yanlisUrl))
            return
        }
        let token = UserDefaults.standard.value(forKey: "token")
        var token_accept = "Bearer"
        if token != nil{
            token_accept = "Bearer \(token!)"
        }
        
        let body : [String : Int] = ["id": id]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token_accept, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.veriGelmedi))
                return
            }
            guard let addressResponse = try? JSONDecoder().decode(AddressModel.self, from: data) else {
                completion(.failure(.veriIslenemedi))
                return
            }
            completion(.success(addressResponse))
            
        }.resume()
        
    }
    func deleteAddress(id: Int, completion: @escaping (Result<[AddressModel],DownloaderError>) -> Void){
        guard let url = URL(string: "http://127.0.0.1:8000/api/deleteAddress") else {
            completion(.failure(.yanlisUrl))
            return
        }
        let token = UserDefaults.standard.value(forKey: "token")
        var token_accept = "Bearer"
        if token != nil{
            token_accept = "Bearer \(token!)"
        }
        
        let body : [String : Int] = ["id": id]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token_accept, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.veriGelmedi))
                return
            }
            guard let addressResponse = try? JSONDecoder().decode([AddressModel].self, from: data) else {
                completion(.failure(.veriIslenemedi))
                return
            }
            completion(.success(addressResponse))
            
        }.resume()
        
    }
    
    func editAddress(id: Int, header: String, address: String, building_no: String, floor: String, apartment_no: String, specification: String, phone: String, completion: @escaping (Result<String,DownloaderError>) -> Void){
        guard let url = URL(string: "http://127.0.0.1:8000/api/editAddress") else {
            completion(.failure(.yanlisUrl))
            return
        }
        let token = UserDefaults.standard.value(forKey: "token")
        var token_accept = "Bearer"
        if token != nil{
            token_accept = "Bearer \(token!)"
        }
        
        let body : [String : String] = ["id" : "\(id)","header": header, "address": address, "building_no": building_no, "floor": floor, "apartment_no": apartment_no, "specification": specification, "phone": phone]
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token_accept, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.veriGelmedi))
                return
            }
            guard let addressResponse = try? JSONDecoder().decode(String.self, from: data) else {
                completion(.failure(.veriIslenemedi))
                return
            }
            completion(.success(addressResponse))
        }.resume()
        
    }
    func editPassword(password: String, newPassword: String, reNewPassword: String, completion: @escaping (Result<String,DownloaderError>) -> Void){
        guard let url = URL(string: "http://127.0.0.1:8000/api/editPassword") else {
            completion(.failure(.yanlisUrl))
            return
        }
        let token = UserDefaults.standard.value(forKey: "token")
        var token_accept = "Bearer"
        if token != nil{
            token_accept = "Bearer \(token!)"
        }
        
        let body : [String : String] = ["password" : password, "newPassword" : newPassword, "reNewPassword" : reNewPassword]
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token_accept, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.veriGelmedi))
                return
            }
            guard let addressResponse = try? JSONDecoder().decode(String.self, from: data) else {
                completion(.failure(.veriIslenemedi))
                return
            }
            completion(.success(addressResponse))
        }.resume()
        
    }
    func getFAQ(completion: @escaping (Result<[FaqModel],DownloaderError>) -> Void){
        guard let url = URL(string: "http://127.0.0.1:8000/api/faq") else {
            completion(.failure(.yanlisUrl))
            return
        }
        let token = UserDefaults.standard.value(forKey: "token")
        var token_accept = "Bearer"
        if token != nil{
            token_accept = "Bearer \(token!)"
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token_accept, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.veriGelmedi))
                return
            }
            guard let faqResponse = try? JSONDecoder().decode([FaqModel].self, from: data) else {
                completion(.failure(.veriIslenemedi))
                return
            }
            completion(.success(faqResponse))
        }.resume()
        
    }
    
    func getPrivacyInformation(completion: @escaping (Result<String,DownloaderError>) -> Void){
        guard let url = URL(string: "http://127.0.0.1:8000/api/privacyInformation") else {
            completion(.failure(.yanlisUrl))
            return
        }
        let token = UserDefaults.standard.value(forKey: "token")
        var token_accept = "Bearer"
        if token != nil{
            token_accept = "Bearer \(token!)"
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token_accept, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.veriGelmedi))
                return
            }
            guard let privacyInformationResponse = try? JSONDecoder().decode(String.self, from: data) else {
                completion(.failure(.veriIslenemedi))
                return
            }
            completion(.success(privacyInformationResponse))
        }.resume()
        
    }
    
    func getAboutUs(completion: @escaping (Result<AboutUsModel,DownloaderError>) -> Void){
        guard let url = URL(string: "http://127.0.0.1:8000/api/aboutUs") else {
            completion(.failure(.yanlisUrl))
            return
        }
        let token = UserDefaults.standard.value(forKey: "token")
        var token_accept = "Bearer"
        if token != nil{
            token_accept = "Bearer \(token!)"
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token_accept, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.veriGelmedi))
                return
            }
            guard let aboutUsResponse = try? JSONDecoder().decode(AboutUsModel.self, from: data) else {
                completion(.failure(.veriIslenemedi))
                return
            }
            completion(.success(aboutUsResponse))
        }.resume()
        
    }
    func helpDeskInformation(subject: String, message: String,completion: @escaping (Result<String,DownloaderError>) -> Void){
        guard let url = URL(string: "http://127.0.0.1:8000/api/helpDesk") else {
            completion(.failure(.yanlisUrl))
            return
        }
        let token = UserDefaults.standard.value(forKey: "token")
        var token_accept = "Bearer"
        if token != nil{
            token_accept = "Bearer \(token!)"
        }
        
        let body : [String : String] = ["subject" : subject, "message" : message]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token_accept, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.veriGelmedi))
                return
            }
            guard let helpDeskResponse = try? JSONDecoder().decode(String.self, from: data) else {
                completion(.failure(.veriIslenemedi))
                return
            }
            completion(.success(helpDeskResponse))
        }.resume()
        
    }
    
    
    
}

enum DownloaderError : Error{
    case yanlisUrl
    case veriGelmedi
    case veriIslenemedi
}
