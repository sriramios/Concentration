//
//  CardCollectionViewCell.swift
//  Concentration
//
//  Created by sriram on 01/06/21.
//

import Foundation
import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    @IBOutlet var cardLabel: UILabel!
    
    func updateView(_ card: NumberCard) {
        cardLabel.text = "\(card.value)"
        
        switch card.state {
        case .open,.resolved:
            contentView.backgroundColor = .cyan
            cardLabel.isHidden = false
        case .close:
            contentView.backgroundColor = .darkGray
            cardLabel.isHidden = true
        }
    }
}
