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
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    
    // outlet collection
    // array of UIButtons
    @IBOutlet private var cardButtons: [UIButton]!
    
    // lazy doesnt actually initialize until some one tries to use game
    // lazy cannot have property observer (the didSet)
    private lazy var game = ConcentrationModel(numberOfPairsOfCards: 2)
    
    // not settable
    var numberOfPairsOfCards: Int {
        // if you have a read only property (get only), you don't need the word get
        // if you also have a set you can't do that
        get {
            return (cardButtons.count + 1) / 2
        }
    }

    private var emoji = Dictionary<Card, String>()
    private var emojiChoices = String()
    
//    var flipCount: Int = 0 {
//        didSet {
//            // property observer
//            // keep UI in sync with instance variables of our class
//            flipCountLabel.text = "Flips: \(flipCount)"
//        }
//    }
    
    override func viewDidLoad() {
        newGame()
    }

    @IBAction func touchCard(_ sender: UIButton) {
        print("touched!")
        if let cardNumber = cardButtons.index(of: sender) {
            print(cardNumber)
            game.chooseCard(at: cardNumber)
            game.flipCount += 1
            updateViewFromModel()
        }
        else {
            print("chosen card was not in cardButtons")
        }
    }
    
    private func updateViewFromModel() {
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
        let attributes: [NSAttributedStringKey : Any] = [
            .strokeWidth : 5.0,
            .strokeColor : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)

        ]
        let attributedString = NSAttributedString(string: "Flips: \(game.flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
        scoreLabel.text = "Score: \(game.score)"
    }

    
    private func emoji(for card: Card) -> String {
        
        // swift never does any automatic type conversion
        // use type initializers
        if emoji[card] == nil {
            if emojiChoices.count > 0 {
                let randomIndex = emojiChoices.count.arc4random
                // remove(at:) returns the thing it removes
                let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: randomIndex)
                emoji[card] = String(emojiChoices.remove(at: randomStringIndex)) // becaues returns Character
            }
            
        }
//        if emoji[card.identifier] != nil {
//            return emoji[card.identifier]!
//        }
//
//        return "?"
        
        // return emoji[card.identifier] if not nil, otherwise return "?"
        return emoji[card] ?? "?"
    }
    
    private func newGame() {
        emojiChoices = Theme.getTheme()
        emoji = Dictionary<Card, String>()
        game = ConcentrationModel(numberOfPairsOfCards: numberOfPairsOfCards)
        
        updateViewFromModel()
        
    }
    
    @IBAction func newGamePressed(_ sender: UIButton) {
        newGame()
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        }
        else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }
        else {
            return 0
        }
    }
}

