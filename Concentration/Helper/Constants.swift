//
//  Constants.swift
//  Concentration
//
//  Created by sriram on 01/06/21.
//

import Foundation
import UIKit

enum GameState: Equatable {
    case idle
    case oneCard(indexPath: IndexPath)
    case twoCard(firstIndexPath: IndexPath, secondIndexPath: IndexPath)
}

enum CardState {
    case open
    case close
    case resolved
}

struct Constants {
    struct CellIdentifiers {
        static let cardCell = "CardCollectionViewCell"
    }
    
    struct FlowLayout {
        static let minimumLineSpacing: CGFloat = 3
        static let numberOfColumn: Int = 3
        static let minimumInterItemSpacing: CGFloat = 1.0
        static let collectionViewVerticalPadding: CGFloat = 50.0
        static let collectionViewHorizontalPadding: CGFloat = 10.0
    }
    
    struct CardsConfig {
        static let numberOfpairs: Int = 6
    }
    
    struct ButtonTitle {
        static let restart: String = "Restart"
        static let ok: String = "Okay"
    }
    
    struct Alert {
        static let congratsTitle = "Congratulation!"
    }
}
