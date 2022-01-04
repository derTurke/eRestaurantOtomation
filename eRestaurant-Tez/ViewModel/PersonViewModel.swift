//
//  PersonViewModel.swift
//  eRestaurant-Tez
//
//  Created by GÜRHAN YUVARLAK on 30.12.2021.
//

import SwiftUI

class PersonViewModel: ObservableObject {
    
    //Dropdown
    @Published var showOrderInformation : Bool = false
    @Published var showPersonelInformation : Bool = false
    @Published var showPasswordInformation : Bool = false
    @Published var showAddressInformation : Bool = false
    @Published var showFaqInformation : Bool = false
    @Published var showPrivacyInformation : Bool = false
    @Published var showAboutUsInformation : Bool = false
    @Published var showHelpdesk : Bool = false
    @Published var showAlert : Bool = false
    @Published var clearTextField : Bool = false
    
    
    
    // Personel Information
    @Published var name : String = ""
    @Published var email : String = ""
    @Published var birthdate : Date = Date()
    @Published var sex : String = ""
    
    @Published var password : String = ""
    @Published var showPassword : Bool = false
    @Published var newPassword : String = ""
    @Published var showNewPassword : Bool = false
    @Published var reNewPassword : String = ""
    @Published var showReNewPassword : Bool = false
    @Published var message : String = ""

    // SheetView
    @Published var showSheet : Bool = false
    
    // Address
    @Published var addresses : [AddressModel] = []
    @Published var header : String = ""
    @Published var address_info : String = ""
    @Published var building_no : String = ""
    @Published var floor : String = ""
    @Published var apartment_no : String = ""
    @Published var specification : String = ""
    @Published var phone : String = ""
    @Published var addSheet : Bool = false
    @Published var id : Int = 0

    //FAQS
    @Published var faqs : [FaqModel] = []
    
    //Privacy Information
    @Published var privacyInformation : String = ""
    
    //About Us
    @Published var company_name : String = ""
    @Published var brand_name : String = ""
    @Published var sicil_no : String = ""
    @Published var vergi_no : String = ""
    @Published var vergi_dairesi : String = ""
    @Published var mersis_no : String = ""
    @Published var address : String = ""
    @Published var aboutUs_phone : String = ""
    @Published var fax : String = ""
    @Published var aboutUs_email : String = ""
    @Published var facebook : String = ""
    @Published var twitter : String = ""
    @Published var instagram : String = ""
    @Published var linkedin : String = ""
    
    //Helpdesk Information
    @Published var subject : String = ""
    @Published var form_message : String = ""
    
    
    
    //Personel Information Functions
    func getPersonelInformation(){
        Webservice().personelInformation { result in
            switch result{
                case .success(let person):
                    DispatchQueue.main.async {
                        self.name = person.name
                        self.email = person.email
                        self.birthdate = stringToDate(tarih: person.birthdate ?? "")
                        self.sex = person.sex ?? ""
                    }
                
                case .failure(let hata):
                    print(hata)
            }
        }
    }
    func updatePersonelInformation(){
        Webservice().updatePersonelInformation(name: name, email: email, birthdate: birthdate, sex: sex) { result in
            switch result{
                case .success(let person):
                    DispatchQueue.main.async {
                        withAnimation{
                            self.showAlert = true
                            self.message = person
                        }
                    }
                
                case .failure(let hata):
                    print(hata)
            }
        }
    }
    
    func addAddress(){
        Webservice().addAddress(header: header, address: address_info, building_no: building_no, floor: floor, apartment_no: apartment_no, specification: specification, phone: phone) { result in
            switch result{
                case .success(let person):
                    DispatchQueue.main.async {
                        withAnimation{
                            if person == "success"{
                                self.showAlert = true
                                self.message = "Adresiniz başarıyla eklenmiştir."
                                self.addSheet = true
                            } else {
                                self.showAlert = true
                                self.message = person
                            }
                        }
                    }
                
                case .failure(let hata):
                    print(hata)
            }
        }
    }
    
