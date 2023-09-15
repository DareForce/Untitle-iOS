//
//  SearchResultViewController.swift
//  JunctionAsia2023
//
//  Created by 지준용 on 2023/08/19.
//

import UIKit
import SnapKit

class SearchResultViewController: BaseViewController {
    
    // MARK: - Property
    
    var disLikeType = Ingredient.DislikeFood.allCases
    var searchingDatum = [Ingredient.DislikeFood]()
    
    // MARK: - View
    
    private let searchBar = UISearchBar()
    private let tableView = UITableView()
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.placeholder = "Search"
        navigationItem.titleView = searchBar
        
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(popToViewController))
    }
    
    // MARK: - Layout
    
    override func layout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }
    
    // MARK: - Configure
    
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

// MARK: - UISearchBarDelegate

extension SearchResultViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchingDatum = []
        
        searchingDatum = disLikeType.filter({
            $0.description.lowercased().contains(searchText.lowercased()) })
        
        tableView.reloadData()
    }
}


extension SearchResultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchingDatum.count == 0 {
            return disLikeType.count
        } else {
            return searchingDatum.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.identifier, for: indexPath) as! SearchResultCell
        
        if searchingDatum.count == 0 {
            let labelText = disLikeType[indexPath.row].description
            cell.configure(labelText)
        } else {
            let labelText = searchingDatum[indexPath.row].description
            cell.configure(labelText)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewControllers = navigationController?.viewControllers,
              let index = viewControllers.lastIndex(where: {$0 is UserDataDislikeViewController}),
              let userDataDislikeViewController = viewControllers[index] as? UserDataDislikeViewController else { return }
        
        if searchingDatum.count == 0 {
            userDataDislikeViewController.dislikeType.append(disLikeType[indexPath.row])
        } else {
            userDataDislikeViewController.dislikeType.append(searchingDatum[indexPath.row])
        }

        popToViewController()
    }
}
