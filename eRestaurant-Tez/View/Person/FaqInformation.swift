//
//  FaqInformation.swift
//  eRestaurant-Tez
//
//  Created by GÜRHAN YUVARLAK on 30.12.2021.
//

import SwiftUI

struct FaqInformation: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var personVM : PersonViewModel = PersonViewModel()
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text("Sık Sorulan Sorular")
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
            VStack(alignment: .leading){
                ForEach(personVM.faqs, id: \.id){ faq in
                    DisclosureGroup(faq.question) {
                        Divider().foregroundColor(Color("Secondary"))
                        Text(faq.answer)
                            .foregroundColor(Color.black)
                            .frame(maxWidth:.infinity,alignment: .leading)
                    }
                    .padding()
                    .accentColor(Color("Primary"))
                    .foregroundColor(Color("Primary"))
                    .background(
                        Color.white
                    )
                    .font(.custom(customFont, size: 16))
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 0)
                    
                }
                
            }
            .padding(30)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white.ignoresSafeArea())
        .onAppear{
            DispatchQueue.main.async {
                personVM.getFAQ()
            }
        }

    }
}

struct FaqInformation_Previews: PreviewProvider {
    static var previews: some View {
        FaqInformation()
    }
}
