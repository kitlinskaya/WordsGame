//
//  WordsGameApp.swift
//  WordsGame
//
//  Created by Macbook on 16.05.2023.
//

import SwiftUI
let screen = UIScreen.main.bounds

@main
struct WordsGameApp: App {
    
    var body: some Scene {
        WindowGroup {
            StartView() //главная вьюха которая вызывается при старте приложения
        }
    }
}
