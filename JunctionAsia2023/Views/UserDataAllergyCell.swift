//
//  UserDataAllergyCell.swift
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

final class UserDataAllergyCell: UICollectionViewCell {
    
    // MARK: - Property
    
    static let identifier = "userDataCell"
    override var isSelected: Bool {
        didSet {
            if isSelected {
                allergyLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
                allergyLabel.textColor = .white
                allergyLabel.backgroundColor = .mainBlueColor
            } else {
                allergyLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                allergyLabel.textColor = .black
                allergyLabel.backgroundColor = .systemGray5
            }
        }
    }

    // MARK: - View
    
    let allergyLabel: UILabel = {
        $0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        $0.textColor = .black
        $0.backgroundColor = .systemGray5
        $0.textAlignment = .center
        $0.layer.cornerRadius = Size.keywordLabelHeight / 2
        $0.layer.masksToBounds = true
        return $0
    }(UILabel())
    
    // MARK: - Init
    
    @available(*, unavailable)
    override init(frame: CGRect) {
        super.init(frame: frame)

        layout()
    }
    
    @available(*, unavailable)
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
    
    static func fittingSize(availableHeight: CGFloat, _ allergyType: String) -> CGSize {
        let cell = UserDataAllergyCell()
        cell.configureText(allergyType)
        
        let targetSize = CGSize(width: UIView.layoutFittingCompressedSize.width,
                                height: availableHeight)
        
        return cell.contentView.systemLayoutSizeFitting(targetSize,
                                                        withHorizontalFittingPriority: .fittingSizeLevel,
                                                        verticalFittingPriority: .required)
    }
}