    func getAddresses(){
        Webservice().getAddresses { result in
            switch result {
                case .success(let addresses):
                    DispatchQueue.main.async {
                        self.addresses = addresses
                    }
                case .failure(let hata):
                    print(hata)
            }
        }
    }
    
    
    func getAddress(id: Int){
        Webservice().getAddress(id: id) { result in
            switch result {
                case .success(let addresses):
                    DispatchQueue.main.async {
                        self.header = addresses.header
                        self.address_info = addresses.address
                        self.building_no = addresses.building_no
                        self.floor = addresses.floor ?? ""
                        self.apartment_no = addresses.apartment_no ?? ""
                        self.specification  = addresses.specification ?? ""
                        self.phone = addresses.phone
                    }
                case .failure(let hata):
                    print(hata)
            }
        }
    }
    func deleteAddress(id: Int){
        Webservice().deleteAddress(id: id){ result in
            switch result {
                case .success(let message):
                    DispatchQueue.main.async {
                        //self.message = message
                        self.addresses = message
                        self.showAlert = true
                    }
                case .failure(let hata):
                    print(hata)
            }
        }
    }
    
    func editAddress(id: Int){
        Webservice().editAddress(id: id, header: header, address: address_info, building_no: building_no, floor: floor, apartment_no: apartment_no, specification: specification, phone: phone) { result in
            switch result{
                case .success(let person):
                    DispatchQueue.main.async {
                        withAnimation{
                            if person == "success"{
                                self.showAlert = true
                                self.message = "Adresiniz başarıyla düzenlenmiştir."
                                self.addSheet = true
                                
                            } else {
                                self.showAlert = true
                                self.message = person
                            }
                        }
                    }
                
                case .failure(let hata):
                    print(hata)
            }
        }
    }
    
    func editPassword(){
        Webservice().editPassword(password: password, newPassword: newPassword, reNewPassword: reNewPassword) { result in
            switch result{
                case .success(let person):
                    DispatchQueue.main.async {
                        withAnimation{
                            if person == "success"{
                                self.showAlert = true
                                self.message = "Şifreniz başarıyla değiştirilmiştir. Yeni şifrenizi kullanmaya başlayabilirsiniz."
                                self.clearTextField = true
                                
                            } else {
                                self.showAlert = true
                                self.message = person
                            }
                        }
                    }
                
                case .failure(let hata):
                    print(hata)
            }
        }
    }
    
    func getFAQ(){
        Webservice().getFAQ { result in
            switch result{
                case .success(let faqs):
                    DispatchQueue.main.async {
                        withAnimation{
                            self.faqs = faqs
                        }
                    }
                case .failure(let hata):
                    print(hata)
            }
        }
    }
    
    func getPrivacyInformation(){
        Webservice().getPrivacyInformation { result in
            switch result{
                case .success(let privacyInfo):
                    DispatchQueue.main.async {
                        withAnimation{
                            self.privacyInformation = privacyInfo
                        }
                    }
                case .failure(let hata):
                    print(hata)
            }
        }
    }
    
    func getAboutUs(){
        Webservice().getAboutUs { result in
            switch result{
                case .success(let aboutUs):
                    DispatchQueue.main.async {
                        self.company_name = aboutUs.company_name ?? ""
                        self.brand_name = aboutUs.brand_name ?? ""
                        self.sicil_no = aboutUs.sicil_no ?? ""
                        self.vergi_no = aboutUs.vergi_no ?? ""
                        self.vergi_dairesi = aboutUs.vergi_dairesi ?? ""
                        self.mersis_no = aboutUs.mersis_no ?? ""
                        self.address = aboutUs.address ?? ""
                        self.aboutUs_phone = aboutUs.phone ?? ""
                        self.fax = aboutUs.fax ?? ""
                        self.aboutUs_email = aboutUs.email ?? ""
                        self.facebook = aboutUs.facebook ?? ""
                        self.twitter = aboutUs.twitter ?? ""
                        self.instagram = aboutUs.instagram ?? ""
                        self.linkedin = aboutUs.linkedin ?? ""
                    }
                case .failure(let hata):
                    print(hata)
            }
        }
    }
    
    func helpDeskInformation(){
        Webservice().helpDeskInformation(subject: subject, message: form_message) { result in
            switch result{
                case .success(let person):
                    DispatchQueue.main.async {
                        withAnimation{
                            if person == "success"{
                                self.showAlert = true
                                self.message = "Mesajınız bize ulaşmıştır. En kısa sürede cevabımızı e-posta adresinize ileteceğiz. eRestaurant ailesi olarak ilginiz için teşekkür ederiz."
                                self.clearTextField = true
                                
                            } else {
                                self.showAlert = true
                                self.message = person
                            }
                        }
                    }
                
                case .failure(let hata):
                    print(hata)
            }
        }
    }
    

}

func stringToDate(tarih: String) -> Date{
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter.date(from: tarih) ?? Date()
    
}
