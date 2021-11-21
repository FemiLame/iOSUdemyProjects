//
//  ContentView.swift
//  I am Rich
//
//  Created by Alex Osipova on 04.08.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(.systemPink)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack {
                Text("I AM Rich!")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .padding()
                Image("diamond")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200.0, height: 200.0)
                    
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
