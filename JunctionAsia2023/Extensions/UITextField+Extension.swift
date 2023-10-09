//
//  UITextField+Extension.swift
//  JunctionAsia2023
//
//  Created by 지준용 on 2023/08/20.
//

import UIKit

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
