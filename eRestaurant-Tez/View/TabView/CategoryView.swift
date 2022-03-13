//
//  CategoryView.swift
//  eRestaurant-Tez
//
//  Created by GÜRHAN YUVARLAK on 7.01.2022.
//

import SwiftUI

struct CategoryView: View {
    @StateObject var categoryVM : CategoryViewModel = CategoryViewModel()
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading){
                    HStack{
                        Text("Menü")
                            .font(.custom(customFont, size: 28).bold())
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(Color.black)
                    }
                    VStack{
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 160))]) {
                            ForEach(categoryVM.categories, id: \.id){ category in
                                CategoryCard(category: category)
                            }
                        }
                    }
                    .padding(.bottom,70)
                }
                .padding(.horizontal,20)
                .padding(.vertical,20)
            }
            
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white.ignoresSafeArea())
            .onAppear{
                DispatchQueue.main.async {
                    categoryVM.GetCategory()
                }
            }
        }
        
        
    }
    @ViewBuilder
    func CategoryCard(category: CategoryModel)-> some View{
        VStack{
            NavigationLink{
                CategoryDetail(categoryId: category.id, categoryName: category.name, categoryImage: category.image)
                    .navigationBarHidden(true)
            } label: {
                CategoryImage(url: category.image)
                    .aspectRatio(contentMode: .fill)
                    .overlay(
                        Text(category.name)
                            .font(.custom(customFont, size: 18))
                            .fontWeight(.semibold)
                            .foregroundColor(Color.white)
                            .shadow(color: .black, radius: 3, x: 0, y: 0)
                            .frame(maxWidth:136)
                            .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .bottom)
                            .padding()
                    )
            }
        }
        .frame(width: 160, height: 217, alignment: .top)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 10)
        
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
