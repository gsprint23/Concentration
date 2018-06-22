//
//  ConcentrationModel.swift
//  Concentration
//
//  Created by Gina Sprint on 6/21/18.
//  Copyright © 2018 Gina Sprint. All rights reserved.
//

import Foundation

class ConcentrationModel {
    
    var cards = Array<Card>() // initialize to empty array
    // var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    // classes get free init as long as all properties are initialized
    
    init(numberOfPairsOfCards: Int) {
        // ..< ... countable ranges
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            //let matchingCard = card // matchingCard is a copy of card because structs are copied on assignment
            cards.append(card)
            //cards.append(matchingCard)
            cards.append(card) // different copy
            // total of 3 card copies
            // cards += [card, card]
        }
        
        // shuffle the cards
        shuffleCards()
        
        
        
    }
    
    func shuffleCards() {
        var shuffledArray = [Card]()
        repeat {
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            shuffledArray.append(cards.remove(at: randomIndex))
        } while cards.count > 0
        cards = shuffledArray
    }
    
    func chooseCard(at index: Int) {
        //cards[index].isFaceUp = !cards[index].isFaceUp
        if !cards[index].matched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[matchIndex].matched = true
                    cards[index].matched = true
                }
                cards[index].isFaceUp = true
                // no longer just one card face up
                indexOfOneAndOnlyFaceUpCard = nil
            }
            else {
                // either no cards or 2 cards are face up
                // turn all cards face down
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
}
