//
//  TitleText.swift
//  WordsGame
//
//  Created by Macbook on 16.05.2023.
//

import SwiftUI

struct TitleText: View {
    @State var text: String
    var body: some View {
        Text(text) //элемент интерфейса
            .padding()//модификатор - мутирующий метод(убирает границы)
            .font(.custom("AvenirNext-Bold", size: 42))
            .cornerRadius(16)
            .frame(maxWidth: .infinity)
            .background(Color("FirstPlayer"))
            .foregroundColor(.white)
    }
}

struct TitleText_Previews: PreviewProvider {
    static var previews: some View {
        TitleText(text: "Магнитотерапия")
    }
}
