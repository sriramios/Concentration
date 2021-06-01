//
//  CardsRouter.swift
//  Concentration
//
//  Created by sriram on 01/06/21.
//

import Foundation

class CardsViewRouter {
    static func createModule() -> CardsViewController {
        let viewController = CardsViewController.instantiate
        let presenter = CardsViewPresenter()
        viewController.presenter = presenter
        presenter.view = viewController
        let interactor = CardsViewInteractor(presenter)
        presenter.interactor = interactor
        
        return viewController
    }    
}
