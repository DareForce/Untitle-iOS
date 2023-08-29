//
//  RestaurantViewController.swift
//  JunctionAsia2023
//
//  Created by 최지철 on 2023/08/19.
//
    
import UIKit
import Kingfisher
import Alamofire
import SnapKit

class RestaurantViewController: BaseViewController {
    
    // MARK: - Property
    
    private var apidata:[RestaurantData] = []
    private let api = ResService()
    
    // MARK: - View
    
    private let tableView = UITableView(frame: CGRect.zero, style: .grouped).then{
        $0.backgroundColor = UIColor.white
        $0.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
    }
    
    private let spaceView = UIView().then {
        $0.backgroundColor = UIColor.systemGray5
        $0.layer.masksToBounds = false
        $0.layer.shadowColor = UIColor.lightGray.cgColor
        $0.layer.shadowOpacity = 0.1
        $0.layer.shadowOffset = CGSize(width: 1, height: 20)
    }
    
    private let searchbar = UISearchBar().then{
        $0.placeholder = "Search"
        $0.searchBarStyle = .minimal
    }
    
    private let titleLabel = UILabel().then{
        $0.text = "Restaurant"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 34, weight: .bold)
    }
    
    private let subtitleLabel = UILabel().then{
        $0.text = "Choose your menu without worrying!"+"\n"+"JAKA always considering your health"
        $0.textColor =  UIColor(hexString: "#3C3C43", alpha: 0.6)
        $0.font = UIFont.systemFont(ofSize: 17)
        $0.numberOfLines = 2
    }
    
    private func addsubview() {
        self.view.addSubview(tableView)
        self.view.addSubview(spaceView)
        self.view.addSubview(searchbar)
        self.view.addSubview(titleLabel)
        self.view.addSubview(subtitleLabel)
    }
    
    override func layout() {
        self.tableView.snp.makeConstraints {
            $0.top.equalTo(searchbar.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        self.spaceView.snp.makeConstraints {
            $0.top.equalTo(searchbar.snp.bottom).offset(21)
            $0.horizontalEdges.equalToSuperview()
        }
        self.searchbar.snp.makeConstraints{
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(42)
        }
        self.titleLabel.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalToSuperview().offset(16)
        }
        self.subtitleLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
        }
    }
    
    override func configure() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.addsubview()
        
        navigationItem.title = ""
        navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.api.getAllBrand { response in
            switch response{
            case .success(let data):
                self.apidata = data.data
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("오류:\(error)")
            }
        }
    }
}
extension RestaurantViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apidata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        cell.topLabel.text = apidata[indexPath.row].name
        cell.midLabel.text = apidata[indexPath.row].category
        cell.bottomLabel.text = apidata[indexPath.row].menus[0]
        
        if let imageURL = URL(string: apidata[indexPath.row].thumbnail ?? "") {
            cell.menuImageView.kf.setImage(with: imageURL)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = DetailResViewController()
        
        if let navigationController = self.navigationController {
            if let imageURL = URL(string: apidata[indexPath.row].thumbnail ?? ""){
                nextVC.topVIew.kf.setImage(with: imageURL)
            }
            nextVC.id = self.apidata[indexPath.row].restaurantId
            nextVC.resNameLabel.text = apidata[indexPath.row].name
            nextVC.ressubLabel.text = apidata[indexPath.row].category
            navigationController.pushViewController(nextVC, animated: true)
        }
    }
}
