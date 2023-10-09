//
//  DetailMenuViewController.swift
//  JunctionAsia2023
//
//  Created by 최지철 on 2023/08/20.
//

import UIKit

final class DetailMenuViewController: BaseViewController {
    
    // MARK: - Property
    
    private var id:Int?
    private var apidata: [MenuData] = []
    private let api = DetailService()
    
    // MARK: - View
    
    private var ressubLabel = UILabel().then{
        $0.text = "School|Food"
        $0.textColor = UIColor(white: 1, alpha: 0.6)
        $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
    }
    
    private var resNameLabel = UILabel().then{
        $0.text = "Restaurant"
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 34, weight: .bold)
    }
    
    private let tableView = UITableView().then{
        $0.backgroundColor = UIColor.white
        $0.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
    }
    
    private var topView = UIImageView()
    
    // MARK: - LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        self.api.getAllBrand(restaurantId: self.id ?? 0) { response in
            switch response {
            case .success(let data):
                self.apidata = data.data
                print("성공!")
                print(self.apidata.count)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("오류:\(error)")
            }
        }
    }
    
    // MARK: - Layout
    
    override func layout() {
        self.ressubLabel.snp.makeConstraints{
            $0.top.equalTo(resNameLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(33)
        }
        self.resNameLabel.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-55)
            $0.leading.equalToSuperview().offset(33)
        }
        self.tableView.snp.makeConstraints{
            $0.top.equalTo(topView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()

        }
        self.topView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(334)
        }
    }
    
    private func addsubview(){
        self.topView.addSubview(ressubLabel)
        self.topView.addSubview(resNameLabel)
        self.view.addSubview(topView)
        self.view.addSubview(tableView)
    }
    
    // MARK: - Configure
    
    override func configure(){
        self.addsubview()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}
extension DetailMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apidata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        
        cell.topLabel.text = apidata[indexPath.row].name
        cell.topLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        
        if apidata[indexPath.row].ingredients.isEmpty {
            cell.midLabel.text = ""
        } else {
            cell.midLabel.text = "⚠️ " + apidata[indexPath.row].ingredients[0]
        }
        
        if let imageURL = URL(string: apidata[indexPath.row].thumbnail) {
            cell.menuImageView.kf.setImage(with: imageURL)
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        cell.bottomLabel.textColor = .mainBlueColor
        cell.bottomLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        cell.bottomLabel.text = "₩" + numberFormatter.string(from: NSNumber(value: apidata[indexPath.row].price))!
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}
