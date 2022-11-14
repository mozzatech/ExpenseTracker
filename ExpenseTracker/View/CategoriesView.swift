//
//  CategoriesView.swift
//  ExpenseTracker
//
//  Created by HWorld on 11/6/22.
//

import SwiftUI
import SwiftUIFontIcon

struct CategoriesView: View {    
    let categories: [Category]
    var body: some View {
        CategoryBlock(category: categories[0])
    }
}

struct CategoryBlock: View {
    let category: Category
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .frame(width: 95, height: 95)
            .foregroundColor(Color.primary)
            //.strokeBorder(.blue, lineWidth: category == value ? 2 : 0)
            .overlay {
                VStack{
                    FontIcon.text(.awesome5Solid(code: category.icon), fontsize: 45, color: Color.icon)
                    Text(category.name).foregroundColor(Color.text).font(.callout)
                }
            }
    }
}



struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CategoriesView(categories: categoryPreviewData)
            CategoriesView(categories: categoryPreviewData)
                .preferredColorScheme(.dark)
        }
    }
}
