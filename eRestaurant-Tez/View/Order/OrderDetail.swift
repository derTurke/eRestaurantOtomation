//
//  OrderDetail.swift
//  eRestaurant-Tez
//
//  Created by GÜRHAN YUVARLAK on 12.03.2022.
//

import SwiftUI

struct OrderDetail: View {
    var id : Int
    @Environment(\.presentationMode) var presentationMode
    @StateObject var orderVM : OrderViewModel = OrderViewModel()
    
    var body: some View {
            VStack{
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
                    Text("Sipariş Detay")
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
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(alignment: .leading){
                        ForEach(orderVM.orderDetailProducts, id:\.id){ orderProduct in
                            OrderProductCard(product: orderProduct)
                                
                        }
                    }
                    .padding(.top)
                    
                   
                    HStack{
                        
                        Text("TOPLAM")
                            .font(.custom(customFont, size: 16))
                            .fontWeight(.semibold)
                            .foregroundColor(Color.black)
                        Spacer()
                        Text(String(format: "%.02f ₺", orderVM.total))
                            .font(.custom(customFont, size: 16))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Primary"))
                    }
                    .padding()
                    .background(
                        Color.white
                    )
                    .font(.custom(customFont, size: 16))
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 0)
                    .padding(.horizontal)
                    .padding()
                    VStack{
                        VStack(alignment: .leading){
                            Text("Sipariş Numarası")
                                .fontWeight(.semibold)
                            Text("\(id)")
                            Divider().foregroundColor(Color.black.opacity(0.2))
                            Text("Sipariş Tarihi")
                                .fontWeight(.semibold)
                            Text(formatStringDate(date:orderVM.created_at))
                            Divider().foregroundColor(Color.black.opacity(0.2))
                            Text("Sipariş Notu")
                                .fontWeight(.semibold)
                            Text(orderVM.note)
                            Divider().foregroundColor(Color.black.opacity(0.2))
                            
                        }
                        if(orderVM.address != ""){
                            VStack(alignment: .leading){
                                HStack{
                                    VStack{
                                        Text("İlgili Kişi")
                                            .fontWeight(.semibold)
                                            .frame(maxWidth:.infinity,alignment: .leading)
                                        Text(orderVM.user_name)
                                            .frame(maxWidth:.infinity,alignment: .leading)
                                    }
                                    Divider().foregroundColor(Color.black.opacity(0.2))
                                    VStack(alignment: .leading){
                                        Text("İrtibat Telefon")
                                            .fontWeight(.semibold)
                                            .frame(maxWidth:.infinity,alignment: .leading)
                                        Text(orderVM.phone)
                                            .frame(maxWidth:.infinity,alignment: .leading)
                                    }
                                }
                                Divider().foregroundColor(Color.black.opacity(0.2))
                                Text("Adres")
                                    .fontWeight(.semibold)
                                Text(orderVM.address)
                                Divider().foregroundColor(Color.black.opacity(0.2))
                                Text("Adres Tarifi")
                                    .fontWeight(.semibold)
                                Text(orderVM.specification)
                            }
                        } else {
                            VStack(alignment: .leading){
                                Text("Masa Numarası")
                                    .fontWeight(.semibold)
                                    .frame(maxWidth:.infinity,alignment: .leading)
                                Text("\(orderVM.table_name)")
                                    .frame(maxWidth:.infinity,alignment: .leading)
                            }
                        }
                        
                        
                        
                    }
                    .padding()
                    .background(
                        Color.white
                    )
                    .font(.custom(customFont, size: 16))
                    .foregroundColor(Color.black)
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 0)
                    .padding(.horizontal)
                    .padding(.horizontal)
                    .padding(.bottom,100)
                }
            }
            .background(Color.white.ignoresSafeArea())
            .navigationBarHidden(true)
            .onAppear{
                DispatchQueue.main.async {
                    orderVM.getOrderProducts(order_id: id)
                    orderVM.getOrderDetail(order_id: id)
                }
                
            }
            
            
        }
    @ViewBuilder
    func OrderProductCard(product: OrderDetailProductModel)-> some View{
        HStack{
            CategoryImage(url: product.image)
                .frame(width: 75, height: 75)
            VStack(alignment: .leading){
                Text("\(product.name)")
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
        }
        .padding()
        .foregroundColor(Color.black)
        .background(
            Color.white
        )
        .font(.custom(customFont, size: 16))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 0)
        .padding(.horizontal)
        .padding(.horizontal)
        
    }
    

}

struct OrderDetail_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetail(id: 1)
    }
}
