    //
//  MainView.swift
//  JunctionAsia2023
//
//  Created by 최지철 on 2023/08/19.
//

import UIKit

final class MainView: UIView {
    var purple = false
    
    let AdditionalCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(AllergiesCollectionViewCell.self, forCellWithReuseIdentifier: AllergiesCollectionViewCell.identifier)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
    }
    private let additionalgisLabel = UILabel().then{
        $0.text = "Additional"
        $0.textColor = UIColor(hexString: "#FFFFFF")
        $0.font = UIFont.systemFont(ofSize: 17)
    }
    let AllergiesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(AllergiesCollectionViewCell.self, forCellWithReuseIdentifier: AllergiesCollectionViewCell.identifier)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
    }
    private let allergisLabel = UILabel().then{
        $0.text = "Allergies"
        $0.textColor = UIColor(hexString: "#FFFFFF")
        $0.font = UIFont.systemFont(ofSize: 17)
    }
    private let charImg = UIImageView().then{
        $0.image = UIImage(named: "greenChar")
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = 40
        $0.layer.maskedCorners = .layerMaxXMaxYCorner
        $0.clipsToBounds = true
    }
    private let QRLabel = UILabel().then{
        $0.text = "Please move your Food ID Card(QR)"+"\n"+"over kiosk's camera"
        $0.textColor = .black
        $0.numberOfLines = 2
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textAlignment = .center
        let attributedStr = NSMutableAttributedString(string: $0.text!)
        attributedStr.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 16), range: ($0.text! as NSString).range(of: "Food ID Card(QR)"))
        $0.attributedText = attributedStr
    }
    private let QRImg = UIImageView().then{
        $0.image = UIImage(named: "QR")
        $0.contentMode = .scaleAspectFit
    }
    private let cameraLabel = UILabel().then{
        $0.text = "My Food ID Card"
        $0.textColor = .black
        $0.font = UIFont.boldSystemFont(ofSize: 18)
    }
    private let cameraImg = UIImageView().then{
        $0.image = UIImage(systemName: "camera.fill")
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .black
    }
    private let greenView = UIView().then{
        $0.backgroundColor = UIColor(hexString: "#CEF700")
        $0.layer.cornerRadius = 40
        $0.layer.masksToBounds = false
        $0.layer.shadowColor = UIColor.systemGray5.cgColor
        $0.layer.shadowOpacity = 0.8
        $0.layer.shadowOffset = CGSize(width: 0, height: 5)
        $0.layer.shadowRadius = 4
    }
    private let titleLabel = UILabel().then{
        $0.text = "Enjoy Your Meal!"
        $0.font = UIFont.systemFont(ofSize: 34, weight: .bold)
    }
    private let subtitleLabel = UILabel().then{
        $0.text = "This is your Food ID Card"
        $0.textColor =  UIColor(hexString: "#3C3C43", alpha: 0.6)
        $0.font = UIFont.systemFont(ofSize: 17)
    }
    private let purpleView = UIView().then{
        $0.backgroundColor = UIColor(hexString: "#3E24FF")
        $0.layer.cornerRadius = 40
        $0.layer.masksToBounds = false
        $0.layer.shadowColor = UIColor.systemGray5.cgColor
        $0.layer.shadowOpacity = 0.8
        $0.layer.shadowOffset = CGSize(width: 0, height: 5)
        $0.layer.shadowRadius = 4
    }
    let purpleNameLabel = UILabel().then{
        $0.text = "Name"
        $0.textColor = UIColor(hexString: "#FFFFFF")
        $0.font = UIFont.boldSystemFont(ofSize: 22)
    }
    private let purpleTitleLabel = UILabel().then{
        $0.text = "Food ID Card"
        $0.textColor = UIColor(hexString: "#FFFFFF")
        $0.font = UIFont.boldSystemFont(ofSize: 28)
    }
    private func addsubview(){
        self.addSubview(titleLabel)
        self.addSubview(subtitleLabel)
        self.addSubview(greenView)
        self.addSubview(purpleView)
        self.purpleView.addSubview(purpleNameLabel)
        self.purpleView.addSubview(purpleTitleLabel)
        self.purpleView.addSubview(charImg)
        self.purpleView.addSubview(allergisLabel)
        self.purpleView.addSubview(AllergiesCollectionView)
        self.purpleView.addSubview(additionalgisLabel)
        self.purpleView.addSubview(AdditionalCollectionView)
        self.greenView.addSubview(QRImg)
        self.greenView.addSubview(QRLabel)
        self.greenView.addSubview(cameraImg)
        self.greenView.addSubview(cameraLabel)
    }
    private func layout(){
        self.AdditionalCollectionView.snp.makeConstraints{
            $0.top.equalTo(additionalgisLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(39)
        }
        self.additionalgisLabel.snp.makeConstraints{
            $0.top.equalTo(AllergiesCollectionView.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(31)
        }
        self.AllergiesCollectionView.snp.makeConstraints{
            $0.top.equalTo(allergisLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(39)
        }
        self.allergisLabel.snp.makeConstraints{
            $0.top.equalTo(purpleTitleLabel.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(31)
        }
        self.charImg.snp.makeConstraints{
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        self.QRLabel.snp.makeConstraints{
            $0.top.equalTo(QRImg.snp.bottom).offset(18)
            $0.centerX.equalToSuperview()
        }
        self.QRImg.snp.makeConstraints{
            $0.top.equalTo(cameraLabel.snp.bottom).offset(21)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(287)
            $0.height.equalTo(287)
        }
        self.cameraLabel.snp.makeConstraints{
            $0.top.equalTo(cameraImg.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        self.cameraImg.snp.makeConstraints{
            $0.top.equalToSuperview().offset(23)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(42)
            $0.height.equalTo(32)
        }
        self.greenView.snp.makeConstraints{
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(60)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(480)
        }
        self.purpleTitleLabel.snp.makeConstraints{
            $0.top.equalTo(purpleNameLabel.snp.bottom).offset(1)
            $0.leading.equalToSuperview().offset(24)
        }
        self.purpleNameLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(24)
            $0.leading.equalToSuperview().offset(24)
        }
        self.purpleView.snp.makeConstraints{
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(60)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(480)
        }
        self.subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
        }
        self.titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(40)
            $0.leading.equalToSuperview().offset(16)
        }
    }
    private func configure(){
        self.purpleView.isUserInteractionEnabled = true
         //제쳐스 추가
         self.purpleView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.viewTapped)))
        self.greenView.isUserInteractionEnabled = true
         //제쳐스 추가
         self.greenView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.viewTapped)))
    }
    @objc func viewTapped(_ sender: UITapGestureRecognizer) {
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]


        if purple != true {
            UIView.transition(with: greenView, duration: 0.3, options: transitionOptions, animations: {
                self.purpleView.isHidden = false
            })

            UIView.transition(with: purpleView, duration: 0.3, options: transitionOptions, animations: {
               self.purpleView.isHidden = true
            })
            purple = true

        }
        else{
            purple = false

            UIView.transition(with: purpleView, duration: 0.3, options: transitionOptions, animations: {
                self.purpleView.isHidden = true
            })
            UIView.transition(with: greenView, duration: 0.3, options: transitionOptions, animations: {
                self.purpleView.isHidden = false
                print("2")

            })

        }

    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addsubview()
        self.layout()
        self.configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
