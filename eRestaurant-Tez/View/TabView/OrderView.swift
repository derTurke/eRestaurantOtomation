//
//  OrderView.swift
//  eRestaurant-Tez
//
//  Created by GÜRHAN YUVARLAK on 12.03.2022.
//

import SwiftUI

struct OrderView: View {
    @StateObject var orderVM : OrderViewModel = OrderViewModel()
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading){
                    HStack{
                        Text("Siparişlerim")
                            .font(.custom(customFont, size: 28).bold())
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(Color.black)
                    }
                    VStack{
                        ForEach(orderVM.orders,id: \.id){ order in
                            OrderCart(order: order)
                        }
                    }
                    
                }
                .padding(.bottom,85)
                    
            }
            .padding(.horizontal,20)
            .padding(.vertical,20)
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white.ignoresSafeArea())
            
            
        }
        .onAppear{
            orderVM.getOrders();
        }
    }
    @ViewBuilder
    func OrderCart(order: OrderModel) -> some View {
        NavigationLink{
            OrderDetail(id: order.id)
                .navigationBarHidden(true)
        } label: {
            HStack{
                Image("logo")
                    .resizable()
                    .frame(width: 75, height: 75)
                    .clipShape(Circle())
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 0)
                VStack(alignment: .leading){
                    Text(formatStringDate(date: order.created_at))
                    Text(String(format: "%.02f ₺", order.total))
                    if order.status == 1{
                        Text("Onay Bekliyor")
                            .foregroundColor(Color("Primary"))
                    } else if order.status == 2{
                        Text("Hazırlanıyor")
                            .foregroundColor(Color("Primary"))
                        
                    } else if order.status == 3{
                        Text("Hazırlandı")
                            .foregroundColor(Color("Primary"))
                        
                    } else if order.status == 4{
                        Text("Tamamlandı")
                            .foregroundColor(Color("Primary"))
                    }
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .resizable()
                    .foregroundColor(Color("Primary"))
                    .frame(width: 10, height: 10)
            }
            .padding()
            
                
        }
        .foregroundColor(Color.black)
        .background(
            Color.white
        )
        .font(.custom(customFont, size: 16))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 0)
        .padding(.horizontal)
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
    }
}

func formatStringDate(date: String) -> String {
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

    let dateFormatterPrint = DateFormatter()
    dateFormatterPrint.dateFormat = "dd/MM/yyyy HH:mm"
    if let date2 = dateFormatterGet.date(from: date) {
        return dateFormatterPrint.string(from: date2)
    } else {
        return dateFormatterPrint.string(from: Date())
    }
}
