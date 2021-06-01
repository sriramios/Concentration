//
//  Card.swift
//  Concentration
//
//  Created by sriram on 01/06/21.
//

import Foundation


class Card<T: Equatable>: NSObject {
    var value: T
    var state: CardState
    
    init(_ value: T) {
        self.value = value
        self.state = .close
    }
}

extension Card where T == Int {
    static func createRandomNumberPairsOfCards() -> [NumberCard] {
        
        //Generating random value pairs
        var randomNumberSet = Set<Int>()
        while randomNumberSet.count != Constants.CardsConfig.numberOfpairs {
            randomNumberSet.insert(Int.random(in: 1...100))
        }
        
        var valuePairs: [Int] = Array()
        valuePairs.append(contentsOf: randomNumberSet)
        valuePairs.append(contentsOf: randomNumberSet)
        valuePairs.shuffle()
        
        let cards = valuePairs.map { (value) -> NumberCard in
            return Card(value)
        }
        return cards
    }
}

