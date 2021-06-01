//
//  CardsViewProtocols.swift
//  Concentration
//
//  Created by sriram on 01/06/21.
//

import Foundation


protocol CardsViewPresenterInput: class {
    var steps: Int { get }
    var cards: [NumberCard] { get }
    func requestForCards()
    func restart()
    func didSelectItem(indexPath: IndexPath)
}

protocol CardsViewPresenterOutput: class {
    func cardsUpdated()
    func displayCongratulation()
    func reloadItems(indexPath: [IndexPath])
}

protocol CardsViewInteractorInput: class {
    func prepareCards()
}

protocol CardsViewInteractorOutput: class {
    func dispatchCards(cards: [NumberCard])
}
