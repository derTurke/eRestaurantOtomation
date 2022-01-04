//
//  PersonelInformation.swift
//  eRestaurant-Tez
//
//  Created by GÜRHAN YUVARLAK on 30.12.2021.
//

import SwiftUI

struct PersonelInformation: View {
    @StateObject var personVM : PersonViewModel = PersonViewModel()
    var body: some View {
            VStack{
                VStack(spacing:15){
                    CustomTextField(title: "Adınız Soyadınız", hint: "Adınızı ve soyadınızı giriniz", value: $personVM.name, showPassword: .constant(false))
                    CustomTextField(title: "E-posta Adresi", hint: "E-posta adresinizi giriniz", value: $personVM.email, showPassword: .constant(false))
                    DatePicker("Doğum Tarihi", selection: $personVM.birthdate,displayedComponents: .date)
                        .colorScheme(ColorScheme.light)
                        .accentColor(Color.black)
                        .foregroundColor(Color.black)
                        .environment(\.locale, Locale.init(identifier: "tr_TR"))
                        
                    Divider()
                        .background(Color("Secondary"))
                    
                    Text("Cinsiyet")
                        .font(.custom(customFont, size: 14))
                        .frame(maxWidth:.infinity, alignment: .leading)
                    
                    Picker("Cinsiyet", selection: $personVM.sex) {
                        Text("Cinsiyetinizi seçiniz")
                            .tag("")
                            .foregroundColor(Color.black)
                        Text("Erkek")
                            .tag("Erkek")
                            .foregroundColor(Color.black)
                            
                        Text("Kadın")
                            .tag("Kadın")
                            .foregroundColor(Color.black)
                    }
                    .colorScheme(.light)
                    .accentColor(Color.black)
                    .frame(maxWidth:.infinity, alignment: .leading)
                    Divider()
                        .background(Color("Secondary"))
                    
                    Button{
                        DispatchQueue.main.async {
                            withAnimation{
                                personVM.updatePersonelInformation()
                            }
                        }
                    } label: {
                        Text("Profilimi Güncelle")
                            .font(.custom(customFont, size: 15))
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .frame(height: 30)
                            .foregroundColor(Color.white)
                            .background(Color("Secondary"))
                            .cornerRadius(12)
                    }
                    .alert(isPresented: $personVM.showAlert){
                        withAnimation{
                            SwiftUI.Alert(title: Text("eRestaurant"), message: Text(personVM.message), dismissButton: SwiftUI.Alert.Button.cancel(Text("Tamam")))
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
                DispatchQueue.main.async {
                        personVM.getPersonelInformation()
                }
            }
        
    }
    func CustomTextField(title: String, hint: String, value: Binding<String>,showPassword: Binding<Bool>)->some View{
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.custom(customFont, size: 14))
            .foregroundColor(Color("Secondary"))
            
            if title.contains("Şifre") && !showPassword.wrappedValue{
                SecureField(hint, text: value)
                    .colorScheme(.light)
                    .padding(.top,2)
                    .font(.custom(customFont, size: 16))
                    .foregroundColor(Color.black)
            } else {
                TextField(hint, text: value)
                    .colorScheme(.light)
                    .padding(.top,2)
                    .font(.custom(customFont, size: 16))
                    .foregroundColor(Color.black)
            }
            
            
            
            Divider()
                .background(Color("Secondary"))

        }
        // Showing Show Button for password Field..
        .overlay(
            Group{
                if title.contains("Şifre"){
                    Button(action: {
                        showPassword.wrappedValue.toggle()
                    }, label: {
                        Image(systemName: showPassword.wrappedValue ? "eye.slash" : "eye")
                            .font(.custom(customFont, size: 20).bold())
                            .foregroundColor(Color("Primary"))
                    })
                        .offset(y:8)
                }
            }
            ,alignment: .trailing
        )
        
    }
}

struct PersonelInformation_Previews: PreviewProvider {
    static var previews: some View {
        PersonView()
    }
}
