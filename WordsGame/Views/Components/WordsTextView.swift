//
//  WordsTextView.swift
//  WordsGame
//
//  Created by Macbook on 17.05.2023.
//

import SwiftUI

struct WordsTextView: View {
    
    @State var word: Binding<String>
    var placeHolder: String
    var body: some View {
        TextField(placeHolder, text: word)//связываем бигворд
            .font(.title2)
            .padding()
            .background(.white)
            .cornerRadius(12)
    }
}

