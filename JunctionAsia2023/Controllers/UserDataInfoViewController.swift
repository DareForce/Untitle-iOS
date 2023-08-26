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
    
    private let welecomeView: UserDataInfoView = UserDataInfoView(frame: .zero)
    
    // MARK: - Lauout
    
    override func layout() {
        self.welecomeView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - Configure
    
    override func configure() {
        self.view.addSubview(welecomeView)
        self.welecomeView.delegate = self
        
        navigationController?.navigationBar.topItem?.title = ""
    }
}

// MARK: - WelecomeViewDelegate

extension UserDataInfoViewController: UserDataInfoViewDelegate {
    func nextBtnClick(_ welecomView: UserDataInfoView) {
        let userDataAllegyViewController = UserDataAllegyViewController()
        userDataAllegyViewController.userName = self.welecomeView.nameTextField.text
        navigationController?.pushViewController(userDataAllegyViewController, animated: true)
    }
    func manBtnClick(_ welecomView: UserDataInfoView) {
        
    }
    
    func womenBtnClick(_ welecomView: UserDataInfoView) {
        
    }
}
