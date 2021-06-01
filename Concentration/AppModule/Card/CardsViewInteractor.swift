//
//  CardsInteractor.swift
//  Concentration
//
//  Created by sriram on 01/06/21.
//

import Foundation

class CardsViewInteractor: CardsViewInteractorInput {
    
    //Properties
    weak var output: CardsViewInteractorOutput?
    
    init(_ output: CardsViewInteractorOutput) {
        self.output = output
    }
    
    func prepareCards() {
        output?.dispatchCards(cards: Card.createRandomNumberPairsOfCards())
    }
}
