//
//  DisLikeResultCell.swift
//  JunctionAsia2023
//
//  Created by 지준용 on 2023/08/19.
//

import UIKit
import SnapKit

protocol DislikeResultCellDelegate: AnyObject {
    func didTapXButton(_ sender: UILabel)
}

final class DislikeResultCell: UICollectionViewCell {

    // MARK: - Property
    
    static let identifier = "disLikeResultCell"
    weak var delegate: DislikeResultCellDelegate?
    
    // MARK: - View
    
    private let containerView: UIStackView = {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .equalSpacing
        $0.spacing = 3
        $0.layer.cornerRadius = Size.keywordLabelHeight / 2
        $0.layer.masksToBounds = true
        $0.backgroundColor = .blue
        return $0
    }(UIStackView())
    
    private let leftEmptyView = UIView()
    private let rightEmptyView = UIView()
    
    let disLikeLabel: UILabel = {
        $0.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        $0.textColor = .white
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private lazy var xButton: UIImageView = {
        $0.image = UIImage(systemName: "xmark")
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .white
        $0.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapXButton))
        $0.addGestureRecognizer(tapGesture)
        return $0
    }(UIImageView())
    
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
    
    // MARK: - Layout
    
    private func layout() {
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
    
    // MARK: - Configure
    
    private func configureText(_ disLikeText: String) {
        disLikeLabel.text = disLikeText
    }
    
    func configureLabel(_ type: KeywordType) {
        containerView.layer.maskedCorners = type.maskedCorners
    }
    
    // MARK: - Button
    
    @objc func didTapXButton() {
        delegate?.didTapXButton(disLikeLabel)
    }
    
    // MARK: - Method
    
    static func fittingSize(availableHeight: CGFloat, _ disLikeType: String) -> CGSize {
        let cell = DislikeResultCell()
        cell.configureText(disLikeType)
        let targetSize = CGSize(width: UIView.layoutFittingCompressedSize.width, height: availableHeight)
        return cell.contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .fittingSizeLevel, verticalFittingPriority: .required)
    }
}
