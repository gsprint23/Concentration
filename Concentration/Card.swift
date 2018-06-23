//
//  Card.swift
//  Concentration
//
//  Created by Gina Sprint on 6/21/18.
//  Copyright © 2018 Gina Sprint. All rights reserved.
//

import Foundation

// structs and classes are mostly the same

// difference between struct and class
// 2 major
// 1. structs: no inheritance
// 2. structs: value types, classes: reference types
// value put it in array, assign to another variable, pass into function -> COPIED!
// Array, String, Int, Dictionary are structs: COPIED
// copy on right semantics: only copies values when value is going to change
// references live in the heap, not passing around the objecct -> passing around pointers


struct Card {
    var isFaceUp = false
    var matched = false
    var identifier: Int
    var flippedBefore = false
    
    static var identifierFactory = 0
    
    // static method belongs to type, not to instance
    // utility function tied to the type
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        // don't need Card. because we are in static method
        // accessing static property
        return Card.identifierFactory
    }
    
    // struct gets free init
    // which initializes all properties
    
    // inits are the one method that usually
    // has the same internal and external parameter names
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
