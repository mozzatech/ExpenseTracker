//
//  SettingsView.swift
//  ExpenseTracker
//
//  Created by HWorld on 10/23/22.
//

import SwiftUI

struct SettingsView: View {
    
    @State var comment = ""
    @State var evaluation: Int = 1
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    RatingView(rating: $evaluation)
                    TextEditor(text: $comment)
                    Button("Send Feedback") {
                        //send an email with feedback
                    }
                }
                header: {
                   Text("Write a review")
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(comment: "All good", evaluation: 4)
    }
}
