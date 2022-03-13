//
//  CategoryDetail.swift
//  eRestaurant-Tez
//
//  Created by GÜRHAN YUVARLAK on 12.01.2022.
//

import SwiftUI

struct CategoryDetail: View {
    @Environment(\.presentationMode) var presentationMode
    var categoryId : Int
    var categoryName : String
    var categoryImage : String
    @StateObject var categoryVM : CategoryViewModel = CategoryViewModel()
   
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Button{
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color.white)
                }
                Text(categoryName)
                    .font(.custom(customFont, size: 16))
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white)
                    .frame(maxWidth:.infinity,alignment: .leading)
                
            }
            .padding()
            .background(
                Color("Primary")
                    .ignoresSafeArea()
            )
            CategoryImage(url: categoryImage)                
                .frame(height: UIScreen.main.bounds.height / 5)
                .background(Color.white)
            ScrollView(.vertical,showsIndicators: false){
                Divider().background(Color("Secondary"))
                ForEach(categoryVM.products, id: \.id){ product in
                    ProductCard(product: product)
                }
            }
            .offset(y:-10)
            .padding(.bottom,70)
            .font(.custom(customFont, size: 16))
            .foregroundColor(Color.black)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white.ignoresSafeArea())
        .onAppear{
            DispatchQueue.main.async {
                categoryVM.GetProducts(categoryId: categoryId)
            }
        }
    }
    @ViewBuilder
    func ProductCard(product: ProductModel)-> some View{
        HStack{
            CategoryImage(url: product.image)
                .frame(width: 75, height: 75)
            VStack(alignment: .leading){
                Text(product.name)
                Text(String(format: "%.02f ₺", product.price))
            }
            Spacer()
            Button {
                categoryVM.productId = product.id
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
        .padding(.horizontal)
        Divider().background(Color("Secondary"))
    }
}

struct CategoryDetail_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
