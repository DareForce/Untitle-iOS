//
//  UserDataInfoViewController.swift
//  JunctionAsia2023
//
//  Created by 최지철 on 2023/08/19.
//

import UIKit
import SnapKit

class UserDataInfoViewController: BaseViewController {
    
    // MARK: - Views
    
    private let userDataInfoView = UserDataInfoView(frame: UIScreen.main.bounds)

    // MARK: - LifeCycle
    
    override func loadView() {
        view = userDataInfoView
    }
    
    // MARK: - Configure
    
    override func configure() {
        self.userDataInfoView.delegate = self
        
        navigationController?.navigationBar.topItem?.title = ""
    }
}

// MARK: - WelecomeViewDelegate

extension UserDataInfoViewController: UserDataInfoViewDelegate {
    func nextBtnClick(_ userDataInfoView: UserDataInfoView) {
        let userDataAllergyViewController = UserDataAllergyViewController()
        userDataAllergyViewController.userName = self.userDataInfoView.nameTextField.text
        navigationController?.pushViewController(userDataAllergyViewController, animated: true)
    }
}
