//
//  WelcomeViewController.swift
//  JunctionAsia2023
//
//  Created by 최지철 on 2023/08/19.
//

import UIKit

class WelcomeViewController: BaseViewController {
    private let welecomeView: WelecomeView = WelecomeView(frame: .zero)
    override func layout() {
        self.welecomeView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }
    override func configure() {
        self.view.addSubview(welecomeView)
        self.welecomeView.delegate = self
        
        navigationController?.navigationBar.topItem?.title = ""
    }
}
extension WelcomeViewController: WelecomeViewDelegate {
    func nextBtnClick(_ welecomView: WelecomeView) {
        let userDataViewController = UserDataViewController()
        navigationController?.pushViewController(userDataViewController, animated: true)
    }
    func manBtnClick(_ welecomView: WelecomeView) {
        
    }
    
    func womenBtnClick(_ welecomView: WelecomeView) {
        
    }
}
