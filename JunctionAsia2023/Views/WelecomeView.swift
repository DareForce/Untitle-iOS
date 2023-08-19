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

protocol WelecomeViewDelegate: AnyObject {
    func manBtnClick(_ welecomView: WelecomeView)
    func womenBtnClick(_ welecomView: WelecomeView)
    func nextBtnClick(_ welecomView: WelecomeView)
}

class WelecomeView: UIView {
    private var selectedButtonTitleColor: UIColor? // 선택된 버튼의 타이틀 컬러를 추적하는 변수
    private var selectedButtonTitle: String? // 선택된 버튼의 타이틀을 추적하는 변수
    weak var delegate: WelecomeViewDelegate?
    
    private let nextBtn = UIButton().then{
        $0.setTitle("Next", for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        $0.setTitleColor(UIColor(hexString: "#3E24FF"), for: .normal)
        $0.backgroundColor = UIColor(hexString: "#E6E2FF")
        $0.layer.cornerRadius = 15
        $0.layer.masksToBounds = true
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
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
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
    private let nameTextField = UITextField().then{
        $0.setLeftPaddingPoints(12)
        $0.backgroundColor = UIColor(hexString: "#F0F0F0")
        $0.layer.cornerRadius = 15
        $0.layer.masksToBounds = true
    }
    private let nameLabel = UILabel().then{
        $0.text = "Name"
        $0.textColor =  UIColor(hexString: "#3C3C43")
        $0.font = UIFont.systemFont(ofSize: 13)
    }
    private let titleLabel = UILabel().then{
        $0.text = "Hello"
        $0.textColor = .black
        $0.font = UIFont.boldSystemFont(ofSize: 34)
    }
    private let subtitleLabel = UILabel().then{
        $0.text = "Enter your credentials to continue"
        $0.textColor =  UIColor(hexString: "#3C3C43", alpha: 0.6)
        $0.font = UIFont.systemFont(ofSize: 17)
    }
    private func layout() {
        self.nextBtn.snp.makeConstraints{
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(16)
            $0.leading.equalTo(safeAreaLayoutGuide).offset(16)
            $0.trailing.equalTo(safeAreaLayoutGuide).offset(-16)
            $0.height.equalTo(50)
        }
        self.womenBtn.snp.makeConstraints{
            $0.top.equalTo(sexLabel.snp.bottom).offset(0)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(50)
            $0.width.equalTo(176)
        }
        self.manBtn.snp.makeConstraints{
            $0.top.equalTo(sexLabel.snp.bottom).offset(0)
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalTo(176)
            $0.height.equalTo(50)
        }
        self.sexLabel.snp.makeConstraints{
            $0.top.equalTo(ageTextField.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(28)
        }
        self.ageTextField.snp.makeConstraints{
            $0.top.equalTo(ageLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(50)
        }
        self.ageLabel.snp.makeConstraints{
            $0.top.equalTo(nameTextField.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(28)
        }
        self.nameTextField.snp.makeConstraints{
            $0.top.equalTo(nameLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(50)
        }
        self.nameLabel.snp.makeConstraints{
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(28)
        }
        self.subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
        }
        self.titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
    }
    private func addsubview() {
        self.addSubview(subtitleLabel)
        self.addSubview(titleLabel)
        self.addSubview(nameTextField)
        self.addSubview(nameLabel)
        self.addSubview(ageLabel)
        self.addSubview(ageTextField)
        self.addSubview(sexLabel)
        self.addSubview(manBtn)
        self.addSubview(womenBtn)
        self.addSubview(nextBtn)
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
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
        self.addsubview()
        self.layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension WelecomeView {
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
extension WelecomeView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if !nameTextField.text!.isEmpty && !ageTextField.text!.isEmpty{
            updateButtonState(enabled: true) // 텍스트가 입력되었을 때 버튼 활성화
        }
        else{
            updateButtonState(enabled: false) // 텍스트가 없으면 버튼 비활성화
        }
    }
}

