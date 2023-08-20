//
//  UserDataCell.swift
//  JunctionAsia2023
//
//  Created by 지준용 on 2023/08/19.
//

import UIKit
import SnapKit


// MARK: - Enum

enum Size {
    static let keywordLabelHeight: CGFloat = 44
    static let keywordLabelXInset: CGFloat = 10
}

class UserDataCell: UICollectionViewCell {
    
    // MARK: - Property
    
    static let identifier = "userDataCell"
    lazy var keywordType: KeywordType = .previewKeyword
    override var isSelected: Bool {
        didSet {
            if isSelected {
                allergyLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
                allergyLabel.textColor = .white
                allergyLabel.backgroundColor = UIColor(hexString: "#3E24FF")
            } else {
                allergyLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                allergyLabel.textColor = .black
                allergyLabel.backgroundColor = .systemGray5
            }
        }
    }

    // MARK: - View
    
    let allergyLabel = UILabel()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method

    func layout() {
        contentView.addSubview(allergyLabel)
        allergyLabel.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
            $0.edges.equalToSuperview().inset(27)
        }
    }

    func configureText(_ allergy: String) {
        allergyLabel.text = allergy
    }
    
    func configureLabel(_ type: KeywordType) {
        allergyLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        allergyLabel.textColor = .black
        allergyLabel.backgroundColor = .systemGray5
        allergyLabel.textAlignment = .center
        allergyLabel.layer.cornerRadius = Size.keywordLabelHeight / 2
        allergyLabel.layer.masksToBounds = true
        allergyLabel.layer.maskedCorners = type.maskedCorners
    }
    
    static func fittingSize(availableHeight: CGFloat, _ allergyType: String) -> CGSize {
        let cell = UserDataCell()
        cell.configureText(allergyType)
        let targetSize = CGSize(width: UIView.layoutFittingCompressedSize.width, height: availableHeight)
        return cell.contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .fittingSizeLevel, verticalFittingPriority: .required)
    }
}
