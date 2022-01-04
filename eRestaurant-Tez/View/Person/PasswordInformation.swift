//
//  PasswordInformation.swift
//  eRestaurant-Tez
//
//  Created by GÜRHAN YUVARLAK on 31.12.2021.
//

import SwiftUI

struct PasswordInformation: View {
    @StateObject var personVM : PersonViewModel = PersonViewModel()
    var body: some View {
        VStack{
            VStack(spacing: 15){
                CustomTextField(title: "Mevcut Şifre", hint: "Mevcut şifrenizi giriniz", value: $personVM.password, showPassword: $personVM.showPassword)
                CustomTextField(title: "Yeni Şifre", hint: "Yeni şifrenizi giriniz", value: $personVM.newPassword, showPassword: $personVM.showNewPassword)
                CustomTextField(title: "Yeni Şifre (Tekrar)", hint: "Yeni şifrenizi onaylayınız", value: $personVM.reNewPassword, showPassword: $personVM.showReNewPassword)
                
                Button{
                    personVM.editPassword()
                } label: {
                    Text("Şifremi Güncelle")
                        .font(.custom(customFont, size: 15))
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .frame(height: 30)
                        .foregroundColor(Color.white)
                        .background(Color("Secondary"))
                        .cornerRadius(12)
                }
            }
            .padding(20)
            .alert(isPresented: $personVM.showAlert){
                withAnimation{
                    SwiftUI.Alert(title: Text("eRestaurant"), message: Text(personVM.message), dismissButton: SwiftUI.Alert.Button.default(Text("Tamam"), action: {
                        DispatchQueue.main.async {
                            if personVM.clearTextField {
                                personVM.password = ""
                                personVM.newPassword = ""
                                personVM.reNewPassword = ""
                            }
                        }
                    }))
                    
                }
            }
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(
            Color.white
                .clipShape(CustomCorners(corners: [.bottomLeft,.bottomRight], radius: 16))
                .ignoresSafeArea()
        )
        .offset(y:-15)
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

struct PasswordInformation_Previews: PreviewProvider {
    static var previews: some View {
        PasswordInformation()
    }
}
