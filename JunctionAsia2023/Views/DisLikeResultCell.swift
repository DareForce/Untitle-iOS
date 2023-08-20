//
//  DisLikeResultCell.swift
//  JunctionAsia2023
//
//  Created by 지준용 on 2023/08/19.
//

import UIKit
import SnapKit

class DisLikeResultCell: UICollectionViewCell {

    // MARK: - Property
    
    static let identifier = "disLikeResultCell"

    // MARK: - View
    
    let containerView: UIStackView = {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .equalSpacing
        $0.spacing = 3
        return $0
    }(UIStackView())
    
    let leftEmptyView = UIView()
    let rightEmptyView = UIView()
    let disLikeLabel = UILabel()
    
    let xButton: UIImageView = {
        $0.image = UIImage(systemName: "xmark")
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .white
        return $0
    }(UIImageView())
    
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
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
            $0.edges.equalToSuperview().inset(20)
        }
        containerView.addArrangedSubview(leftEmptyView)
        containerView.addArrangedSubview(disLikeLabel)
        containerView.addArrangedSubview(xButton)
        containerView.addArrangedSubview(rightEmptyView)
    }
    
    func configureText(_ disLikeText: String) {
        disLikeLabel.text = disLikeText
    }
    
    func configureLabel(_ type: KeywordType) {
        disLikeLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        disLikeLabel.textColor = .white
        disLikeLabel.textAlignment = .center
        containerView.layer.cornerRadius = Size.keywordLabelHeight / 2
        containerView.layer.masksToBounds = true
        containerView.layer.maskedCorners = type.maskedCorners
        containerView.backgroundColor = .blue
    }
    
    static func fittingSize(availableHeight: CGFloat, _ disLikeType: String) -> CGSize {
        let cell = DisLikeResultCell()
        cell.configureText(disLikeType)
        let targetSize = CGSize(width: UIView.layoutFittingCompressedSize.width, height: availableHeight)
        return cell.contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .fittingSizeLevel, verticalFittingPriority: .required)
    }

}
