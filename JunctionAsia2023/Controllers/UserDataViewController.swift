//
//  UserDataViewController.swift
//  JunctionAsia2023
//
//  Created by 지준용 on 2023/08/19.
//

import UIKit
import SnapKit

enum KeywordType: CaseIterable {
    case previewKeyword
    
    var maskedCorners: CACornerMask {
        switch self {
        case .previewKeyword:
            return [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMinXMaxYCorner]
        default: return [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        }
    }
}

struct Keyword {
    let string: String
    let type: KeywordType
    
    init(string: String, type: KeywordType) {
        self.string = string
        self.type = type
    }
}

var mockData: [Keyword] = [
    Keyword(string: "Crustacean Shellfish", type: .previewKeyword),
    Keyword(string: "Egg", type: .previewKeyword),
    Keyword(string: "Fish", type: .previewKeyword),
    Keyword(string: "Milk", type: .previewKeyword),
    Keyword(string: "Peanut", type: .previewKeyword),
    Keyword(string: "Soy", type: .previewKeyword),
    Keyword(string: "Tree Nuts", type: .previewKeyword),
    Keyword(string: "Wheat", type: .previewKeyword),
    Keyword(string: "Cereals w/ Gluten", type: .previewKeyword),
    Keyword(string: "Sulfites", type: .previewKeyword),
    Keyword(string: "Buckwheat", type: .previewKeyword),
    Keyword(string: "Celery", type: .previewKeyword),
    Keyword(string: "Lupin", type: .previewKeyword),
    Keyword(string: "Molluscan Shellfish", type: .previewKeyword),
    Keyword(string: "Mustard", type: .previewKeyword),
    Keyword(string: "Sesame", type: .previewKeyword),
    Keyword(string: "Bee Pollen/Propolis", type: .previewKeyword),
    Keyword(string: "Beef", type: .previewKeyword),
    Keyword(string: "Chicken", type: .previewKeyword),
    Keyword(string: "Latex(Natural Rubber)", type: .previewKeyword),
    Keyword(string: "Mango", type: .previewKeyword),
    Keyword(string: "Peach", type: .previewKeyword),
    Keyword(string: "Pork", type: .previewKeyword),
    Keyword(string: "Royal Jelly", type: .previewKeyword),
    Keyword(string: "Tomato", type: .previewKeyword)
]

class UserDataViewController: BaseViewController {

    // MARK: - Property
    
    static var allergyType = mockData
    var userName: String?
    var allergyDatum = [String]() {
        didSet {
            if allergyDatum.count > 0 {
                nextButton.setTitleColor(.white, for: .normal)
                nextButton.backgroundColor = UIColor(hexString: "#3E24FF")
            } else {
                nextButton.setTitleColor(UIColor(hexString: "#3E24FF"), for: .normal)
                nextButton.backgroundColor = UIColor(hexString: "#E6E2FF")
            }
        }
    }
    
    // MARK: - View
    
    let titleLabel: UILabel = {
        $0.text = "Allergies Info"
        $0.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    let descriptionLabel: UILabel = {
        $0.text = "Please select all allergies you have"
        $0.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        $0.textColor = .secondaryLabel
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    var allergyDataCollectionView: UICollectionView!
    
    let nextButton: UIButton = {
        $0.setTitle("Next", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        $0.setTitleColor(UIColor(hexString: "#3E24FF"), for: .normal)
        $0.backgroundColor = UIColor(hexString: "#E6E2FF")
        $0.layer.cornerRadius = 15
        $0.layer.masksToBounds = true
        $0.isEnabled = false
        $0.addTarget(self, action: #selector(moveToDisLikeViewController), for: .touchUpInside)
        return $0
    }(UIButton())
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        setupCollectionView()
        
        super.viewDidLoad()
    }
    
    // MARK: - Method
    
    func setupCollectionView() {
        allergyDataCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UserDataCollectionViewLayout.init())
    }
    
    override func layout() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(16)
        }
        
        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().offset(16)
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(14)
            $0.height.equalTo(50)
        }
        
        view.addSubview(allergyDataCollectionView)
        allergyDataCollectionView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(30)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalTo(nextButton.snp.top)
        }
    }
    
    override func configure() {
        allergyDataCollectionView.delegate = self
        allergyDataCollectionView.dataSource = self
        allergyDataCollectionView.register(UserDataCell.self, forCellWithReuseIdentifier: UserDataCell.identifier)
        allergyDataCollectionView.showsVerticalScrollIndicator = false
        allergyDataCollectionView.allowsMultipleSelection = true
        
        nextButton.isEnabled = false
    }
    
    @objc func moveToDisLikeViewController() {
        let dislikeViewCongtroller = UserDataDislikeViewController()
        dislikeViewCongtroller.allergyDatum = allergyDatum
        dislikeViewCongtroller.userName = userName
        navigationController?.pushViewController(dislikeViewCongtroller, animated: true)
    }
}

extension UserDataViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UserDataViewController.allergyType.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserDataCell.identifier, for: indexPath) as! UserDataCell
        let labelText = UserDataViewController.allergyType[indexPath.row].string
        let labelType = UserDataViewController.allergyType[indexPath.row].type

        cell.allergyLabel.text = labelText
        cell.configureLabel(labelType)
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let labelText = UserDataViewController.allergyType[indexPath.row].string

        return UserDataCell.fittingSize(availableHeight: 45, labelText)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        nextButton.isEnabled = true
        allergyDatum.append(UserDataViewController.allergyType[indexPath.row].string)
    }
}

