//
//  ContentView.swift
//  WordsGame
//
//  Created by Kitlinskaya on 16.05.2023.
//

import SwiftUI

struct StartView: View { //то, что мы видим на экране
    
    @State var bigWord = "" //cсвойства состояния
    @State var player1 = ""
    @State var player2 = ""
    @State var isAlertPresented = false //показывается ли предупреждение о длине
    
    @State var isShowedGame = false //показан второй экран?
    
    var body: some View { //возвращает одну вью
        
        VStack {
            
            TitleText(text: "Words Game")
            
            WordsTextView(word: $bigWord, placeHolder: "Введите длинное слово")
                .padding(20)
                .padding(.top, 32)
            WordsTextView(word: $player1, placeHolder: "Игрок 1")
                .padding(.horizontal, 20)
            WordsTextView(word: $player2, placeHolder: "Игрок 2")
                .padding(.horizontal, 20)
            
            //создадим кнопку старт
            Button {
                if bigWord.count > 7{
                    isShowedGame.toggle() //переключение
                } else {
                    self.isAlertPresented.toggle()
                }
            } label: { //view
                Text("Поехали!")
                    .font(.custom("AvenirNext-Bold", size: 30))
                    .foregroundColor(.white)
                    .padding()
                    .padding(.horizontal, 64)
                    .background(Color("FirstPlayer"))
                    .cornerRadius(100)
                    .padding(.top)
            }

        }.background(Image ("background"))
            .alert("Длинное слово слишком короткое", isPresented: $isAlertPresented, actions: {
                Text("OK")
            })
            .fullScreenCover(isPresented: $isShowedGame) {
                let name1 = player1 == "" ? "Игрок 1" : player1
                let name2 = player2 == "" ? "Игрок 2" : player2
                
                let player1 = Player(name: name1)
                let player2 = Player(name: name2)
                let gameViewModel = GameViewModel(player1: player1, player2: player2, word: bigWord)
                GameView(viewModel: gameViewModel)
            } //модификатор который отображает какю-то вью на весь экран
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
