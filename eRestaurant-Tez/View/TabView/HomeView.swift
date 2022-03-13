//
//  HomeView.swift
//  eRestaurant-Tez
//
//  Created by GÜRHAN YUVARLAK on 29.12.2021.
//

import SwiftUI

struct HomeView: View {
    @State private var productSheet : Bool = false
    @StateObject var homeVM : HomeViewModel = HomeViewModel()
    @StateObject var categoryVM : CategoryViewModel = CategoryViewModel()
    @StateObject var personVM : PersonViewModel = PersonViewModel()
    var body: some View {
        NavigationView{
            VStack{
                VStack(alignment: .leading){
                    Text("Merhaba")
                        .font(.custom(customFont, size: 28).bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color.white)
                    Text("\(personVM.name),")
                        .font(.custom(customFont, size: 28).bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color.white)
                    Text("e-Restaurant'a Hoşgeldin")
                        .font(.custom(customFont, size: 28).bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color.white)
                        
                }
                .padding()
                .padding(.horizontal,20)
                .padding(.vertical,20)
                .frame(height: UIScreen.main.bounds.height * 1/3)
                .background(Color("Primary").ignoresSafeArea())
                VStack{
                    Text("Son Sipariş")
                        .padding(.horizontal)
                        .padding(.horizontal)
                        .font(.custom(customFont, size: 28).bold())
                        .foregroundColor(Color.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                    Text("Verdiğiniz Ürünler")
                        .padding(.horizontal)
                        .padding(.horizontal)
                        .font(.custom(customFont, size: 28).bold())
                        .foregroundColor(Color.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack{
                        ForEach(homeVM.products, id: \.id){product in
                            ProductCard(product: product)
                        }
                    }
                }
                .padding()
                Spacer()
            }
            .padding(.bottom,100)
            .navigationBarHidden(true)
            .background(Color.white.ignoresSafeArea())
            .onAppear{
                DispatchQueue.main.async {
                    homeVM.getHomeProducts()
                    personVM.getPersonelInformation()
                }
            }
        }
        
    }
    @ViewBuilder
    func ProductCard(product:HomeProductModel) -> some View{
        HStack{
            CategoryImage(url: product.image)
                .frame(width: 100, height: 100)
            VStack(alignment: .leading){
                Text(product.name)
                Text(String(format: "%.02f ₺", product.price))
                    
                
            }
            Spacer()
            Button {
                DispatchQueue.main.async {
                    categoryVM.productId = product.id
                }
                categoryVM.productSheet.toggle()
            } label: {
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(Color.white)
            }
            .padding(5)
            .background(Color("Primary"))
            .sheet(isPresented: $categoryVM.productSheet, onDismiss: {}) {
                ProductDetail.init(product_id: categoryVM.productId)
            }
        }
        .frame(width: 305,height: 150)
        .padding()
        .foregroundColor(Color.black)
        .background(
            Color.white
        )
        .font(.custom(customFont, size: 16))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 0)
        .padding(.horizontal)
        .padding(.vertical)
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().previewDevice("iPhone 13 Pro Max")
    }
}
