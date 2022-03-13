//
//  ProductDetail.swift
//  eRestaurant-Tez
//
//  Created by GÜRHAN YUVARLAK on 28.01.2022.
//

import SwiftUI

struct ProductDetail: View {
    @Environment(\.presentationMode) var presentationMode
    var product_id : Int
    @StateObject var categoryVM : CategoryViewModel = CategoryViewModel()
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Button{
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image("close")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color.white)
                }
                Spacer()
                Text("Ürün Detayları")
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
            CategoryImage(url: categoryVM.product_image)
                .frame(height: UIScreen.main.bounds.height / 3.5)
                .background(Color.white)
            ScrollView(.vertical, showsIndicators: false) {
                Text(categoryVM.product_name)
                    .font(.custom(customFont, size: 18))
                    .foregroundColor(Color.black)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .center)
                Text(categoryVM.product_contents)
                    .font(.custom(customFont, size: 15))
                    .padding(.horizontal)
                Divider().background(Color("Secondary"))
                HStack{
                    Text("Adet")
                        .font(.custom(customFont, size: 15))
                        .foregroundColor(Color.black)
                    Spacer()
                    HStack{
                        Button{
                            if categoryVM.piece > 1{
                                categoryVM.piece -= 1
                                categoryVM.sumPrice = Double(categoryVM.piece) * categoryVM.product_price
                            }
                        } label: {
                            Image(systemName: "minus")
                                .foregroundColor(Color.white)
                                .padding(.horizontal,10)
                                .padding(.vertical,17)
                                .background(Color("Primary"))
                                .cornerRadius(12)
                        }
                        Text("\(categoryVM.piece)")
                            .font(.custom(customFont, size: 15))
                            .foregroundColor(Color("Primary"))
                            .fontWeight(.semibold)
                        Button{
                            categoryVM.piece += 1
                            categoryVM.sumPrice = Double(categoryVM.piece) * categoryVM.product_price
                        } label: {
                            Image(systemName: "plus")
                                .foregroundColor(Color.white)
                                .padding(.horizontal,10)
                                .padding(.vertical,12)
                                .background(Color("Primary"))
                                .cornerRadius(12)
                        }
                    }
                    .background(Color("HomeBG"))
                    .cornerRadius(12)

                    
                }
                .padding(.horizontal)
                Divider().background(Color("Secondary"))
                HStack{
                    Text("Fiyat")
                        .font(.custom(customFont, size: 15))
                        .foregroundColor(Color.black)
                    Spacer()
                    if categoryVM.sumPrice != 1.0{
                        Text(String(format: "%.02f ₺", categoryVM.sumPrice))
                            .font(.custom(customFont, size: 15))
                            .foregroundColor(Color("Primary"))
                            .fontWeight(.semibold)
                    } else {
                        Text(String(format: "%.02f ₺", categoryVM.product_price))
                            .font(.custom(customFont, size: 15))
                            .foregroundColor(Color("Primary"))
                            .fontWeight(.semibold)
                    }

                    
                }
                .padding(.horizontal)
                .padding(.vertical)
                Divider().background(Color("Secondary"))
                
            }
                
            ZStack{
                Button{
                    categoryVM.addBasket(product_id: product_id)
                } label: {
                    Text("Sepete Ekle")
                        .font(.custom(customFont, size: 15))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .foregroundColor(Color.white)
                        .background(Color("Primary"))
                        .cornerRadius(12)
                }
                .padding()
                .alert(isPresented: $categoryVM.showAlert){
                    withAnimation{
                        SwiftUI.Alert(title: Text("eRestaurant"), message: Text(categoryVM.message), dismissButton: SwiftUI.Alert.Button.cancel(Text("Tamam")))
                    }
                }
            }
            .background(Color.white.ignoresSafeArea())
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y:-5)
        }
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white.ignoresSafeArea())
        .onAppear{
            DispatchQueue.main.async {
                categoryVM.getProduct(product_id: product_id)
            }
        }
        
    }
}

struct ProductDetail_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
