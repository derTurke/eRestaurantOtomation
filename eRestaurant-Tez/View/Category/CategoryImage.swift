//
//  CategoryImage.swift
//  eRestaurant-Tez
//
//  Created by GÜRHAN YUVARLAK on 7.01.2022.
//

import SwiftUI

struct CategoryImage: View {
    let url: String
    @ObservedObject var imageWS = ImageWebservice()
    init(url : String){
        self.url = url
        self.imageWS.gorselIndir(url: self.url)
    }
    var body: some View {
        if let data = self.imageWS.indirilenGorsel{
            return Image(uiImage: UIImage(data: data)!)
                .resizable()
        } else {
            return Image(systemName: "photo")
                .resizable()
        }
    }
}

