//
//  Theme.swift
//  Concentration
//
//  Created by Gina Sprint on 6/25/18.
//  Copyright © 2018 Gina Sprint. All rights reserved.
//

import Foundation

struct Theme {
//    static let themes = [
//        "fruit": ["🍉", "🥝", "🍇", "🍋", "🍓", "🥥", "🍊", "🍏"],
//        "animals": ["🐶", "🐱", "🐸", "🐧", "🐥", "🦄", "🦀", "🐳"],
//        "sports": ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏓", "🎱"],
//        "music": ["🎧", "🎼", "🥁", "🎷", "🎸", "🎻", "🎤", "🎺"],
//        "vehicles": ["🚙", "🚌", "🏎", "🚓", "🚑", "🚜", "🏍", "🛵"],
//        "tech": ["📱", "💻", "🕹", "💾", "💿", "📸", "🎥", "🎮"]
//    ]
    
    // use String instead of Array for practice with Strings
    static let themes = [
        "Fruit": "🍉🥝🍇🍋🍓🥥🍊🍏",
        "Animals": "🐶🐱🐸🐧🐥🦄🦀🐳",
        "Sports": "⚽️🏀🏈⚾️🎾🏐🏓🎱",
        "Music": "🎧🎼🥁🎷🎸🎻🎤🎺",
        "Vehicles": "🚙🚌🏎🚓🚑🚜🏍🛵",
        "Tech": "📱💻🕹💾💿📸🎥🎮"
    ]

    
    static func getTheme() -> String {
        let themeKeys = Array(themes.keys)
        let randomIndex = themeKeys.count.arc4random
        let randomKey = themeKeys[randomIndex]
        print("Selecting theme: \(randomKey)")
        return themes[randomKey]!
    }
}
