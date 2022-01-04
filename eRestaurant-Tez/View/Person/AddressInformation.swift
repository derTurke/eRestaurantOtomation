//
//  AddressInformation.swift
//  eRestaurant-Tez
//
//  Created by GÜRHAN YUVARLAK on 30.12.2021.
//

import SwiftUI

struct AddressInformation: View {
    @StateObject var personVM : PersonViewModel = PersonViewModel()
    @State var showSheet : Bool = false
    @State var showEditSheet : Bool = false
    @State var showAlert : Bool = false
    var body: some View {
        VStack{
            VStack(spacing:15){
                Button{
                    showSheet.toggle()
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
                    .frame(maxWidth:.infinity,alignment: .trailing)
                }.sheet(isPresented: $showSheet, onDismiss: {
                    personVM.getAddresses()
                } ,content: addAddressView.init)
                
                
                
                Divider().foregroundColor(Color("Secondary"))
                
                
                if personVM.addresses.isEmpty {
                    Text("Adres kaydı yok")
                        .font(.custom(customFont, size: 16))
                        .frame(maxWidth: .infinity,alignment: .leading)
                } else {
                    ForEach(personVM.addresses, id:\.id){address in
                        Text("Adres Tanımı:")
                            .font(.custom(customFont, size: 15))
                            .foregroundColor(Color("Secondary"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(address.header)
                            .font(.custom(customFont, size: 15))
                            .foregroundColor(Color.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("Adres:")
                            .font(.custom(customFont, size: 15))
                            .foregroundColor(Color("Secondary"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(address.address)
                            .font(.custom(customFont, size: 15))
                            .foregroundColor(Color.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack{
                            Text("Bina No:")
                                .font(.custom(customFont, size: 15))
                                .foregroundColor(Color("Secondary"))
                            Text(address.building_no)
                                .font(.custom(customFont, size: 15))
                                .foregroundColor(Color.black)
                            Text("Kat:")
                                .font(.custom(customFont, size: 15))
                                .foregroundColor(Color("Secondary"))
                            Text(address.floor ?? "")
                                .font(.custom(customFont, size: 15))
                                .foregroundColor(Color.black)
                            Text("Daire No:")
                                .font(.custom(customFont, size: 15))
                                .foregroundColor(Color("Secondary"))
                            Text(address.apartment_no ?? "")
                                .font(.custom(customFont, size: 15))
                                .foregroundColor(Color.black)
                            Spacer()
                        }
                        
                        VStack{
                            Text("Adres Tarifi (İsteğe Bağlı):")
                                .font(.custom(customFont, size: 15))
                                .foregroundColor(Color("Secondary"))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(address.specification ?? "")
                                .font(.custom(customFont, size: 15))
                                .foregroundColor(Color.black)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        
                        }
                            
                        Text("Telefon:")
                            .font(.custom(customFont, size: 15))
                            .foregroundColor(Color("Secondary"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(address.phone)
                            .font(.custom(customFont, size: 15))
                            .foregroundColor(Color.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack{
                            Spacer()
                            Button{
                                showEditSheet.toggle()
                                personVM.id = address.id
                            } label: {
                                Label {
                                    Text("Düzenle")
                                } icon: {
                                    Image(systemName: "pencil")
                                }
                                .font(.custom(customFont, size: 13))
                                .foregroundColor(Color.white)
                                .padding(.horizontal,5)
                                .background(
                                    Color("Primary")
                                )
                                
                                .cornerRadius(12)
                            }.sheet(isPresented: $showEditSheet, onDismiss: {
                                personVM.getAddresses()}) {
                                editAddressView.init(id: personVM.id)
                            }
                            Button{
                                showAlert.toggle()
                                personVM.id = address.id
                            } label: {
                                Label {
                                    Text("Sil")
                                } icon: {
                                    Image(systemName: "x.circle")
                                }
                                .font(.custom(customFont, size: 13))
                                .foregroundColor(Color.white)
                                .padding(.horizontal,5)
                                .background(
                                    Color.red
                                )
                                
                                .cornerRadius(12)
                            }
                            .alert(isPresented: $showAlert){
                                withAnimation{
                                    SwiftUI.Alert(title: Text("eRestaurant"), message: Text("Silmek istediğinize emin misiniz?"), primaryButton: Alert.Button.destructive(Text("Hayır")),secondaryButton: Alert.Button.default(Text("Evet"), action: {
                                        DispatchQueue.main.async {
                                            personVM.deleteAddress(id: personVM.id)
                                        }
                                    }))
                                }
                            }
                        }
                        Divider().foregroundColor(Color("Secondary"))
                    }
                    
                }
            }
            .padding(20)
            
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(
            Color.white
                .clipShape(CustomCorners(corners: [.bottomLeft,.bottomRight], radius: 16))
                .ignoresSafeArea()
        )
        .offset(y:-15)
        .onAppear{
            DispatchQueue.main.async{
                personVM.getAddresses()
            }
        }
        
    }
    
}

struct AddressInformation_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

struct addAddressView : View{
    @Environment(\.presentationMode) var presentationMode
    @StateObject var personVM : PersonViewModel = PersonViewModel()
    var body: some View {
        VStack(alignment: .leading){
            Text("Adres Ekle")
                .font(.custom(customFont, size: 16))
                .fontWeight(.semibold)
                .foregroundColor(Color.white)
                .frame(maxWidth:.infinity,alignment: .leading)
                .padding()
                .background(
                    Color("Primary")
                )
            VStack{
                CustomTextField(title: "Adres Tanımı", hint: "Adres tanımınızı giriniz", value: $personVM.header)
                CustomTextField(title: "Adres", hint: "Adresinizi giriniz", value: $personVM.address_info)
                HStack{
                    CustomTextField(title: "Bina No", hint: "Bina no", value: $personVM.building_no)
                    CustomTextField(title: "Kat", hint: "Kat", value: $personVM.floor)
                    CustomTextField(title: "Daire No", hint: "Daire no", value: $personVM.apartment_no)
                }
                
                CustomTextField(title: "Adres Tarifi (İsteğe Bağlı)", hint: "Adres tarifinizi giriniz (isteğe bağlı)", value: $personVM.specification)
                CustomTextField(title: "Telefon Numarası", hint: "Telefon numaranızı giriniz", value: $personVM.phone)
                Button{
                    DispatchQueue.main.async {
                        personVM.addAddress()
                    }
                } label: {
                    Text("Kaydet")
                        .font(.custom(customFont, size: 17))
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color.white)
                        .background(Color("Primary"))
                        .cornerRadius(12)
                }
                .padding(.vertical,30)
                .alert(isPresented: $personVM.showAlert){
                    withAnimation{
                        SwiftUI.Alert(title: Text("eRestaurant"), message: Text(personVM.message), dismissButton: personVM.addSheet ? SwiftUI.Alert.Button.default(Text("Tamam"), action: {
                            presentationMode.wrappedValue.dismiss()
                        }) :  SwiftUI.Alert.Button.cancel(Text("Tamam")))
                    }
                }
                
            }
            .padding(30)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("HomeBG").ignoresSafeArea())
        
    }
    func close(){
        presentationMode.wrappedValue.dismiss()
    }
    func CustomTextField(title: String, hint: String, value: Binding<String>)->some View{
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.custom(customFont, size: 14))
            .foregroundColor(Color("Secondary"))
            
            
            TextField(hint, text: value)
                .colorScheme(.light)
                .padding(.top,2)
                .font(.custom(customFont, size: 16))
                .foregroundColor(Color.black)
            
            
            
            Divider()
                .background(Color("Secondary"))

        }
    }
}

struct editAddressView : View{
    @Environment(\.presentationMode) var presentationMode
    @StateObject var personVM : PersonViewModel = PersonViewModel()
    var id : Int
    var body: some View {
        VStack(alignment: .leading){
            Text("Adres Düzenle")
                .font(.custom(customFont, size: 16))
                .fontWeight(.semibold)
                .foregroundColor(Color.white)
                .frame(maxWidth:.infinity,alignment: .leading)
                .padding()
                .background(
                    Color("Primary")
                )
            VStack{
                CustomTextField(title: "Adres Tanımı", hint: "Adres tanımınızı giriniz", value: $personVM.header)
                CustomTextField(title: "Adres", hint: "Adresinizi giriniz", value: $personVM.address_info)
                HStack{
                    CustomTextField(title: "Bina No", hint: "Bina no", value: $personVM.building_no)
                    CustomTextField(title: "Kat", hint: "Kat", value: $personVM.floor)
                    CustomTextField(title: "Daire No", hint: "Daire no", value: $personVM.apartment_no)
                }
                
                CustomTextField(title: "Adres Tarifi (İsteğe Bağlı)", hint: "Adres tarifinizi giriniz (isteğe bağlı)", value: $personVM.specification)
                CustomTextField(title: "Telefon Numarası", hint: "Telefon numaranızı giriniz", value: $personVM.phone)
                Button{
                    personVM.editAddress(id: id)
                } label: {
                    Text("Kaydet")
                        .font(.custom(customFont, size: 17))
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color.white)
                        .background(Color("Primary"))
                        .cornerRadius(12)
                }
                .padding(.vertical,30)
                .alert(isPresented: $personVM.showAlert){
                    withAnimation{
                        SwiftUI.Alert(title: Text("eRestaurant"), message: Text(personVM.message), dismissButton: personVM.addSheet ? SwiftUI.Alert.Button.default(Text("Tamam"), action: {
                            presentationMode.wrappedValue.dismiss()
                        }) :  SwiftUI.Alert.Button.cancel(Text("Tamam")))
                    }
                }
                
            }
            .padding(30)
            
            Spacer()
        }.onAppear{
            DispatchQueue.main.async {
                personVM.getAddress(id: id)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("HomeBG").ignoresSafeArea())
        
        
    }
    func close(){
        presentationMode.wrappedValue.dismiss()
    }
    func CustomTextField(title: String, hint: String, value: Binding<String>)->some View{
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.custom(customFont, size: 14))
            .foregroundColor(Color("Secondary"))
            
            
            TextField(hint, text: value)
                .padding(.top,2)
                .font(.custom(customFont, size: 16))
                .foregroundColor(Color.black)
                .colorScheme(.light)
            
            
            
            Divider()
                .background(Color("Secondary"))

        }
    }
}

