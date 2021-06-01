//
//  CardsCollectionView.swift
//  Concentration
//
//  Created by sriram on 01/06/21.
//

import Foundation
import UIKit




class CardsCollectionViewDataSource: NSObject {
    var items: [Card] = [NumberCard]()
}

extension CardsCollectionViewDataSource: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (items.count % 2 != 0) {
            fatalError("cannot odd count")
        }
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifiers.cardCell , for: indexPath) as! CardCollectionViewCell
        cell.updateView(items[indexPath.row])
        return cell
    }
}

