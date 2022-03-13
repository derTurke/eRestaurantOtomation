//
//  CategoryList.swift
//  eRestaurant-Tez
//
//  Created by GÜRHAN YUVARLAK on 7.01.2022.
//

import SwiftUI

struct CategoryList: View {
    var categories : [CategoryModel]
    var body: some View {
        VStack{
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 160),spacing: 15)], spacing: 15) {
                ForEach(categories){ category in
                    CategoryCard(category: category)
                }
            }
            .padding(.top)
        }
        .padding(.horizontal)
    }
}
