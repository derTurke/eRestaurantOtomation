//
//  Webservice.swift
//  eRestaurant-Tez
//
//  Created by GÜRHAN YUVARLAK on 31.12.2021.
//

import Foundation
class Webservice {
    
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
    
    
    func logout(completion: @escaping (Result<AuthModel,DownloaderError>) -> Void){
        guard let url = URL(string: "http://127.0.0.1:8000/api/logout") else {
            completion(.failure(.yanlisUrl))
            return
        }
        let token = UserDefaults.standard.value(forKey: "token")
        let token_accept = "Bearer \(token!)"
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
        let token_accept = "Bearer \(token!)"
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
        let token_accept = "Bearer \(token!)"
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
        let token_accept = "Bearer \(token!)"
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
        let token_accept = "Bearer \(token!)"
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
        let token_accept = "Bearer \(token!)"
        
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
        let token_accept = "Bearer \(token!)"
        
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
        let token_accept = "Bearer \(token!)"
        
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
        let token_accept = "Bearer \(token!)"
        
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
        let token_accept = "Bearer \(token!)"
        
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
        let token_accept = "Bearer \(token!)"
        
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
        let token_accept = "Bearer \(token!)"
        
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
        let token_accept = "Bearer \(token!)"
        
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
