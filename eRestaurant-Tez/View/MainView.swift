//
//  MainView.swift
//  eRestaurant-Tez
//
//  Created by GÜRHAN YUVARLAK on 29.12.2021.
//

import SwiftUI

struct MainView: View {
    @StateObject var mainVM : MainViewModel = MainViewModel()
    
    //Tabbar Hiding
    init(){
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        TabView(selection: $mainVM.currentTab) {
            HomeView()
                .tag(Tab.Home)
            Text("Heart")
                .tag(Tab.Heart)
            Text("ClipBoard")
                .tag(Tab.ClipBoard)
            PersonView()
                .tag(Tab.Person)
            
        }
        .overlay(
            HStack(spacing: 0){
                TabButton(Tab: .Home)
                TabButton(Tab: .ClipBoard)
                    .offset(x: -10)
                
                Button{
                    
                } label: {
                    Image(systemName: "qrcode")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 26, height: 26)
                        .foregroundColor(Color.white)
                        .padding(18)
                        .background(Color("Primary"))
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.04), radius: 5, x: 5, y: 5)
                        .shadow(color: Color.black.opacity(0.04), radius: 5, x: -5, y: -5)
                }
                .offset(y : -30)
                TabButton(Tab: .Heart)
                    .offset(x: +10)
                TabButton(Tab: .Person)
            }
                .background(
                    Color.white
                        .clipShape(CustomCurveShape())
                        .shadow(color: Color.black.opacity(0.04), radius: 5, x: 5, y: 5)
                        .ignoresSafeArea(.container, edges: .bottom)
                )
            ,alignment: .bottom
        )
    }
    @ViewBuilder
    func TabButton(Tab: Tab)-> some View{
        Button{
            withAnimation {
                mainVM.currentTab = Tab
            }
        } label: {
            Image(Tab.rawValue)
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
                .foregroundColor(mainVM.currentTab == Tab ? Color("Primary") : Color("Secondary"))
                .frame(maxWidth: .infinity)
        }
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .previewDevice("iPhone 12")
        MainView()
            .previewDevice("iPhone 8")
    }
}
