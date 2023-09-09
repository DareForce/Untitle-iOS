//
//  UserDataDislikeViewController.swift
//  JunctionAsia2023
//
//  Created by 지준용 on 2023/08/19.
//

import UIKit
import SnapKit

final class UserDataDislikeViewController: BaseViewController {
    
    // MARK: - Property
    
    var userName: String?
    var allergyDatum = [Int: String]()
    static var dislikeType = [Keyword]()
    
    // MARK: - View
    
    private let userDataDislikeView = UserDataDislikeView(frame: UIScreen.main.bounds)
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = userDataDislikeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userDataDislikeView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        userDataDislikeView.dislikeCollectionView.reloadData()
        userDataDislikeView.disLikeType = UserDataDislikeViewController.dislikeType
    }
    
    // MARK: - Configure
    
    override func configure() {
        super.configure()

        navigationController?.navigationBar.topItem?.title = ""
    }
}

// MARK: - UserDataDislikeViewProtocol

extension UserDataDislikeViewController: UserDataDislikeViewProtocol {
    
    // MARK: Navigation
    
    @objc func moveToSearchResultViewController() {
        let searchResultViewController = SearchResultViewController()
        navigationController?.pushViewController(searchResultViewController, animated: false)
    }
    
    @objc func moveToMainViewController() {
        let tabBarController = TabBarController()
        tabBarController.selectedIndex = 1
        tabBarController.mainVC.allergyDatum = allergyDatum.sorted(by: {$0.key < $1.key}).map { $0.value }
        tabBarController.mainVC.disLikeDatum = userDataDislikeView.disLikeType
        tabBarController.mainVC.userName = userName ?? "홍길동"
        navigationController?.navigationBar.isHidden = true
        navigationController?.pushViewController(tabBarController, animated: true)
    }
    
    // MARK: Button
    
    func didTapXButton(_ sender: UILabel) {
        if let index = userDataDislikeView.disLikeType.firstIndex(where: {$0.string == sender.text} ) {
            userDataDislikeView.disLikeType.remove(at: index)
            
            userDataDislikeView.dislikeCollectionView.reloadData()
        }
    }
}
