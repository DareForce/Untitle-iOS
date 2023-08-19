//
//  MainViewController.swift
//  JunctionAsia2023
//
//  Created by 최지철 on 2023/08/19.
//

import UIKit

class MainViewController: BaseViewController {
    private let mainView: MainView = MainView(frame: .zero)
    override func layout(){
        mainView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(0)
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }
    override func configure() {
        self.view.addSubview(mainView)
        self.mainView.AdditionalCollectionView.delegate = self
        self.mainView.AllergiesCollectionView.delegate = self
        self.mainView.AdditionalCollectionView.dataSource = self
        self.mainView.AllergiesCollectionView.dataSource = self
    }
}
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllergiesCollectionViewCell.identifier, for: indexPath) as! AllergiesCollectionViewCell
        return cell
    }
    
}
