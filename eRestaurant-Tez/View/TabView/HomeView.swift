//
//  HomeView.swift
//  eRestaurant-Tez
//
//  Created by GÜRHAN YUVARLAK on 29.12.2021.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeVM : HomeViewModel = HomeViewModel()
    var body: some View {
        ScrollView(.vertical,showsIndicators: false){
            VStack{
                Text("Anasayfa")
                    .font(.custom(customFont, size: 30))
                    .foregroundColor(Color.black)
            }
            .padding(40)
        }
        .frame(maxWidth:.infinity,maxHeight: .infinity)
        .background(Color.white)
        .ignoresSafeArea()
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
