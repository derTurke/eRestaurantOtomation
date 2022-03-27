//
//  ForgotPasswordView.swift
//  eRestaurant-Tez
//
//  Created by GÜRHAN YUVARLAK on 27.03.2022.
//

import SwiftUI

struct ForgotPasswordView: View {
    @StateObject var authVM : AuthViewModel = AuthViewModel()
    @State var showAlert : Bool = false
    var body: some View {
        NavigationView{
            VStack{
                Image("login")
                    .resizable()
                    .frame(maxWidth:.infinity, alignment: .leading)
                    .frame(height: getRect().height / 2.25)
                    .padding(20)
                        
                ScrollView(.vertical,showsIndicators: false){
                    VStack(spacing:15){
                        HStack{
                            NavigationLink {
                                LoginView()
                                    .navigationBarHidden(true)
                            } label: {
                                Image(systemName: "arrow.left")
                                    .font(.custom(customFont, size: 24).bold())
                                    .foregroundColor(Color.black)
                                    
                            }
                            

                            Text("Şifre mi Unuttum?")
                                .font(.custom(customFont, size: 24))
                                .fontWeight(.semibold)
                                .foregroundColor(Color.black)
                        }
                        .frame(maxWidth:.infinity,alignment: .leading)
                        .padding(.bottom,5)
                        
                        if authVM.state == 1{
                            CustomTextField(icon: "envelope", title: "E-posta Adresi", hint: "E-posta adresinizi giriniz", value: $authVM.email, showPassword: .constant(false))
                            
                            Button{
                                DispatchQueue.main.async {
                                    authVM.ForgotPassword()
                                }
                            } label: {
                                Text("Gönder")
                                    .font(.custom(customFont, size: 17))
                                    .padding(.vertical)
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(Color.white)
                                    .background(Color("Primary"))
                                    .cornerRadius(12)
                            }
                            .padding(.top,15)
                            .alert(isPresented: $authVM.showAlert){
                                withAnimation{
                                    SwiftUI.Alert(title: Text("eRestaurant"), message: Text(authVM.message), dismissButton: SwiftUI.Alert.Button.cancel(Text("Tamam")))
                                }
                            }
                        } else if authVM.state == 2 {
                            CustomTextField(icon: "lock", title: "Şifre", hint: "Şifrenizi giriniz", value: $authVM.password, showPassword: $authVM.showPassword)
                            CustomTextField(icon: "lock", title: "Şifre (tekrar)", hint: "Şifrenizi tekrar giriniz", value: $authVM.passwordTekrar, showPassword: $authVM.showPasswordTekrar)
                            
                            Button{
                                DispatchQueue.main.async {
                                    authVM.ForgotPassword2()
                                }
                            } label: {
                                Text("Onayla")
                                    .font(.custom(customFont, size: 17))
                                    .padding(.vertical)
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(Color.white)
                                    .background(Color("Primary"))
                                    .cornerRadius(12)
                            }
                            .padding(.top,15)
                            .alert(isPresented: $authVM.showAlert){
                                withAnimation{
                                    SwiftUI.Alert(title: Text("eRestaurant"), message: Text(authVM.message), dismissButton: SwiftUI.Alert.Button.cancel(Text("Tamam")))
                                }
                            }
                        }
                        
                    }
                    .padding(20)
                }
                .navigationBarHidden(true)
                .frame(maxWidth: .infinity,maxHeight: .infinity)
                .background(
                    Color.white
                        .clipShape(CustomCorners(corners: [.topLeft,.topRight], radius: 16))
                        .ignoresSafeArea()
                )
            }
            .frame(maxWidth:.infinity, maxHeight: .infinity)
            .background(
                Color("Primary")
            )
            .ignoresSafeArea(.all)
        }
    }
    @ViewBuilder
    func CustomTextField(icon: String, title: String, hint: String, value: Binding<String>,showPassword: Binding<Bool>)->some View{
        VStack(alignment: .leading, spacing: 12) {
            Label {
                Text(title)
                    .font(.custom(customFont, size: 14))
            } icon: {
                Image(systemName: icon)
            }
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

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
