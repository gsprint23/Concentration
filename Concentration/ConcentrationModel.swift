//
//  ConcentrationModel.swift
//  Concentration
//
//  Created by Gina Sprint on 6/21/18.
//  Copyright © 2018 Gina Sprint. All rights reserved.
//

import Foundation

struct ConcentrationModel {
    
    private(set) var cards = Array<Card>() // initialize to empty array
    // var cards = [Card]()
    
    // swift knows this has set so it is mutatable (also it is a var, not a let)
    // only have to put mutatable on funcs in a struct
    // structs are value types, don't live in the heap, as it is passed around it gets copied (only copies when you mutate it, copy on write semantics)
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            let faceUpCardIndices = cards.indices.filter {
                // boolean function
                cards[$0].isFaceUp
            }
            return faceUpCardIndices.oneAndOnly
        }
        set(newValue) {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
        
    }
    
    var flipCount = 0
    var score = 0
    
    // classes get free init as long as all properties are initialized
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(numberOfPairsOfCards: \(index)): must have at least one number of pairs of cards")
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
        
        flipCount = 0
        score = 0
        
    }
    
    mutating func shuffleCards() {
        var shuffledArray = [Card]()
        repeat {
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            shuffledArray.append(cards.remove(at: randomIndex))
        } while cards.count > 0
        cards = shuffledArray
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards array")
        //cards[index].isFaceUp = !cards[index].isFaceUp
        if !cards[index].matched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].matched = true
                    cards[index].matched = true
                    // 2 points for every match
                    score += 2
                }
                else {
                    // mismatch
                    if cards[matchIndex].flippedBefore {
                        score -= 1
                    }
                    if cards[index].flippedBefore {
                        score -= 1
                    }
                    cards[index].flippedBefore = true
                    cards[matchIndex].flippedBefore = true
                }
                cards[index].isFaceUp = true
            }
            else {
                // either no cards or 2 cards are face up
                // turn all cards face down
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
}

// extending a protocol
extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
