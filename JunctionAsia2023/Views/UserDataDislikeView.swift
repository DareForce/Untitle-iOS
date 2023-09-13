//
//  UserDataDislikeView.swift
//  JunctionAsia2023
//
//  Created by 지준용 on 2023/09/09.
//

import UIKit
import SnapKit

protocol UserDataDislikeViewDelegate: AnyObject {
    func moveToSearchResultViewController()
    func moveToMainViewController()
    func didTapXButton(_ sender: UILabel)
}

final class UserDataDislikeView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: UserDataDislikeViewDelegate?
    
    var dislikeType = [Keyword]() {
        didSet {
            count = dislikeType.count
            dislikeCollectionView.reloadData()
        }
    }
    private var count: Int? {
        didSet {
            if count == 0 {
                skipAndSuccessButton.setTitleColor(.mainBlueColor, for: .normal)
                skipAndSuccessButton.backgroundColor = .disabledButtonColor
            } else {
                skipAndSuccessButton.setTitleColor(.white, for: .normal)
                skipAndSuccessButton.backgroundColor = .mainBlueColor
            }
        }
    }
    
    // MARK: - Views
    
    private let titleLabel: UILabel = {
        $0.text = "Additional Info"
        $0.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    private let descriptionLabel: UILabel = {
        $0.text = "Any more ingredients you don't want?"
        $0.textColor = .secondaryLabel
        $0.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    private lazy var searchButton: UIView = {
        $0.backgroundColor = .systemGray6
        $0.layer.cornerRadius = 10
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(moveToSearchResultViewController))
        $0.addGestureRecognizer(tapGestureRecognizer)
        return $0
    }(UIView())
    
    private let searchImage: UIImageView = {
        $0.image = UIImage(systemName: "magnifyingglass")
        $0.tintColor = .secondaryLabel
        return $0
    }(UIImageView())
    
    private let searchLabel: UILabel = {
        $0.text = "Search"
        $0.textColor = .secondaryLabel
        $0.font = UIFont.systemFont(ofSize: 17)
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    let dislikeCollectionView = DynamicCollectionView()
    
    private let skipAndSuccessButton: UIButton = {
        $0.setTitle("Next", for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        $0.setTitleColor(.mainBlueColor, for: .normal)
        $0.backgroundColor = .disabledButtonColor
        $0.layer.cornerRadius = 15
        $0.layer.masksToBounds = true
        $0.addTarget(self, action: #selector(moveToMainViewController), for: .touchUpInside)
        return $0
    }(UIButton())
    
    // MARK: - Inits

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
        setupDislikeCollectionView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func layout() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }

        addSubview(searchButton)
        searchButton.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(30)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(36)
        }
        
        searchButton.addSubview(searchImage)
        searchImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(8)
        }
        
        searchButton.addSubview(searchLabel)
        searchLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(searchImage.snp.right)
        }
        
        addSubview(skipAndSuccessButton)
        skipAndSuccessButton.snp.makeConstraints {
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(50)
        }
        
        addSubview(dislikeCollectionView)
        dislikeCollectionView.snp.makeConstraints {
            $0.top.equalTo(searchButton.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            $0.bottom.equalTo(skipAndSuccessButton.snp.top)
        }
    }
    
    // MARK: - Configure
    
    private func setupDislikeCollectionView() {
        dislikeCollectionView.delegate = self
        dislikeCollectionView.dataSource = self
        dislikeCollectionView.register(DislikeResultCell.self, forCellWithReuseIdentifier: DislikeResultCell.identifier)
    }
}

// MARK: - DisLikeResultCellDelegate

extension UserDataDislikeView: DislikeResultCellDelegate {
    
    // MARK: Navigation
    
    @objc func moveToSearchResultViewController() {
        delegate?.moveToSearchResultViewController()
    }
    
    @objc func moveToMainViewController() {
        delegate?.moveToMainViewController()
    }
    
    // MARK: Button
    
    func didTapXButton(_ sender: UILabel) {
        delegate?.didTapXButton(sender)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout, UICollectionViewDataSource

extension UserDataDislikeView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dislikeType.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DislikeResultCell.identifier, for: indexPath) as! DislikeResultCell
        let labelText = dislikeType[indexPath.row].string
        let labelType = dislikeType[indexPath.row].type

        cell.delegate = self
        
        cell.disLikeLabel.text = labelText
        cell.configureLabel(labelType)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let labelText = dislikeType[indexPath.row].string

        return DislikeResultCell.fittingSize(availableHeight: 45, labelText)
    }
}
