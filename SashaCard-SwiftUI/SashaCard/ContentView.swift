//
//  ContentView.swift
//  SashaCard
//
//  Created by Alex Osipova on 04.08.2021.
//

import SwiftUI

let mainColor = Color(red: 0.61, green: 0.35, blue: 0.71)
let secondColor = Color(red: 0.61, green: 0.35, blue: 0.71, opacity: 0.6)

struct ContentView: View {
    
    var body: some View {
        ZStack {
            Color(red: 0.61, green: 0.35, blue: 0.71, opacity: 0.3)
                .ignoresSafeArea()
            VStack {
                Image("me")
                    .resizable().aspectRatio(contentMode: .fit)
                    .frame(width: 200.0, height: 200.0)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .overlay(
                        Circle().stroke(secondColor, lineWidth: 3)//(mainColor, )
                    )
                Text("Aleksandra")
                    .font(Font.custom("PaletteMosaic-Regular", size: 60))
                    .foregroundColor(mainColor)
                    .bold()
                Text("iOS Developer")
                    .foregroundColor(secondColor)
                    .font(.system(size: 25))
                Divider().hidden()
                InfoView(text: "+ 7 (931) 004 35-24", imageName: "phone.fill")
                InfoView(text: "alexosipova13@gmail.com", imageName: "envelope.fill")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
