//
//  Player.swift
//  WordsGame
//
//  Created by Macbook on 18.05.2023.
//

import Foundation

struct Player {
    let name: String
    private (set) var score = 0 //чтобы можно было изменять только внутренними метожами
    
    mutating func add(score: Int) {
        self.score += score
    }
   
}

