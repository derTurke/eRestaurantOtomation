//
//  AuthViewModel.swift
//  eRestaurant-Tez
//
//  Created by GÜRHAN YUVARLAK on 29.12.2021.
//

import Foundation
import SwiftUI

class AuthViewModel : ObservableObject {
    
    // Login Properties
    @Published var email : String = ""
    @Published var password : String = ""
    @Published var showPassword : Bool = false
    
    // Register Properties
    @Published var name : String = ""
    @Published var rePassword : String = ""
    @Published var showRePassword : Bool = false
    @AppStorage("logStatus") var logStatus: Bool = false
    
    @Published var message : String = ""
    @Published var showAlert : Bool = false
    
    
    
    
    func Login(){
        Webservice().login(email: email, password: password) { result in
            switch result{
                case .success(let auth):
                    if auth.token != nil{
                        DispatchQueue.main.async {
                            withAnimation{
                                self.logStatus = true
                            }
                            UserDefaults.standard.setValue(auth.token, forKey: "token")
                        }
                    } else {
                        DispatchQueue.main.async {
                            withAnimation{
                                self.showAlert = true
                                self.message = auth.message
                            }
                        }
                    }
                case .failure(let hata):
                    print(hata)
            }
        }
    }
    
    func Register(){
        Webservice().register(name: name, email: email, password: password) { result in
            switch result{
                case .success(let auth):
                    if auth.token != nil{
                        DispatchQueue.main.async {
                            withAnimation{
                                self.logStatus = true
                            }
                            UserDefaults.standard.setValue(auth.token, forKey: "token")
                        }
                    } else {
                        DispatchQueue.main.async {
                            withAnimation{
                                self.showAlert = true
                                self.message = auth.message
                            }
                        }
                    }
                case .failure(let hata):
                    print(hata)
            }
        }
    }
    
    func ForgotPassword(){
        
    }
    func Logout(){
        Webservice().logout { result in
            switch result{
                case .success(let auth):
                    DispatchQueue.main.async {
                        withAnimation {
                            self.message = auth.message
                            self.showAlert = true
                            UserDefaults.standard.removeObject(forKey: "token")
                            self.logStatus = false
                            
                        }
                    }
                case .failure(let hata):
                    print(hata)
            }
        }
    }
    
}
