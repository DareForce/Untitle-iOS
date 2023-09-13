//
//  AllergiesCollectionViewCell.swift
//  JunctionAsia2023
//
//  Created by 최지철 on 2023/08/19.
//

import UIKit
import SnapKit

final class AllergiesCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Property
    
    static let identifier = "AllergiesCollectionViewCell"
    
    // MARK: - Views
    
    let cellLabel: UILabel = {
        $0.text = "Garlic"
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 15)
        return $0
    }(UILabel())
    
    private let roundView: UIView = {
        $0.backgroundColor = .clear
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.white.cgColor
        $0.layer.cornerRadius = 15
        $0.layer.masksToBounds = true
        return $0
    }(UIView())
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func layout() {
        addSubview(roundView)
        self.roundView.snp.makeConstraints{
            $0.center.equalToSuperview()
            $0.height.equalTo(35)
            $0.width.equalToSuperview()
        }
        
        roundView.addSubview(cellLabel)
        self.cellLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
}
