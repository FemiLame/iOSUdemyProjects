//
//  InfoView.swift
//  SashaCard
//
//  Created by Alex Osipova on 04.08.2021.
//

import SwiftUI

struct InfoView: View {
    let text: String
    let imageName: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(mainColor)
            .frame(height: 40)
            .overlay(
                HStack {
                    Image(systemName: imageName)
                        .colorInvert()
                    
                    Text(text)
                        .foregroundColor(.white)
                }
            ).padding(.all, 2)
    }
}


struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(text: "dsfgsdfg", imageName: "phone")
            .previewLayout(.sizeThatFits)
    }
}
