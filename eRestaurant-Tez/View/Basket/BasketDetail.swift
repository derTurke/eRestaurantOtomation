//
//  BasketDetail.swift
//  eRestaurant-Tez
//
//  Created by GÜRHAN YUVARLAK on 6.03.2022.
//

import SwiftUI

struct BasketDetail: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var basketVM : BasketViewModel = BasketViewModel()
    @StateObject var categoryVM : CategoryViewModel = CategoryViewModel()
    
    init(){
        UISwitch.appearance().onTintColor = .red
    }
    var body: some View {
        NavigationView{
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
                    Text("Sipariş Onayı")
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
                    Toggle(isOn: $basketVM.isConfirm) {
                        Text("Masa numaranıza sipariş vermek istiyorsanız lütfen onaylayınız.")
                    }
                    .foregroundColor(Color.black)
                    .toggleStyle(SwitchToggleStyle(tint: Color("Primary")))
                    .padding(.horizontal)
                    .padding()
                    .accentColor(Color("Primary"))
                    .foregroundColor(Color("Primary"))
                    .background(
                        Color.white
                    )
                    .font(.custom(customFont, size: 16))
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 0)
                    .padding()
                    if(basketVM.isConfirm){
                        DisclosureGroup(basketVM.selectedTableId != 0 ? "Masa \(basketVM.selectedTable)" : "Masa Seçiniz...", isExpanded: $basketVM.isExpanded){
                            ScrollView(.vertical, showsIndicators: true) {
                                VStack{
                                    ForEach(self.basketVM.tables, id:\.id){ table in
                                        Text("Masa \(table.name)")
                                            .frame(maxWidth: .infinity)
                                            .padding(.all)
                                            .font(.custom(customFont, size: 14))
                                            .onTapGesture {
                                                DispatchQueue.main.async {
                                                    self.basketVM.selectedTable = "\(table.name)"
                                                    self.basketVM.selectedTableId = table.id
                                                }
                                                withAnimation{
                                                    self.basketVM.isExpanded.toggle()
                                                }
                                            }
                                            .foregroundColor(Color.black)
                                            
                                        
                                    }
                                }
                            }
                            .frame(height:150)
                        }
                        .padding()
                        .accentColor(Color("Primary"))
                        .foregroundColor(Color.black)
                        .background(
                            Color.white
                        )
                        .font(.custom(customFont, size: 16))
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 0)
                        .padding()

                    } else {
                        DisclosureGroup(basketVM.selectedAddressId != 0 ? "\(basketVM.selectedAddress)" : "Adres Seçiniz...", isExpanded: $basketVM.isExpanded){
                            ScrollView(.vertical, showsIndicators: true) {
                                VStack{
                                    ForEach(self.basketVM.addresses, id:\.id){ address in
                                        Text("\(address.header)")
                                            .frame(maxWidth: .infinity)
                                            .padding(.all)
                                            .font(.custom(customFont, size: 14))
                                            .onTapGesture {
                                                DispatchQueue.main.async {
                                                    basketVM.selectedAddress = "\(address.header) - \(address.address)"
                                                    basketVM.selectedAddressId = address.id
                                                }
                                                withAnimation{
                                                    self.basketVM.isExpanded.toggle()
                                                }
                                            }
                                            .foregroundColor(Color.black)
                                            
                                        
                                    }
                                    Button{
                                        basketVM.showSheet.toggle()
                                    } label: {
                                        Label {
                                            Text("Yeni Adres Ekle")
                                                .foregroundColor(Color("Secondary"))
                                        } icon: {
                                            Image(systemName: "plus")
                                                .background(
                                                    Circle()
                                                        .foregroundColor(Color("Primary"))
                                                        .frame(width: 25, height: 25)
                                                )
                                                .foregroundColor(Color.white)
                                        }
                                        .frame(maxWidth:.infinity,alignment: .center)
                                    }.sheet(isPresented: $basketVM.showSheet, onDismiss: {
                                        DispatchQueue.main.async {
                                            basketVM.getAddresses()
                                        }
                                    } ,content: addAddressView.init)
                                        .padding()
                                }
                            }
                            .frame(height:150)
                        }
                        .padding()
                        .accentColor(Color("Primary"))
                        .foregroundColor(Color.black)
                        .background(
                            Color.white
                        )
                        .font(.custom(customFont, size: 16))
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 0)
                        .padding()
                    }
                    VStack(alignment:.leading){
                        Text("Sipariş Notu")
                            .font(.custom(customFont, size: 14))
                            .foregroundColor(Color("Secondary"))
                            
                        TextEditor(text: $basketVM.orderText)
                            .colorScheme(.light)
                            .accentColor(Color.black)
                            .padding(.top,2)
                            .font(.custom(customFont, size: 14))
                            .foregroundColor(Color.black)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.black.opacity(0.2), lineWidth: 1)
                            )
                            .frame(height: 100);
                    }
                    .padding()
                    .background(
                        Color.white
                    )
                    .font(.custom(customFont, size: 16))
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 0)
                    .padding()
                    HStack{
                        VStack{
                            Text("TOPLAM")
                                .font(.custom(customFont, size: 16))
                                .fontWeight(.semibold)
                                .foregroundColor(Color.black)
                                .frame(maxWidth:.infinity,alignment: .leading)
                            Text(String(format: "%.02f ₺", basketVM.basketTotal))
                                .font(.custom(customFont, size: 16))
                                .fontWeight(.semibold)
                                .foregroundColor(Color("Primary"))
                                .frame(maxWidth:.infinity,alignment: .leading)
                        }
                        .padding(.horizontal)
                        Button{
                            DispatchQueue.main.async {
                                basketVM.addOrder()
                            }
                        } label: {
                            Text("Sipariş Ver")
                                .font(.custom(customFont, size: 15))
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .foregroundColor(Color.white)
                                .background(Color("Primary"))
                                .cornerRadius(12)
                        }
                        .padding()
                        .alert(isPresented: $basketVM.showAlert){
                            withAnimation{
                                SwiftUI.Alert(title: Text("eRestaurant"), message: Text(basketVM.message), dismissButton: basketVM.message == "success" ? SwiftUI.Alert.Button.default(Text("Tamam"), action: {
                                    
                                    
                                    DispatchQueue.main.async {
                                        withAnimation{
                                            categoryVM.getBasket()
                                            categoryVM.basket = []
                                            presentationMode.wrappedValue.dismiss()
                                        }
                                       
                                    }
                                    
                                }) : SwiftUI.Alert.Button.default(Text("Tamam"), action: {
                                    
                                    
                                    DispatchQueue.main.async {
                                        withAnimation{
                                            categoryVM.getBasket()
                                            categoryVM.basket = []
                                            presentationMode.wrappedValue.dismiss()
                                        }
                                    }
                                    
                                    
                                }))
                            }
                        }
                    }
                    .padding(.horizontal)
                    .background(
                        Color.white
                    )
                    .font(.custom(customFont, size: 16))
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 0)
                    .padding()
                    .padding(.bottom,100)
                    
                }
                
                
            
                
                   
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white.ignoresSafeArea())
            .onAppear{
                DispatchQueue.main.async {
                    basketVM.getAddresses();
                    basketVM.getBasketSummary()
                    basketVM.getTables()
                }
            }
            .navigationBarHidden(true)
            
        }
        
        
    }
        
}

struct BasketDetail_Previews: PreviewProvider {
    static var previews: some View {
        BasketDetail()
    }
}
