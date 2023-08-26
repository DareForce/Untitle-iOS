//
//  WelecomeView.swift
//  JunctionAsia2023
//
//  Created by 최지철 on 2023/08/19.
//

import Foundation
import UIKit
import SnapKit

protocol UserDataInfoViewDelegate: AnyObject {
    func nextBtnClick(_ userDataInfoView: UserDataInfoView)
}

final class UserDataInfoView: UIView {
    
    // MARK: - Property
    
    weak var delegate: UserDataInfoViewDelegate?
    private var userDataInfo: (name: String, age: String, sex: String) = ("", "", "") {
        didSet {
            if !userDataInfo.age.isEmpty && !userDataInfo.age.isEmpty && !userDataInfo.sex.isEmpty {
                nextBtn.isEnabled = true
                nextBtn.backgroundColor = .mainBlueColor
            } else {
                nextBtn.isEnabled = false
                nextBtn.backgroundColor = .disabledButtonColor
            }
        }
    }
    
    // MARK: - View
    
    private let titleLabel: UILabel = {
        $0.text = "Hello!"
        $0.textColor = .black
        $0.font = UIFont.boldSystemFont(ofSize: 34)
        return $0
    }(UILabel())
    
    private let subtitleLabel: UILabel = {
        $0.text = "Enter your credentials to continue"
        $0.textColor =  UIColor(hexString: "#3C3C43", alpha: 0.6)
        $0.font = UIFont.systemFont(ofSize: 17)
        return $0
    }(UILabel())
    
    private let nameLabel: UILabel = {
        $0.text = "Name"
        $0.textColor = UIColor(hexString: "#3C3C43", alpha: 0.6)
        $0.font = UIFont.systemFont(ofSize: 13)
        return $0
    }(UILabel())
    
    let nameTextField: UITextField = {
        $0.setLeftPaddingPoints(12)
        $0.font = UIFont.systemFont(ofSize: 17)
        $0.backgroundColor = UIColor(hexString: "#F0F0F0")
        $0.layer.cornerRadius = 15
        $0.layer.masksToBounds = true
        $0.autocorrectionType = .no
        $0.spellCheckingType = .yes
        $0.autocapitalizationType = .none
        return $0
    }(UITextField())
    
    private let ageLabel: UILabel = {
        $0.text = "Age"
        $0.textColor = UIColor(hexString: "#3C3C43", alpha: 0.6)
        $0.font = UIFont.systemFont(ofSize: 13)
        return $0
    }(UILabel())
    
    private let ageTextField: UITextField = {
        $0.setLeftPaddingPoints(12)
        $0.font = UIFont.systemFont(ofSize: 17)
        $0.backgroundColor = UIColor(hexString: "#F0F0F0")
        $0.layer.cornerRadius = 15
        $0.layer.masksToBounds = true
        $0.keyboardType = .numberPad
        return $0
    }(UITextField())
    
    private let sexLabel: UILabel = {
        $0.text = "Sex"
        $0.textColor = UIColor(hexString: "#3C3C43", alpha: 0.6)
        $0.font = UIFont.systemFont(ofSize: 13)
        return $0
    }(UILabel())
    
    private let hStackView: UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 6
        $0.distribution = .fillEqually
        return $0
    }(UIStackView())
    
    private let maleButton: UIButton = {
        $0.setTitle("Male", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        $0.setTitleColor(.unselectedButtonTitleColor, for: .normal)
        $0.backgroundColor = .unselectedButtonBackgroundColor
        $0.addTarget(self, action: #selector(pressedGenderButton), for: .touchUpInside)
        $0.layer.cornerRadius = 15
        $0.layer.masksToBounds = true
        return $0
    }(UIButton())
    
    private let femaleButton: UIButton = {
        $0.setTitle("Female", for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        $0.setTitleColor(.unselectedButtonTitleColor, for: .normal)
        $0.backgroundColor = .unselectedButtonBackgroundColor
        $0.addTarget(self, action: #selector(pressedGenderButton), for: .touchUpInside)
        $0.layer.cornerRadius = 15
        $0.layer.masksToBounds = true
        return $0
    }(UIButton())
    
    private let nextBtn: UIButton = {
        $0.setTitle("Next", for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        $0.setTitleColor(.selectedButtonTitleColor, for: .normal)
        $0.setTitleColor(.mainBlueColor, for: .disabled)
        $0.backgroundColor = UIColor(hexString: "#E6E2FF")
        $0.addTarget(self, action: #selector(pressedNextButton), for: .touchUpInside)
        $0.layer.cornerRadius = 15
        $0.layer.masksToBounds = true
        $0.isEnabled = false
        return $0
    }(UIButton())
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configure()
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func layout() {
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(40)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        self.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        self.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(30)
            $0.horizontalEdges.equalToSuperview().inset(28)
        }
        
        self.addSubview(nameTextField)
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(5)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(50)
        }
        
        self.addSubview(ageLabel)
        ageLabel.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(28)
        }
        
        self.addSubview(ageTextField)
        ageTextField.snp.makeConstraints {
            $0.top.equalTo(ageLabel.snp.bottom).offset(5)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(50)
        }
        
        self.addSubview(sexLabel)
        sexLabel.snp.makeConstraints {
            $0.top.equalTo(ageTextField.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(28)
        }
        
        self.addSubview(hStackView)
        hStackView.addArrangedSubview(maleButton)
        hStackView.addArrangedSubview(femaleButton)
        
        hStackView.snp.makeConstraints {
            $0.top.equalTo(sexLabel.snp.bottom).offset(5)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(50)
        }
        
        self.addSubview(nextBtn)
        nextBtn.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().offset(-14)
            $0.height.equalTo(50)
        }
    }

    // MARK: - Configure
    
    private func configure() {
        self.ageTextField.delegate = self
        self.nameTextField.delegate = self
    }
    
    // MARK: - pressedButton
    
    @objc func pressedNextButton() {
        delegate?.nextBtnClick(self)
    }
    
    @objc func pressedGenderButton(_ sender: UIButton) {
        sender.backgroundColor = .mainBlueColor
        sender.setTitleColor(.selectedButtonTitleColor, for: .normal)
        userDataInfo.sex = sender.currentTitle ?? "Male"
        
        if sender.currentTitle == "Male" {
            femaleButton.backgroundColor = .unselectedButtonBackgroundColor
            femaleButton.setTitleColor(.unselectedButtonTitleColor, for: .normal)
        } else {
            maleButton.backgroundColor = .unselectedButtonBackgroundColor
            maleButton.setTitleColor(.unselectedButtonTitleColor, for: .normal)
        }
    }
}

// MARK: - UITextFieldDelegate

extension UserDataInfoView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == nameTextField {
            userDataInfo.name = textField.text ?? "사용자"
        } else {
            userDataInfo.age = textField.text ?? "0"
        }
    }
}

