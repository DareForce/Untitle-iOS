//
//  UserDataDislikeViewController.swift
//  JunctionAsia2023
//
//  Created by 지준용 on 2023/08/19.
//

import UIKit
import SnapKit


class UserDataDislikeViewController: BaseViewController {
    
    var userName: String?
    var allergyDatum: [String]?
    static var disLikeType = [Keyword]()
    var disLikeDatum = [String]()
    var count: Int?  {
        didSet {
            if count == 0 {
                skipAndSuccessButton.setTitleColor(UIColor(hexString: "#3E24FF"), for: .normal)
                skipAndSuccessButton.backgroundColor = UIColor(hexString: "#E6E2FF")
            } else {
                skipAndSuccessButton.setTitleColor(.white, for: .normal)
                skipAndSuccessButton.backgroundColor = UIColor(hexString: "#3E24FF")
            }
        }
    }
    
    let titleLabel: UILabel = {
        $0.text = "Additional Info"
        $0.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    let descriptionLabel: UILabel = {
        $0.text = "Any more ingredients you don't want?"
        $0.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    let searchButton: UIButton = {
        $0.configuration?.title = "Search"
        $0.configuration?.image = UIImage(systemName: "magnifyingglass")
        $0.configuration?.imagePlacement = .leading
        $0.configuration?.baseBackgroundColor = .systemGray6
        $0.configuration?.baseForegroundColor = .placeholderText
        $0.addTarget(self, action: #selector(moveToSearchResultViewController), for: .touchUpInside)
        return $0
    }(UIButton(configuration: .filled()))

    var disLikeCollectionView: UICollectionView!
    
    let skipAndSuccessButton: UIButton = {
        $0.setTitle("Next", for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        $0.setTitleColor(UIColor(hexString: "#3E24FF"), for: .normal)
        $0.backgroundColor = UIColor(hexString: "#E6E2FF")
        $0.layer.cornerRadius = 15
        $0.layer.masksToBounds = true
        $0.addTarget(self, action: #selector(moveToMainViewController), for: .touchUpInside)
        return $0
    }(UIButton())
    
    override func viewDidLoad() {
        setupCollectionView()
        
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        disLikeCollectionView.reloadData()
        count = UserDataDislikeViewController.disLikeType.count
    }
    
    override func layout() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }

        view.addSubview(searchButton)
        searchButton.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(30)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(36)
        }
        
        view.addSubview(skipAndSuccessButton)
        skipAndSuccessButton.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(50)
        }
        
        view.addSubview(disLikeCollectionView)
        disLikeCollectionView.snp.makeConstraints {
            $0.top.equalTo(searchButton.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.bottom.equalTo(skipAndSuccessButton.snp.top)
        }
    }
 
    func setupCollectionView() {
        disLikeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UserDataCollectionViewLayout.init())
    }
    
    @objc func moveToSearchResultViewController() {
        let searchResultViewController = SearchResultViewController()
        navigationController?.pushViewController(searchResultViewController, animated: false)
    }
    @objc func moveToMainViewController() {
        let tabBarController = TabBarController()
        tabBarController.selectedIndex = 1
        tabBarController.mainVC.allergyDatum = allergyDatum ?? []
        tabBarController.mainVC.disLikeDatum = disLikeDatum ?? []
        tabBarController.mainVC.userName = userName ?? "홍길동"
        navigationController?.navigationBar.isHidden = true
        navigationController?.pushViewController(tabBarController, animated: true)
    }
    
    override func configure() {
        navigationController?.navigationBar.topItem?.title = ""
        
        disLikeCollectionView.delegate = self
        disLikeCollectionView.dataSource = self
        disLikeCollectionView.register(DisLikeResultCell.self, forCellWithReuseIdentifier: DisLikeResultCell.identifier)
        disLikeCollectionView.showsVerticalScrollIndicator = false
        disLikeCollectionView.allowsMultipleSelection = true
    }
}

extension UserDataDislikeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UserDataDislikeViewController.disLikeType.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DisLikeResultCell.identifier, for: indexPath) as! DisLikeResultCell
        let labelText = UserDataDislikeViewController.disLikeType[indexPath.row].string
        let labelType = UserDataDislikeViewController.disLikeType[indexPath.row].type

        cell.disLikeLabel.text = labelText
        cell.configureLabel(labelType)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let labelText = UserDataDislikeViewController.disLikeType[indexPath.row].string
        disLikeDatum.append(labelText)

        return DisLikeResultCell.fittingSize(availableHeight: 45, labelText)
    }
}
