//
//  WelecomeView.swift
//  JunctionAsia2023
//
//  Created by 최지철 on 2023/08/19.
//

import Foundation
import UIKit
import SnapKit
import Then

protocol UserDataInfoViewDelegate: AnyObject {
    func manBtnClick(_ userDataInfoView: UserDataInfoView)
    func womenBtnClick(_ userDataInfoView: UserDataInfoView)
    func nextBtnClick(_ userDataInfoView: UserDataInfoView)
}

class UserDataInfoView: UIView {
    
    // MARK: - Property
    
    private var selectedButtonTitleColor: UIColor? // 선택된 버튼의 타이틀 컬러를 추적하는 변수
    private var selectedButtonTitle: String? // 선택된 버튼의 타이틀을 추적하는 변수
    weak var delegate: UserDataInfoViewDelegate?
    
    // MARK: - View
    
    private let hStackView: UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 6
        $0.distribution = .fillEqually
        return $0
    }(UIStackView())
    
    private let nextBtn = UIButton().then{
        $0.setTitle("Next", for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        $0.setTitleColor(UIColor(hexString: "#3E24FF"), for: .normal)
        $0.backgroundColor = UIColor(hexString: "#E6E2FF")
        $0.layer.cornerRadius = 15
        $0.layer.masksToBounds = true
        $0.isEnabled = false
    }
    private let womenBtn = UIButton().then{
        $0.setTitle("Female", for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        $0.setTitleColor(UIColor(hexString: "#3C3C43", alpha: 0.6), for: .normal)
        $0.backgroundColor = UIColor(hexString: "#F0F0F0")
        $0.layer.cornerRadius = 15
        $0.layer.masksToBounds = true
    }
    private let manBtn = UIButton().then{
        $0.setTitle("Male", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        $0.setTitleColor(UIColor(hexString: "#3C3C43", alpha: 0.6), for: .normal)
        $0.backgroundColor = UIColor(hexString: "#F0F0F0")
        $0.layer.cornerRadius = 15
        $0.layer.masksToBounds = true
    }
    private let sexLabel = UILabel().then{
        $0.text = "Sex"
        $0.textColor =  UIColor(hexString: "#3C3C43")
        $0.font = UIFont.systemFont(ofSize: 13)
    }
    private let ageTextField = UITextField().then{
        $0.setLeftPaddingPoints(12)
        $0.backgroundColor = UIColor(hexString: "#F0F0F0")
        $0.layer.cornerRadius = 15
        $0.layer.masksToBounds = true
        $0.keyboardType = .numberPad
    }
    private let ageLabel = UILabel().then{
        $0.text = "Age"
        $0.textColor =  UIColor(hexString: "#3C3C43")
        $0.font = UIFont.systemFont(ofSize: 13)
    }
    let nameTextField = UITextField().then{
        $0.setLeftPaddingPoints(12)
        $0.backgroundColor = UIColor(hexString: "#F0F0F0")
        $0.layer.cornerRadius = 15
        $0.layer.masksToBounds = true
        $0.autocorrectionType = .no
        $0.spellCheckingType = .yes
        $0.autocapitalizationType = .none
    }
    private let nameLabel = UILabel().then{
        $0.text = "Name"
        $0.textColor =  UIColor(hexString: "#3C3C43")
        $0.font = UIFont.systemFont(ofSize: 13)
    }
    private let titleLabel = UILabel().then{
        $0.text = "Hello!"
        $0.textColor = .black
        $0.font = UIFont.boldSystemFont(ofSize: 34)
    }
    private let subtitleLabel = UILabel().then{
        $0.text = "Enter your credentials to continue"
        $0.textColor =  UIColor(hexString: "#3C3C43", alpha: 0.6)
        $0.font = UIFont.systemFont(ofSize: 17)
    }
    
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
        hStackView.addArrangedSubview(manBtn)
        hStackView.addArrangedSubview(womenBtn)
        
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

    private func configure() {
        self.womenBtn.addTarget(self, action: #selector(womenBtnClick), for: .touchUpInside)
        self.manBtn.addTarget(self, action: #selector(manBtnClick), for: .touchUpInside)
        self.nextBtn.addTarget(self, action: #selector(nextBtnClick), for: .touchUpInside)
        self.ageTextField.delegate = self
        self.nameTextField.delegate = self
    }
    
    private func updateButtonColors() {
        manBtn.backgroundColor = (selectedButtonTitle == "Man") ? UIColor(hexString: "#3E24FF") : UIColor(hexString: "#F0F0F0")
        womenBtn.backgroundColor = (selectedButtonTitle == "Women") ? UIColor(hexString: "#3E24FF") : UIColor(hexString: "#F0F0F0")
        manBtn.setTitleColor((selectedButtonTitle == "Man") ? selectedButtonTitleColor : UIColor(hexString: "#3C3C43", alpha: 0.6), for: .normal)
            womenBtn.setTitleColor((selectedButtonTitle == "Women") ? selectedButtonTitleColor : UIColor(hexString: "#3C3C43", alpha: 0.6), for: .normal)
    }
    
    private func updateButtonState(enabled: Bool) {
        if enabled {
            nextBtn.isEnabled = true
            nextBtn.setTitleColor(UIColor(hexString: "#FFFFFF"), for: .normal)
            nextBtn.backgroundColor = UIColor(hexString: "#3E24FF")
        } else {
            nextBtn.isEnabled = false
            nextBtn.setTitleColor(UIColor(hexString: "#3E24FF"), for: .normal)
            nextBtn.backgroundColor = UIColor(hexString: "#E6E2FF")
        }
    }
}
extension UserDataInfoView {
    @objc func nextBtnClick() {
        delegate?.nextBtnClick(self)

    }
    @objc func manBtnClick() {
        delegate?.manBtnClick(self)
        
        if nameTextField.text != "" && ageTextField.text != ""
        {
            selectedButtonTitle = "Man"
            selectedButtonTitleColor = UIColor(hexString: "#FFFFFF") // 선택된 버튼 타이틀 컬러 변경
            updateButtonColors()
            self.updateButtonState(enabled: true)
        }
    }
    @objc func womenBtnClick() {
        delegate?.womenBtnClick(self)
        
        if nameTextField.text != "" && ageTextField.text != ""
        {
            selectedButtonTitle = "Women"
            selectedButtonTitleColor = UIColor(hexString: "#FFFFFF") // 선택된 버튼 타이틀 컬러 변경
            updateButtonColors()
            self.updateButtonState(enabled: true)
        }
    }
}
extension UserDataInfoView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if !nameTextField.text!.isEmpty && !ageTextField.text!.isEmpty{
            updateButtonState(enabled: true) // 텍스트가 입력되었을 때 버튼 활성화
        }
        else{
            updateButtonState(enabled: false) // 텍스트가 없으면 버튼 비활성화
        }
    }
}

