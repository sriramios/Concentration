//
//  CardsViewPresenter.swift
//  Concentration
//
//  Created by sriram on 01/06/21.
//

import Foundation

typealias NumberCard = Card<Int>


class CardsViewPresenter {
    
    //Properties
    var interactor: CardsViewInteractorInput?
    var router: CardsViewRouter?
    var currentCards: [NumberCard] = [NumberCard]()
    var timer: Timer?
    var status: GameState = .idle
    var currentSteps: Int = 0
    
    weak var view: CardsViewPresenterOutput?
    
    func resetTimer() {
        closeCards()
        timer?.invalidate()
        timer = nil
    }
    
    func startTimer() {
        timer?.invalidate()
        timer = nil
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(closeCards) , userInfo: nil, repeats: false)
    }
    
    @objc func closeCards() {
        switch status {
        case let .oneCard(indexPath):
            cards[indexPath.row].state = .close
            view?.reloadItems(indexPath: [indexPath])
        case  let .twoCard(firstIndexPath, secondIndexPath):
            cards[firstIndexPath.row].state = .close
            cards[secondIndexPath.row].state = .close
            view?.reloadItems(indexPath: [firstIndexPath,secondIndexPath])
        default:
            break
        }
        status = .idle
    }
    
    func checkAllCards() {
        let unresolvedCards = self.currentCards.filter { (card) -> Bool in
            return card.state != .resolved
        }
        if unresolvedCards.count == 0 {
            view?.displayCongratulation()
            status = .idle
        }
    }
    
}

extension CardsViewPresenter: CardsViewPresenterInput {
    var cards: [NumberCard] {
        return currentCards
    }
    
    var steps: Int {
        return currentSteps
    }
    
    func requestForCards() {
        interactor?.prepareCards()
    }
    
    func restart() {
        status = .idle
        currentSteps = 0
        currentCards = [NumberCard]()
        interactor?.prepareCards()
    }
    
    func didSelectItem(indexPath: IndexPath)  {
        if cards[indexPath.row].state == .resolved, timer != nil { return }
        currentSteps = currentSteps + 1
        switch status {
        case .idle:
            cards[indexPath.row].state = .open
            status = .oneCard(indexPath: indexPath)
        case let .oneCard(previousIndexpath):
            if previousIndexpath == indexPath { // same index check
                cards[previousIndexpath.row].state = .close
                status = .idle
                view?.reloadItems(indexPath: [previousIndexpath])
                return
            }
            
            if cards[previousIndexpath.row].value == cards[indexPath.row].value { // check for value matches
                cards[previousIndexpath.row].state = .resolved
                cards[indexPath.row].state = .resolved
                status = .idle
            } else { // not matched so starting timer to close tile
                cards[previousIndexpath.row].state = .open
                cards[indexPath.row].state = .open
                status = .twoCard(firstIndexPath: previousIndexpath, secondIndexPath: indexPath)
                startTimer()
            }
            
        case let .twoCard(firstIndexPath, secondIndexPath): // to reset the state of two cards
            cards[firstIndexPath.row].state = .close
            cards[secondIndexPath.row].state = .close
            resetTimer()
            status = .oneCard(indexPath: indexPath)
        }
        
        if currentSteps >= cards.count {
            checkAllCards()
        }
        view?.cardsUpdated()
    }
}

extension CardsViewPresenter: CardsViewInteractorOutput {
    func dispatchCards(cards: [NumberCard]) {
        self.currentCards = cards
        view?.cardsUpdated()
    }
}
