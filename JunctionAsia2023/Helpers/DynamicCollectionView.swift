//
//  DynamicCollectionView.swift
//  JunctionAsia2023
//
//  Created by 지준용 on 2023/08/22.
//

import UIKit
import SnapKit

final class DynamicCollectionView: UICollectionView {
    
    // MARK: - Init
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: UserDataCollectionViewLayout.init())
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    private func configure() {
        self.showsVerticalScrollIndicator = false
        self.allowsMultipleSelection = true
    }
}
