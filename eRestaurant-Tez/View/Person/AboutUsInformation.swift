//
//  AboutUsInformation.swift
//  eRestaurant-Tez
//
//  Created by GÜRHAN YUVARLAK on 31.12.2021.
//

import SwiftUI

struct AboutUsInformation: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var personVM : PersonViewModel = PersonViewModel()
   
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text("Hakkımızda")
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
                    HStack{
                        Text("Şirket İsim: ")
                        Text(personVM.company_name)
                            .bold()
                    }
                    HStack{
                        Text("Marka İsim: ")
                        Text(personVM.brand_name)
                            .bold()
                    }
                    .padding(.bottom)
                    Text("Ticari Bilgiler:")
                        .bold()
                    HStack{
                        Text("Sicil No: ")
                        Text(personVM.sicil_no)
                            
                    }
                    HStack{
                        Text("Vergi No: ")
                        Text(personVM.vergi_no)
                            
                    }
                    HStack{
                        Text("Vergi Dairesi: ")
                        Text(personVM.vergi_dairesi)
                            
                    }
                    HStack{
                        Text("Mersis No: ")
                        Text(personVM.mersis_no)
                            
                    }
                }
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.bottom)
                VStack{
                    Text("İletişim Bilgileri:")
                        .bold()
                        .frame(maxWidth: .infinity,alignment: .leading)
                    HStack{
                        Text("Adres: ")
                        Text(personVM.address)
                    }
                    .frame(maxWidth: .infinity,alignment: .leading)
                    HStack{
                        Text("Telefon: ")
                        Text(personVM.aboutUs_phone)
                            
                    }
                    .frame(maxWidth: .infinity,alignment: .leading)
                    HStack{
                        Text("Fax: ")
                        Text(personVM.fax)
                            
                    }
                    .frame(maxWidth: .infinity,alignment: .leading)
                    HStack{
                        Text("E-posta: ")
                        Text(personVM.aboutUs_email)
                            
                    }
                    .frame(maxWidth: .infinity,alignment: .leading)
                }
                .padding(.bottom)
                
                VStack{
                   Text("Sosyal Medya Hesapları: ")
                        .bold()
                        .frame(maxWidth: .infinity,alignment: .leading)
                    HStack{
                        Link(destination: URL(string: "https://www.facebook.com/gurhan061")!){
                            Image("facebook")
                                .resizable()
                                .frame(width: 50, height: 50)
                        }
                        Spacer()
                        Link(destination: URL(string: "https://www.instagram.com/gurhanyuvarlak")!){
                            Image("instagram")
                                .resizable()
                                .frame(width: 50, height: 50)
                        }
                        Spacer()
                        Link(destination: URL(string: "https://twitter.com/Gurhann07")!){
                            Image("twitter")
                                .resizable()
                                .frame(width: 50, height: 50)
                        }
                        Spacer()
                        Link(destination: URL(string: "https://www.linkedin.com/in/gurhanyuvarlak/")!){
                            Image("linkedin")
                                .resizable()
                                .frame(width: 50, height: 50)
                        }
                    }
                }
                
            }
            .font(.custom(customFont, size: 16))
            .foregroundColor(Color.black)
            .padding(10)
            
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white.ignoresSafeArea())
        .onAppear{
            DispatchQueue.main.async {
                personVM.getAboutUs()
            }
            
                
        }
    }
}

struct AboutUsInformation_Previews: PreviewProvider {
    static var previews: some View {
        AboutUsInformation()
    }
}
