//
//  PersonView.swift
//  eRestaurant-Tez
//
//  Created by GÜRHAN YUVARLAK on 30.12.2021.
//

import SwiftUI

struct PersonView: View {
    @StateObject var authVM : AuthViewModel = AuthViewModel()
    @StateObject var personVM : PersonViewModel = PersonViewModel()
    @State var show : Bool = false
    var body: some View{
        NavigationView{
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading){
                    HStack{
                        Text("Profilim")
                            .font(.custom(customFont, size: 28).bold())
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(Color.black)
                        Button{
                            authVM.Logout()
                        } label: {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                .font(.custom(customFont, size: 30).bold())
                                .foregroundColor(Color("Primary"))
                        }
                        .alert(isPresented: $authVM.showAlert){
                            SwiftUI.Alert(title: Text("eRestaurant"), message: Text(authVM.message), dismissButton: SwiftUI.Alert.Button.cancel(Text("Tamam")))
                        }
                    }
                    
                    VStack{
                        DropDown(isActive: $personVM.showOrderInformation, title: "Siparişlerim", icon: "person")
                        
                        
                        DropDown(isActive: $personVM.showAddressInformation, title: "Teslimat Adreslerim", icon: "mappin.and.ellipse")
                        if personVM.showAddressInformation{
                            AddressInformation()
                        }
                        DropDown(isActive: $personVM.showPersonelInformation, title: "Kişisel Bilgiler", icon: "person")
                        if personVM.showPersonelInformation{
                            PersonelInformation()
                        }
                        DropDown(isActive: $personVM.showPasswordInformation, title: "Şifre Değişikliği", icon: "lock")
                        if personVM.showPasswordInformation{
                            PasswordInformation()
                        }
                        
                        DropDown(isActive: $personVM.showFaqInformation, title: "Sık Sorulan Sorular", icon: "questionmark")
                            .fullScreenCover(isPresented: $personVM.showFaqInformation, onDismiss: {}) {
                                FaqInformation()
                            }
                        DropDown(isActive: $personVM.showPrivacyInformation, title: "Gizlilik Politikası", icon: "doc.text")
                            .fullScreenCover(isPresented: $personVM.showPrivacyInformation, onDismiss: {}) {
                                PrivacyInformation()
                            }
                    }
                    VStack{
                        DropDown(isActive: $personVM.showAboutUsInformation, title: "Hakkımızda", icon: "person.3")
                            .fullScreenCover(isPresented: $personVM.showAboutUsInformation, onDismiss: {}) {
                                AboutUsInformation()
                            }
                        DropDown(isActive: $personVM.showHelpdesk, title: "Yardım Masası", icon: "headphones")
                        if personVM.showHelpdesk{
                            HelpdeskInformation()
                                .padding(.bottom,70)
                        }
                            
                    }
                    

                    
                    
                    

                }
                .padding(.horizontal,20)
                .padding(.vertical,20)
            }
            .navigationTitle("Profilim")
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("HomeBG").ignoresSafeArea())
        }
        
    }
    @ViewBuilder
    func DropDown(isActive: Binding<Bool>,title: String, icon: String)-> some View{
        Button {
            isActive.wrappedValue.toggle()
        } label: {
            Label {
                Text(title)
                    .font(.custom(customFont, size: 16))
                    .fontWeight(.semibold)
            } icon: {
                Image(systemName: icon)
            }
            .padding()
            .foregroundColor(Color.white)
            .frame(maxWidth:.infinity,alignment: .leading)
            .background(
                Color("Primary")
            )
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.07), radius: 5, x: 5, y: 5)
        }
    }
}

struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        PersonView()
    }
}
