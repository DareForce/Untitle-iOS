//
//  UserDataInfoViewController.swift
//  JunctionAsia2023
//
//  Created by 최지철 on 2023/08/19.
//

import UIKit
import SnapKit

class UserDataInfoViewController: BaseViewController {
    
    // MARK: - View
    
    private let userDataInfoView = UserDataInfoView()
    
    // MARK: - Lauout
    
    override func layout() {
        self.userDataInfoView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - Configure
    
    override func configure() {
        self.view.addSubview(userDataInfoView)
        self.userDataInfoView.delegate = self
        
        navigationController?.navigationBar.topItem?.title = ""
    }
}

// MARK: - WelecomeViewDelegate

extension UserDataInfoViewController: UserDataInfoViewDelegate {
    func nextBtnClick(_ userDataInfoView: UserDataInfoView) {
        let userDataAllegyViewController = UserDataAllegyViewController()
        userDataAllegyViewController.userName = self.userDataInfoView.nameTextField.text
        navigationController?.pushViewController(userDataAllegyViewController, animated: true)
    }
}
