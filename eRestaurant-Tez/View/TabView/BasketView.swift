//
//  BasketView.swift
//  eRestaurant-Tez
//
//  Created by GÜRHAN YUVARLAK on 6.03.2022.
//

import SwiftUI

struct BasketView: View {
    @StateObject var categoryVM : CategoryViewModel = CategoryViewModel()
    @State var showAlert : Bool = false
    var body: some View {
        NavigationView{
            VStack() {
                VStack(alignment: .leading){
                    HStack{
                        Text("Sepetim")
                            .font(.custom(customFont, size: 28).bold())
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(Color.black)
                        Spacer()
                            NavigationLink{
                                BasketDetail()
                                .navigationBarHidden(true)
                            } label: {
                                Text("Sepeti Onayla")
                                    .font(.custom(customFont, size: 15))
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .foregroundColor(Color.white)
                                    .background(Color("Primary"))
                                    .cornerRadius(12)
                            }
                            .padding()
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y:5)
                        
                    }
                    VStack{
                        ScrollView(.vertical,showsIndicators: false){
                            
                            ForEach(categoryVM.basket, id: \.id){ basket in
                                BasketCard(product: basket)
                            }
                        }
                        .offset(y:-10)
                        .padding(.bottom,70)
                        .font(.custom(customFont, size: 16))
                        .foregroundColor(Color.black)
                    }
                    .padding(.bottom,70)
                }
                .padding(.horizontal,20)
                .padding(.vertical,20)
            }
            
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white.ignoresSafeArea())
            
            
        }
        .onAppear{
            DispatchQueue.main.async {
                categoryVM.getBasket()
            }
        }
    }
    @ViewBuilder
    func BasketCard(product: BasketModel)-> some View{
        HStack{
            CategoryImage(url: product.image)
                .frame(width: 75, height: 75)
            VStack(alignment: .leading){
                Text(product.name)
                HStack{
                    Text("Adet:")
                    Text(String(format: "%.f", product.amount))
                }
                HStack{
                    Text("Tutar:")
                    Text(String(format: "%.02f ₺", product.total))
                }
                
            }
            Spacer()
            Button{
                showAlert.toggle()
                DispatchQueue.main.async {
                    categoryVM.basketProductId = product.id
                }
            
            } label: {
                Image(systemName: "trash")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .font(.custom(customFont, size: 13))
                    .foregroundColor(Color.red)
                    
            }
            .alert(isPresented: $showAlert){
                withAnimation{
                    SwiftUI.Alert(title: Text("eRestaurant"), message: Text("Silmek istediğinize emin misiniz?"), primaryButton: Alert.Button.destructive(Text("Hayır")),secondaryButton: Alert.Button.default(Text("Evet"), action: {
                        DispatchQueue.main.async {
                            categoryVM.deleteBasket(basket_product_id: categoryVM.basketProductId)
                        }
                    }))
                }
            }
        }
        .padding()
        .foregroundColor(Color.black)
        .background(
            Color.white
        )
        .font(.custom(customFont, size: 16))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 0)
        .padding()
        
    }
    
}

struct BasketView_Previews: PreviewProvider {
    static var previews: some View {
        BasketView()
    }
}
