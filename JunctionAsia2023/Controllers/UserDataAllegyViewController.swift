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

final class UserDataAllegyViewController: BaseViewController {

    // MARK: - Property
    
    static var allergyType = allergyComponents
    var userName: String?
    private var allergyDatum = [Int: String]() {
        didSet {
            if allergyDatum.count > 0 {
                nextButton.isEnabled = true
                nextButton.backgroundColor = .mainBlueColor
            } else {
                nextButton.isEnabled = false
                nextButton.backgroundColor = .disabledButtonColor
            }
        }
    }
    
    // MARK: - View
    
    private let titleLabel: UILabel = {
        $0.text = "Allergies Info"
        $0.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    private let descriptionLabel: UILabel = {
        $0.text = "Please select all allergies you have"
        $0.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        $0.textColor = .secondaryLabel
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    private var allergyDataCollectionView = DynamicCollectionView()
    
    private let nextButton: UIButton = {
        $0.setTitle("Next", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        $0.setTitleColor(.white, for: .normal)
        $0.setTitleColor(.mainBlueColor, for: .disabled)
        $0.backgroundColor = .disabledButtonColor
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
    
    // MARK: - Layout

    override func layout() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(50)
        }
        
        view.addSubview(allergyDataCollectionView)
        allergyDataCollectionView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(30)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.bottom.equalTo(nextButton.snp.top)
        }
    }
    
    // MARK: - Configure
    
    override func configure() {
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        allergyDataCollectionView.delegate = self
        allergyDataCollectionView.dataSource = self
        allergyDataCollectionView.register(UserDataAllergyCell.self, forCellWithReuseIdentifier: UserDataAllergyCell.identifier)
    }
    
    // MARK: - Method
    
    @objc func moveToDisLikeViewController() {
        let dislikeViewCongtroller = UserDataDislikeViewController()
        dislikeViewCongtroller.allergyDatum = allergyDatum
        dislikeViewCongtroller.userName = userName
        navigationController?.pushViewController(dislikeViewCongtroller, animated: true)
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension UserDataAllegyViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UserDataAllegyViewController.allergyType.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserDataAllergyCell.identifier, for: indexPath) as! UserDataAllergyCell
        let labelText = UserDataAllegyViewController.allergyType[indexPath.row].string
        let labelType = UserDataAllegyViewController.allergyType[indexPath.row].type

        cell.allergyLabel.text = labelText
        cell.configureLabel(labelType)
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let labelText = UserDataAllegyViewController.allergyType[indexPath.row].string

        return UserDataAllergyCell.fittingSize(availableHeight: 45, labelText)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let allergyName = UserDataAllegyViewController.allergyType[indexPath.row].string
        allergyDatum[indexPath.row] = allergyName
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        allergyDatum[indexPath.row] = nil
    }
}

