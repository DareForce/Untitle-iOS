//
//  TableViewCell.swift
//  JunctionAsia2023
//
//  Created by 최지철 on 2023/08/19.
//

import UIKit
import SnapKit

final class TableViewCell: UITableViewCell {
    
    // MARK: - Property
    
    static let identifier = "TableViewCell"
    
    // MARK: - View
    
    var menuImageView = UIImageView().then{
        $0.backgroundColor = .systemGray4
        $0.contentMode = .scaleToFill
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
    }
    
    var topLabel: UILabel = {
        $0.text = "Restaurant or Food Name"
        $0.numberOfLines = 0
        $0.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return $0
    }(UILabel())
    
    var midLabel = UILabel().then{
        $0.text = "Food type or Allergy name"
        $0.textColor = .unselectedButtonTitleColor
        $0.numberOfLines = 0
        $0.font = UIFont.systemFont(ofSize: 15)
    }
    
    var bottomLabel = UILabel().then{
        $0.text = "Menus or Price"
        $0.textColor = .unselectedButtonTitleColor
        $0.font = UIFont.systemFont(ofSize: 12)
    }
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method

    private func layout() {
        self.addSubview(menuImageView)
        self.menuImageView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.verticalEdges.equalToSuperview().inset(20)
            $0.size.equalTo(88)
        }
        
        self.addSubview(topLabel)
        self.topLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.left.equalTo(menuImageView.snp.right).offset(16)
        }
        
        self.addSubview(midLabel)
        self.midLabel.snp.makeConstraints {
            $0.top.equalTo(topLabel.snp.bottom).offset(8)
            $0.left.equalTo(menuImageView.snp.right).offset(16)
        }
        
        self.addSubview(bottomLabel)
        self.bottomLabel.snp.makeConstraints{
            $0.top.equalTo(midLabel.snp.bottom).offset(10)
            $0.left.equalTo(menuImageView.snp.right).offset(16)
        }
    }
}
