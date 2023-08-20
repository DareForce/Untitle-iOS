//
//  UserDataCollectionViewLayout.swift
//  JunctionAsia2023
//
//  Created by 지준용 on 2023/08/19.
//

import UIKit

class UserDataCollectionViewLayout: UICollectionViewFlowLayout {

    private enum Size {
        static let keywordLabelRowSpacing: CGFloat = 10
        static let keywordLabelXSpacing: CGFloat = 8
    }
    
    let cellSpacing: CGFloat = Size.keywordLabelXSpacing

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        self.minimumLineSpacing = Size.keywordLabelRowSpacing
        self.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let attributes = super.layoutAttributesForElements(in: rect)

        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            layoutAttribute.frame.origin.x = leftMargin
            leftMargin += layoutAttribute.frame.width + cellSpacing
            maxY = max(layoutAttribute.frame.maxY, maxY)
        }
        return attributes
    }
}
