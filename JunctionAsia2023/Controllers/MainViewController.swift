//
//  MainViewController.swift
//  JunctionAsia2023
//
//  Created by 최지철 on 2023/08/19.
//

import UIKit

class MainViewController: BaseViewController {
    var allergyDatum =  [String]()
    var disLikeDatum = [Keyword]()
    var userName = "홍길동"
    private let mainView: MainView = MainView(frame: UIScreen.main.bounds)
    
    override func loadView() {
        view = mainView
    }
    
    override func configure() {
        self.mainView.AdditionalCollectionView.delegate = self
        self.mainView.AllergiesCollectionView.delegate = self
        self.mainView.AdditionalCollectionView.dataSource = self
        self.mainView.AllergiesCollectionView.dataSource = self
        self.mainView.purpleNameLabel.text = userName
        
        navigationController?.navigationBar.isHidden = true
    }
}
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mainView.AllergiesCollectionView {
            return allergyDatum.count
        } else {
            return disLikeDatum.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllergiesCollectionViewCell.identifier, for: indexPath) as! AllergiesCollectionViewCell

        if collectionView == mainView.AllergiesCollectionView {
            cell.cellLabel.text = allergyDatum[indexPath.row]
            return cell
        } else {
            cell.cellLabel.text = disLikeDatum[indexPath.row].string
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllergiesCollectionViewCell.identifier, for: indexPath) as! AllergiesCollectionViewCell

        if collectionView == mainView.AllergiesCollectionView {
            cell.cellLabel.text = allergyDatum[indexPath.row]
        } else {
            cell.cellLabel.text = disLikeDatum[indexPath.row].description
        }
        let width = cell.cellLabel.intrinsicContentSize.width + 40
        return CGSize(width: width, height: 40)
    }
}
