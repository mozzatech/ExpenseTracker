//
//  CategoriesView.swift
//  ExpenseTracker
//
//  Created by HWorld on 11/6/22.
//

import SwiftUI
import SwiftUIFontIcon

struct CategoriesView: View {
    let category: Category
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .frame(width: 95, height: 95)
            .foregroundColor(Color.primary)
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
            CategoriesView(category: categoryPreviewData)
            CategoriesView(category: categoryPreviewData)
                .preferredColorScheme(.dark)
        }
    }
}
