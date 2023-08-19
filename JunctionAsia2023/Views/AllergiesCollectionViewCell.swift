//
//  AllergiesCollectionViewCell.swift
//  JunctionAsia2023
//
//  Created by 최지철 on 2023/08/19.
//

import UIKit

class AllergiesCollectionViewCell: UICollectionViewCell {
    static let identifier = "AllergiesCollectionViewCell"
    public var cellLabel = UILabel().then{
        $0.text = "Garlic"
        $0.textColor = UIColor(hexString: "#FFFFFF")
        $0.font = UIFont.systemFont(ofSize: 15)

    }
    private let roundView = UIView().then{
        $0.backgroundColor = .clear
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.white.cgColor
        $0.layer.cornerRadius = 15
        $0.layer.masksToBounds = true
    }
    private func addsubview() {
        self.addSubview(roundView)
        self.roundView.addSubview(cellLabel)
    }
    private func layout() {
        self.roundView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.height.equalTo(35)
            $0.width.equalToSuperview()
        }
        self.cellLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.addsubview()
        self.layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
