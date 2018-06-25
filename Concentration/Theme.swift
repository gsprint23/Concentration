//
//  Theme.swift
//  Concentration
//
//  Created by Gina Sprint on 6/25/18.
//  Copyright © 2018 Gina Sprint. All rights reserved.
//

import Foundation

struct Theme {
    static let themes = [
        "fruit": ["🍉", "🥝", "🍇", "🍋", "🍓", "🥥", "🍊", "🍏"],
        "animals": ["🐶", "🐱", "🐸", "🐧", "🐥", "🦄", "🦀", "🐳"],
        "sports": ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏓", "🎱"],
        "music": ["🎧", "🎼", "🥁", "🎷", "🎸", "🎻", "🎤", "🎺"],
        "vehicles": ["🚙", "🚌", "🏎", "🚓", "🚑", "🚜", "🏍", "🛵"],
        "tech": ["📱", "💻", "🕹", "💾", "💿", "📸", "🎥", "🎮"]
    ]
    
    static func getTheme() -> Array<String> {
        let themeKeys = Array(themes.keys)
        let randomIndex = themeKeys.count.arc4random
        let randomKey = themeKeys[randomIndex]
        print("Selecting theme: \(randomKey)")
        return themes[randomKey]!
    }
}
