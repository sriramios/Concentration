//
//  CardsViewController.swift
//  Concentration
//
//  Created by sriram on 01/06/21.
//

import UIKit




class CardsViewController: UIViewController {
    //Properties
    var presenter: CardsViewPresenterInput?
    var actionInProgress: Bool = false
    
    //outlets
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var stepsLabel: UILabel!
    
    static var instantiate: CardsViewController {
        return AppStoryboard.main.instantiate(viewControllerClass: self)
    }
    
    var collectionViewDataSource: CardsCollectionViewDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewDataSource = CardsCollectionViewDataSource()
        collectionView.dataSource = collectionViewDataSource
        collectionView.delegate = self
        createFlowLayout()
        addRestartButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateStepsLabel()
        presenter?.requestForCards()
    }
    
    func addRestartButton() {
        let restartBarButtonItem = UIBarButtonItem(title: Constants.ButtonTitle.restart, style: .done, target: self, action: #selector(restartGame))
        self.navigationItem.rightBarButtonItem  = restartBarButtonItem
    }
    
    @objc func restartGame()  {
        presenter?.restart()
    }
    
    func updateStepsLabel() {
        stepsLabel.text = "Steps: \(presenter!.steps)"
    }
    
    func createFlowLayout()  {
        let availableWidth = view.bounds.size.width
        let columns = CGFloat(Constants.FlowLayout.numberOfColumn)
        let cellWidth = floor((availableWidth - Constants.FlowLayout.collectionViewHorizontalPadding) / columns)
        
        let availableHeight = navigationController!.view.safeAreaLayoutGuide.layoutFrame.height - (Constants.FlowLayout.collectionViewVerticalPadding + stepsLabel.frame.size.height)
        let numberOfRows = CGFloat(CGFloat(Constants.CardsConfig.numberOfpairs * 2) / columns)
        let cellHeight = (availableHeight - (numberOfRows * Constants.FlowLayout.minimumLineSpacing)) / numberOfRows
        let cellSize = CGSize(width: cellWidth, height: cellHeight)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        layout.minimumLineSpacing = Constants.FlowLayout.minimumLineSpacing
        layout.minimumInteritemSpacing = Constants.FlowLayout.minimumInterItemSpacing
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
}

extension CardsViewController: CardsViewPresenterOutput {
    func displayCongratulation() {
        let alert = UIAlertController(title: Constants.Alert.congratsTitle, message: "Yeah! you have done it in \(presenter!.steps) steps", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.ButtonTitle.ok, style: .default, handler: { (_) in
            self.restartGame()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func cardsUpdated() {
        collectionViewDataSource?.items = presenter!.cards
        collectionView.reloadData()
        updateStepsLabel()
    }
    
    func reloadItems(indexPath: [IndexPath]) {
        collectionView.reloadItems(at: indexPath)
    }
}

extension CardsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectItem(indexPath: indexPath)
    }
}
