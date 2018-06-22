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
    
    let emojis: Array<String> = ["🍉", "🥝", "🍉", "🥝"]
    
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
            flipCard(withEmoji: emojis[cardNumber] , on: sender)
        }
        else {
            print("chosen card was not in cardButtons")
        }
    }
    
    func flipCard(withEmoji emoji: String, on button: UIButton) {
        flipCount += 1
        
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControlState.normal)
            button.backgroundColor = UIColor.orange
        }
        else {
            button.setTitle(emoji, for: UIControlState.normal)
            button.backgroundColor = UIColor.lightGray
        }
    }
}

