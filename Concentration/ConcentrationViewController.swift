//
//  ViewController.swift
//  Concentration
//
//  Created by Gina Sprint on 6/21/18.
//  Copyright © 2018 Gina Sprint. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    // ! doesn't have to be initialized
    // no error saying we need an init()
    @IBOutlet weak var flipCountLabel: UILabel!
    
    // outlet collection
    // array of UIButtons
    @IBOutlet var cardButtons: [UIButton]!
    
    // lazy doesnt actually initialize until some one tries to use game
    // lazy cannot have property observer (the didSet)
    lazy var game = ConcentrationModel(numberOfPairsOfCards: (cardButtons.count + 1) / 2)

    
    var flipCount: Int = 0 {
        didSet {
            // property observer
            // keep UI in sync with instance variables of our class
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }

    @IBAction func touchCard(_ sender: UIButton) {
        print("touched!")
        if let cardNumber = cardButtons.index(of: sender) {
            print(cardNumber)
            game.chooseCard(at: cardNumber)
            flipCount += 1
            updateViewFromModel()
        }
        else {
            print("chosen card was not in cardButtons")
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = UIColor.white
            }
            else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.matched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    var emoji = Dictionary<Int, String>()
    var emojiChoices = ["🍉", "🥝", "🍇", "🍋", "🍓", "🥥", "🍊", "🍏"]
    
    func emoji(for card: Card) -> String {
        
        // swift never does any automatic type conversion
        // use type initializers
        if emoji[card.identifier] == nil {
            if emojiChoices.count > 0 {
                let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                // remove(at:) returns the thing it removes
                emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
            }
            
        }
//        if emoji[card.identifier] != nil {
//            return emoji[card.identifier]!
//        }
//
//        return "?"
        
        // return emoji[card.identifier] if not nil, otherwise return "?"
        return emoji[card.identifier] ?? "?"
    }
    
}

