//
//  ImageWebservice.swift
//  eRestaurant-Tez
//
//  Created by GÜRHAN YUVARLAK on 7.01.2022.
//

import SwiftUI

class ImageWebservice : ObservableObject{
    @Published var indirilenGorsel : Data?
    
    func gorselIndir(url: String){
        guard let imageURL = URL(string: "http://127.0.0.1:8000/storage/"+url) else {
            return
        }
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            guard let data = data , error == nil else {
                return
            }
            DispatchQueue.main.async {
                self.indirilenGorsel = data
            }
            
            

        }.resume()
    }
}
