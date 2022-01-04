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
            VStack(spacing:15){
                Text("Hoşgeldin Gürhan,")
                    .font(.custom(customFont, size: 30))
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: getRect().height/3.5)
                    .padding(.horizontal,25)
                    .background(
                        Color("Primary")
                    )
                Text("En son siparişleriniz")
                    .font(.custom(customFont, size: 23))
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top,30)
                    .padding(.horizontal,25)
                ScrollView(.horizontal,showsIndicators: false){
                    HStack(spacing: 25){
                        ForEach(homeVM.products){ product in
                            ProductCard(product: product)
                        }
                    }
                    .padding(.horizontal,25)
                }
                .padding(.top,30)
            }
            .padding(.vertical)
        }
        .frame(maxWidth:.infinity,maxHeight: .infinity)
        .background(Color("HomeBG"))
        .ignoresSafeArea()
        
    }
    @ViewBuilder
    func ProductCard(product: ProductModel)-> some View{
        VStack(spacing: 10){
            Image(product.productImage)
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color.black)
                .frame(width: getRect().width / 2.5, height: getRect().width / 2.5)
                .offset(y:-80)
                .padding(.bottom,-80)
            Text(product.title)
                .font(.custom(customFont, size: 18))
                .fontWeight(.semibold)
                .padding(.top)
            Text(product.price)
                .font(.custom(customFont, size: 18))
                .fontWeight(.semibold)
                .foregroundColor(Color("Primary"))
        }
        .padding(.horizontal,20)
        .padding(.bottom,22)
        .background(
            Color.white
                .cornerRadius(25)
        )
        .padding(.top,80)
    }
        
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
