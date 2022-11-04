//
//  ToggleView.swift
//  ExpenseTracker
//
//  Created by HWorld on 10/19/22.
//

import SwiftUI





// MARK: custom toggle style - onColor - offColor
struct ColoredToggleStyle: ToggleStyle {
    var onColor = Color(.black)
    var offColor = Color(.black)
    var thumbColor = Color.white
    
    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            configuration.label // The text (or view) portion of the Toggle
            Spacer()
            RoundedRectangle(cornerRadius: 16, style: .circular)
                .fill(configuration.isOn ? onColor : offColor)
                .frame(width: 50, height: 29)
                .overlay(
                    Circle()
                        .fill(thumbColor)
                        .shadow(radius: 1, x: 0, y: 1)
                        .padding(1.5)
                        .offset(x: configuration.isOn ? 10 : -10))
                .animation(Animation.easeInOut(duration: 0.2))
                .onTapGesture { configuration.isOn.toggle() }
        }
        .font(.title)
        .padding(.horizontal)
    }
}

// MARK: custom toggle style - checklist style
struct ChecklistToggleStyle: ToggleStyle {
     func makeBody(configuration: Configuration) -> some View {
         Button {
             configuration.isOn.toggle()
         } label: {
             HStack {
                 Image(systemName: configuration.isOn
                         ? "checkmark.circle.fill"
                         : "circle")
                 configuration.label
             }
         }
         .tint(.primary)
         .buttonStyle(.borderless)
     }
}


//struct ToggleView_Previews: PreviewProvider {
//    static var previews: some View {
//        ToggleView()
//    }
//}
