//
//  UserDataViewController.swift
//  JunctionAsia2023
//
//  Created by 지준용 on 2023/08/19.
//

import UIKit
import SnapKit

final class UserDataAllergyViewController: BaseViewController {

    // MARK: - Properties
    
    var userName: String?
    private var allergyDatum = [Int: String]() {
        didSet {
            userDataAllergyView.allergyDatum = allergyDatum
        }
    }
    
    // MARK: - Views
    
    private let userDataAllergyView = UserDataAllergyView(frame: UIScreen.main.bounds)
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = userDataAllergyView
    }
    
    // MARK: - Methods
    
    override func configure() {
        userDataAllergyView.delegate = self
        
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        userDataAllergyView.allergyDataCollectionView.delegate = self
        userDataAllergyView.allergyDataCollectionView.dataSource = self
        userDataAllergyView.allergyDataCollectionView.register(UserDataAllergyCell.self, forCellWithReuseIdentifier: UserDataAllergyCell.identifier)
    }
}

// MARK: - UserDataAllergyViewDelegate

extension UserDataAllergyViewController: UserDataAllergyViewDelegate {
    func moveToDisLikeViewController() {
        let dislikeViewCongtroller = UserDataDislikeViewController()
        dislikeViewCongtroller.allergyDatum = allergyDatum
        dislikeViewCongtroller.userName = userName
        navigationController?.pushViewController(dislikeViewCongtroller, animated: true)
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension UserDataAllergyViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userDataAllergyView.allergyType.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserDataAllergyCell.identifier, for: indexPath) as! UserDataAllergyCell
        let labelText = userDataAllergyView.allergyType[indexPath.row].description

        cell.allergyLabel.text = labelText
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let labelText = userDataAllergyView.allergyType[indexPath.row].description

        return UserDataAllergyCell.fittingSize(availableHeight: 45, labelText)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let allergyName = userDataAllergyView.allergyType[indexPath.row].description
        allergyDatum[indexPath.row] = allergyName
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        allergyDatum[indexPath.row] = nil
    }
}

