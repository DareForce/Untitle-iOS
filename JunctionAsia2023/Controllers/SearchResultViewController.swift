//
//  SearchResultViewController.swift
//  JunctionAsia2023
//
//  Created by 지준용 on 2023/08/19.
//

import UIKit
import SnapKit

var disLikeMockData: [Keyword] = [
    Keyword(string: "Carrot", type: .previewKeyword),
    Keyword(string: "Broccoli", type: .previewKeyword),
    Keyword(string: "Spinach", type: .previewKeyword),
    Keyword(string: "Zucchini", type: .previewKeyword),
    Keyword(string: "Bell Pepper", type: .previewKeyword),
    Keyword(string: "Onion", type: .previewKeyword),
    Keyword(string: "Cauliflower", type: .previewKeyword),
    Keyword(string: "Sweet Potato", type: .previewKeyword),
    Keyword(string: "Cabbage", type: .previewKeyword),
    Keyword(string: "Apple", type: .previewKeyword),
    Keyword(string: "Banana", type: .previewKeyword),
    Keyword(string: "Orange", type: .previewKeyword),
    Keyword(string: "Grape", type: .previewKeyword),
    Keyword(string: "Strawberry", type: .previewKeyword),
    Keyword(string: "Blueberry", type: .previewKeyword),
    Keyword(string: "Raspberry", type: .previewKeyword),
    Keyword(string: "Pineapple", type: .previewKeyword),
    Keyword(string: "Lemon", type: .previewKeyword),
    Keyword(string: "Lime", type: .previewKeyword),
    Keyword(string: "Coconut", type: .previewKeyword),
    Keyword(string: "Almond", type: .previewKeyword),
    Keyword(string: "Cashew", type: .previewKeyword),
    Keyword(string: "Walnut", type: .previewKeyword),
    Keyword(string: "Hazelnut", type: .previewKeyword),
    Keyword(string: "Pistachio", type: .previewKeyword),
    Keyword(string: "Sunflower Seed", type: .previewKeyword),
    Keyword(string: "Flaxseed", type: .previewKeyword),
    Keyword(string: "Chia Seed", type: .previewKeyword),
    Keyword(string: "Quinoa", type: .previewKeyword),
    Keyword(string: "Rice", type: .previewKeyword),
]

class SearchResultViewController: BaseViewController {
    
    // MARK: - Property
    
    static var disLikeType = disLikeMockData
    var searchingData = [Keyword]()
    
    // MARK: - View
    
    private let searchBar = UISearchBar()
    private let tableView = UITableView()
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.placeholder = "Search"
        navigationItem.titleView = searchBar
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(popToViewController))
        
        searchBar.delegate = self
    }
    
    // MARK: - Layout
    
    override func layout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }
    
    // MARK: - configure
    
    override func configure() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchResultCell.self, forCellReuseIdentifier: SearchResultCell.identifier)
        
        tableView.showsVerticalScrollIndicator = false
    }
    
    
    @objc func popToViewController() {
        navigationController?.popViewController(animated: false)
    }
}

extension SearchResultViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchingData = []
        
        searchingData = SearchResultViewController.disLikeType.filter({ $0.string.contains(searchText) })
        
        tableView.reloadData()
    }
}


extension SearchResultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchingData.count == 0 {
            return SearchResultViewController.disLikeType.count
        } else {
            return searchingData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.identifier, for: indexPath) as! SearchResultCell

        if searchingData.count == 0 {
            let labelText = SearchResultViewController.disLikeType[indexPath.row].string
            cell.configure(labelText)
        } else {
            let labelText = searchingData[indexPath.row].string
            cell.configure(labelText)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchingData.count == 0 {
            UserDataDislikeViewController.disLikeType.append(SearchResultViewController.disLikeType[indexPath.row])
        } else {
            UserDataDislikeViewController.disLikeType.append(searchingData[indexPath.row])
        }
        
        navigationController?.popViewController(animated: false)
    }
}
