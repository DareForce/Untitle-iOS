//
//  SearchResultCell.swift
//  JunctionAsia2023
//
//  Created by 지준용 on 2023/08/19.
//

import UIKit

class SearchResultCell: UITableViewCell {

    // MARK: - Property
    
    static let identifier = "searchResultCell"
    
    // MARK: - View
    
    let disLikeIngredient: UILabel = {
        $0.text = ""
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return $0
    }(UILabel())
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
    
    func layout() {
        addSubview(disLikeIngredient)
        disLikeIngredient.frame = bounds
    }
    
    func configure(_ ingredient: String) {
        disLikeIngredient.text = ingredient
    }
     
    @objc func disLikeIngredientClicked() {
        isSelected = true
    }
}
