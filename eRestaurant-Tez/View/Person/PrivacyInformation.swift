//
//  PrivacyInformation.swift
//  eRestaurant-Tez
//
//  Created by GÜRHAN YUVARLAK on 31.12.2021.
//

import WebKit
import SwiftUI

struct PrivacyInformation: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var personVM : PersonViewModel = PersonViewModel()
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text("Kullanıcı Sözleşmesi ve Gizlilik Politikası")
                    .font(.custom(customFont, size: 16))
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white)
                    .frame(maxWidth:.infinity,alignment: .leading)
                Button{
                    withAnimation{
                        presentationMode.wrappedValue.dismiss()
                    }
                } label: {
                    Image("close")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color.white)
                }
            }
            .padding()
            .background(
                Color("Primary")
                    .ignoresSafeArea()
            )
            ScrollView(.vertical,showsIndicators: false){
                VStack(alignment: .leading){
                    Text(personVM.privacyInformation)
                        .foregroundColor(Color.black)
                        .font(.custom(customFont, size: 14))
                }
            }
            
            .padding(10)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white.ignoresSafeArea())
        .onAppear{
            DispatchQueue.main.async {
                personVM.getPrivacyInformation()
            }
        }
    }
}

struct PrivacyInformation_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyInformation()
            .previewDevice("iPhone 12")
        PrivacyInformation()
            .previewDevice("iPhone 8")
    }
}

