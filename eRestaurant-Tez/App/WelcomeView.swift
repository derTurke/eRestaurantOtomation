//
//  WelcomeView.swift
//  eRestaurant-Tez
//
//  Created by GÜRHAN YUVARLAK on 31.12.2021.
//

import SwiftUI

struct WelcomeView: View {
    
    @AppStorage("logStatus") var logStatus : Bool = false
    var body: some View {
        Group{
            if logStatus{
                MainView()
            } else {
                ContentView()
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
