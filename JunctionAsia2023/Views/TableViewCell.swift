//
//  TableViewCell.swift
//  JunctionAsia2023
//
//  Created by 최지철 on 2023/08/19.
//

import UIKit
import SnapKit

class TableViewCell: UITableViewCell {
    static let identifier = "TableViewCell"
    
    public var img = UIImageView().then{
        $0.backgroundColor = .systemGray4
        $0.contentMode = .scaleToFill
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
    }
    public var resNameLabel: UILabel = {
        $0.text = "식당"
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        return $0
    }(UILabel())
    public var titleLabel = UILabel().then{
        $0.text = "KoreanFood"
        $0.textColor =  UIColor(hexString: "#3C3C43", alpha: 0.6)
        $0.font = UIFont.systemFont(ofSize: 15)
    }
    public var subtitleLabel = UILabel().then{
        $0.text = "Bulgogi, Korean Beef Stew"
        $0.textColor =  UIColor(hexString: "#3C3C43", alpha: 1)
        $0.font = UIFont.systemFont(ofSize: 12)
    }
    private func adddsubview() {
        self.addSubview(subtitleLabel)
        self.addSubview(resNameLabel)
        self.addSubview(titleLabel)
        self.addSubview(resNameLabel)
        self.addSubview(img)
    }
    private func layout() {
        self.subtitleLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.leading.equalTo(img.snp.trailing).offset(17)
        }
        self.titleLabel.snp.makeConstraints{
            $0.top.equalTo(resNameLabel.snp.bottom).offset(5)
            $0.leading.equalTo(img.snp.trailing).offset(17)
        }
        self.resNameLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(21)
            $0.leading.equalTo(img.snp.trailing).offset(17)
        }
        self.img.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(21)
            $0.height.width.equalTo(88)
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.adddsubview()
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
