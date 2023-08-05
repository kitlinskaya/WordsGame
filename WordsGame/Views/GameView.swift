//
//  GameView.swift
//  WordsGame
//
//  Created by Macbook on 17.05.2023.
//control + I - выровнять табуляцию

import SwiftUI

struct GameView: View {
    @State private var word = ""
    var viewModel: GameViewModel
    @State private var confirmPresent = false
    @State private var isAlertPresented = false
    @State var alertText = ""
    
    @Environment(\.dismiss) var dismiss //окружение dismiss - закрыть свой экран
    
    var body: some View {
        VStack(spacing: 16) {
            
            HStack {
                Button { //элемент справа
                    //написать код который закрывает наш экран
                    confirmPresent.toggle()
                } label: {
                    Text ("Выход")
                        .padding(6)
                        .padding(.horizontal)
                        .background(Color("Orange"))
                        .cornerRadius(12)
                        .padding(6)
                        .foregroundColor(.white)
                        .font(.custom("AvenirNext-Bold", size: 18))
                    
                }
                Spacer() //элемент слева()
            }
            Text(viewModel.word) //наше большое слово
                .font(.custom("AvenirNext-Bold", size: 30))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .background(Color("Orange"))
            
            HStack(spacing: 12){
                VStack{
                    Text("\(viewModel.player1.score)") //счет первого игрока подгружаем из вьюмодели
                        .font(.custom("AvenirNext-Bold", size: 60))
                        .foregroundColor(.white)
                    Text("\(viewModel.player1.name)")
                        .font(.custom("AvenirNext-Bold", size: 24))
                        .foregroundColor(.white)
                }.padding(20)
                    .frame(width: screen.width/2.2, height: screen.width / 2.2)
                    .background(Color("FirstPlayer"))
                    .cornerRadius(24)
                    .shadow(color: viewModel.isFirst ? .red : .clear, radius: 4)
                
                VStack{
                    Text("\(viewModel.player2.score)")//счет второго игрока подгружаем из вьюмодели
                        .font(.custom("AvenirNext-Bold", size: 60))
                        .foregroundColor(.white)
                    Text("\(viewModel.player2.name)")
                        .font(.custom("AvenirNext-Bold", size: 24))
                        .foregroundColor(.white)
                }.padding(20)
                    .frame(width: screen.width/2.2, height: screen.width / 2.2)
                    .background(Color("SecondPlayer"))
                    .cornerRadius(24)
                    .shadow(color: !viewModel.isFirst ? .mint : .clear, radius: 4)
            }
            WordsTextView(word: $word, placeHolder: "Введите ваше слово")
                .padding(.horizontal)
            
            Button {
                var score = 0
                
                do{ try score = viewModel.check(word: word)
                    
                } catch WordError.beforeWord {
                    alertText = "Данное слово уже было составлено"
                    isAlertPresented.toggle()
                } catch WordError.theSameWord {
                    alertText = "Составленное слово не должно совпадать с исходным "
                    isAlertPresented.toggle()
                } catch WordError.littleWord {
                    alertText = "Слишком короткое слово"
                    isAlertPresented.toggle()
                } catch WordError.wrongWord {
                    alertText = "Такое слово не может быть составлено"
                    isAlertPresented.toggle()
                } catch {
                    alertText = "Неизвестная ошибка"
                    isAlertPresented.toggle()
                }
                
                
                if score > 1 {
                    self.word = ""
                }
                
            } label: {
                Text("Готово!")
                    .padding(12)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .background(Color("Orange"))
                    .cornerRadius(12)
                    .font(.custom("AvenirNext-Bold", size: 26))
                    .padding(.horizontal)
            }
            
            List {
                ForEach(0 ..< self.viewModel.words.count, id: \.description) { item in
                    WordCell(word: self.viewModel.words[item])
                        .background(item % 2 == 0 ? Color("FirstPlayer") : Color("SecondPlayer"))
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(item % 2 == 0 ? Color("FirstPlayer") : Color("SecondPlayer"))
                }
                .background(Color.clear)
            }.listStyle(PlainListStyle())
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }.background(Image("background"))
            .confirmationDialog("Вы уверены, что хотите завершить игру", isPresented: $confirmPresent,titleVisibility: .visible) {
                Button(role:.destructive) {
                    self.dismiss()
                } label: {
                    Text("Да")
                }
                Button(role:.cancel) { } label: {
                    Text("Нет")
                }
            }
            .alert(alertText, isPresented: $isAlertPresented) {
                Text("OK")
            }
    }
    
}


struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel(player1: Player(name: "Diana"), player2: Player(name: "Miha"), word: "Рекогносцировка"))//инициализируем GameView чтобы показать его на экране(для превью)
    }
}
