//
//  ContentView.swift
//  eRestaurant-Tez
//
//  Created by GÜRHAN YUVARLAK on 29.12.2021.
//

import SwiftUI

let customFont = "Poppins-Regular"

struct ContentView: View {
    var body: some View {
        NavigationView{
            VStack{
                Image("onBoard")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth:.infinity, alignment: .leading)
                    .frame(height: getRect().height / 1.75)
                    .padding()
                        
                ScrollView(.vertical,showsIndicators: false){
                    VStack(spacing:15){
                            Text("eRestaurant'a Hoş Geldin")
                                .font(.custom(customFont, size: 24))
                                .fontWeight(.semibold)
                                .foregroundColor(Color.black)
                                .frame(maxWidth:.infinity,alignment: .leading)
                        
                        
                        NavigationLink{
                            LoginView()
                                .navigationBarHidden(true)
                        } label: {
                            Text("Giriş Yap")
                                .font(.custom(customFont, size: 17))
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .foregroundColor(Color.white)
                                .background(Color("Primary"))
                                .cornerRadius(12)
                        }
                        .padding(.top,15)
                        NavigationLink{
                            RegisterView()
                                .navigationBarHidden(true)
                        } label: {
                            Text("Üye Ol")
                                .font(.custom(customFont, size: 17))
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .foregroundColor(Color("Primary"))
                                .background(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color("Primary"), lineWidth: 2)
                                )
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 12")
        ContentView()
            .previewDevice("iPhone 8")
    }
}


extension View{
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
}
