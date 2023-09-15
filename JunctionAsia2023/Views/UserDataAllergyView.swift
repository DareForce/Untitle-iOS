//
//  UserDataAllergyView.swift
//  JunctionAsia2023
//
//  Created by 지준용 on 2023/09/15.
//

import UIKit
import SnapKit

protocol UserDataAllergyViewDelegate: AnyObject {
    func moveToDisLikeViewController()
}

final class UserDataAllergyView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: UserDataAllergyViewDelegate?
    
    let allergyType = Ingredient.AllergyFood.allCases
    var allergyDatum = [Int: String]() {
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
    
    // MARK: - Views
    
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
    
    let allergyDataCollectionView = DynamicCollectionView()
    
    private lazy var nextButton: UIButton = {
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
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func layout() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).offset(16)
        }
        
        addSubview(nextButton)
        nextButton.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(50)
        }
        
        addSubview(allergyDataCollectionView)
        allergyDataCollectionView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(30)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            $0.bottom.equalTo(nextButton.snp.top)
        }
    }
    
    // MARK: - Methods
    
    @objc func moveToDisLikeViewController() {
        delegate?.moveToDisLikeViewController()
    }
}
