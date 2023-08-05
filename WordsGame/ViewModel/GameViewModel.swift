//
//  GameNewModel.swift
//  WordsGame
//
//  Created by Macbook on 18.05.2023.
//

import Foundation

enum WordError: Error {
    case theSameWord
    case beforeWord
    case littleWord
    case wrongWord
    case underfinedError
}

class GameViewModel: ObservableObject { // чтобы добавить реактивноьго прогроммирорвания подписываем под протокол ObservableObject
    @Published var player1: Player
    @Published var player2: Player
    @Published var words = [String]()
    
    let word: String
    var isFirst = true //какой игрок ходит первый
    
    init(player1: Player, player2: Player, word: String){
        self.player1 = player1
        self.player2 = player2
        self.word = word.uppercased() //приводим к верхнему регистру
    }
    //Разрабатываем бизнес логику(что должно происзодить)
//Во - первых слово должно провализироваться: Должно не быть главным словом, не состоять в массиве использованных слов, не быть меньше 2х букв
    
    func validate(word: String) throws {
        //True если валид пройдена, false - если нет
        let word = word.uppercased() //слово котрое вводит игрок так же приводим к верхнему регистру
        guard word != self.word else {
            print("Думаешь самый умный? Составленное слово не должно быть исходным ")
            throw WordError.theSameWord
        }
        
        guard !(words.contains(word)) else {
            print("Данное слово было составлено ранее")
            throw WordError.beforeWord
        }
        guard word.count > 1 else {
            print("Слово не может состять из одной буквы")
            throw WordError.littleWord
        }
        return
    }
    //напишем метод который может переводить строку в массив символов
    func wordToChars(word: String)->[Character] {
        var chars = [Character]()
        for char in word.uppercased() {
            chars.append(char)
        }
        return chars
    }
    
    //напишем метод проверки слова
    func check(word: String) throws -> Int { //int -  количсетво символов в составленном слове
        do{
            try self.validate(word: word)// проверка что слово прошло валидацию
            } catch {
                throw error
            }
        
            
        var bigWordArray = wordToChars(word: self.word) //Создаем два массива символов-большого слова и слова, который написал игрок
        let smallWordArray = wordToChars(word: word) //Надо проверить все ли символы, которые в слове игрока есть в большом слове
        var result = "" //будет собирать слово обратно
        
        for char in smallWordArray{
            if bigWordArray.contains(char){
                result.append(char)
                var i = 0
                while bigWordArray[i] != char {
                    i += 1
                }
                bigWordArray.remove(at: i) //удаляем символ который уже был использлван
                
            } else {
                throw WordError.wrongWord
            }
        }
        guard result == word.uppercased() else {
            print("Неизвестная ошибка")
            return 0
        }
        
        words.append(result)
        if isFirst {
            player1.add(score: result.count)
        } else {
            player2.add(score: result.count)
        }
        //Теперь надо передать ход другому игроку, поэтому меняем isFirst на false
        isFirst.toggle() //переключаем игрока toddle
        
        return result.count
    }
}
