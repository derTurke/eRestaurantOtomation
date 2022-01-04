//
//  PersonModel.swift
//  eRestaurant-Tez
//
//  Created by GÜRHAN YUVARLAK on 30.12.2021.
//

import SwiftUI

struct PersonelModel : Codable {
    let name : String
    let email : String
    let birthdate : String?
    let sex : String?
}

struct AddressModel: Decodable {
    let id : Int
    let header : String
    let address : String
    let building_no : String
    let floor : String?
    let apartment_no : String?
    let specification : String?
    let phone : String
}

struct FaqModel: Codable {
    let id : Int
    let question : String
    let answer : String
}

struct AboutUsModel : Codable {
    let company_name : String?
    let brand_name : String?
    let sicil_no : String?
    let vergi_no : String?
    let vergi_dairesi : String?
    let mersis_no : String?
    let address : String?
    let phone : String?
    let fax : String?
    let email : String?
    let facebook : String?
    let twitter : String?
    let instagram : String?
    let linkedin : String?
}
