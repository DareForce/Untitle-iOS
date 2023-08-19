//
//  MainView.swift
//  JunctionAsia2023
//
//  Created by 최지철 on 2023/08/19.
//

import UIKit

class MainView: UIView {
    private let titleLabel = UILabel().then{
        $0.text = "Hello"
        $0.textColor = .black
        $0.font = UIFont.boldSystemFont(ofSize: 34)
    }
    private let subtitleLabel = UILabel().then{
        $0.text = "Enter your credentials to continue"
        $0.textColor =  UIColor(hexString: "#3C3C43", alpha: 0.6)
        $0.font = UIFont.systemFont(ofSize: 17)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
