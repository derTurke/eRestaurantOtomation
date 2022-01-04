//
//  HelpdeskInformation.swift
//  eRestaurant-Tez
//
//  Created by GÜRHAN YUVARLAK on 31.12.2021.
//

import SwiftUI

struct HelpdeskInformation: View {
    @StateObject var personVM : PersonViewModel = PersonViewModel()
    @State var placeholderText : String = "Lütfen Yazınız"
    var body: some View {
        VStack{
            VStack(alignment: .leading ,spacing: 15){
                CustomTextField(title: "Konu", hint: "Lütfen yazınız", value: $personVM.subject)
                
                Text("Mesajınız")
                    .font(.custom(customFont, size: 14))
                    .foregroundColor(Color("Secondary"))
               
                TextEditor(text: $personVM.form_message)
                    .colorScheme(.light)
                    .accentColor(Color.black)
                    .padding(.top,2)
                    .font(.custom(customFont, size: 16))
                    .foregroundColor(Color.black)
                
                Divider()
                    .background(Color("Secondary"))
                
                
                Button{
                    DispatchQueue.main.async {
                        personVM.helpDeskInformation()
                    }
                } label: {
                    Text("Gönder")
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
                        SwiftUI.Alert(title: Text("eRestaurant"), message: Text(personVM.message), dismissButton: SwiftUI.Alert.Button.default(Text("Tamam"), action: {
                            DispatchQueue.main.async {
                                if personVM.clearTextField {
                                    personVM.subject = ""
                                    personVM.form_message = ""
                                }
                            }
                        }))
                        
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
    }
    func CustomTextField(title: String, hint: String, value: Binding<String>)->some View{
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.custom(customFont, size: 14))
                .foregroundColor(Color("Secondary"))
            
            
            TextField(hint, text: value)
                .colorScheme(.light)
                .padding(.top,2)
                .font(.custom(customFont, size: 16))
                .foregroundColor(Color.black)
            Divider()
                .background(Color("Secondary"))

        }
    }
}

struct HelpdeskInformation_Previews: PreviewProvider {
    static var previews: some View {
        HelpdeskInformation()
    }
}
