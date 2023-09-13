//
//  DetailResViewController.swift
//  JunctionAsia2023
//
//  Created by 최지철 on 2023/08/19.
//

import UIKit
import Then

class DetailResViewController: BaseViewController {
    var id:Int?
    private var apidata:[MenuData] = []
    private let api = DetailService()
    var ressubLabel = UILabel().then{
        $0.text = "School|Food"
        $0.textColor = .selectedButtonTitleColor
        $0.font = UIFont.boldSystemFont(ofSize: 20)
    }
    var resNameLabel = UILabel().then{
        $0.text = "Restaurant"
        $0.textColor = .white
        $0.font = UIFont.boldSystemFont(ofSize: 34)
    }
    private let tableView = UITableView().then{
        $0.backgroundColor = UIColor.white
        $0.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
    }
    public var topVIew = UIImageView().then{
        $0.backgroundColor = .red
    }
    override func layout(){
        self.ressubLabel.snp.makeConstraints{
            $0.top.equalTo(resNameLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(33)
        }
        self.resNameLabel.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-55)
            $0.leading.equalToSuperview().offset(33)
        }
        self.tableView.snp.makeConstraints{
            $0.top.equalTo(topVIew.snp.bottom).offset(0)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()

        }
        self.topVIew.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(334)
        }
    }
    private func addsubview(){
        self.topVIew.addSubview(ressubLabel)
        self.topVIew.addSubview(resNameLabel)
        self.view.addSubview(topVIew)
        self.view.addSubview(tableView)
    }
    override func configure(){
        self.addsubview()
        self.tableView.delegate = self
        self.tableView.dataSource = self

    }
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
}
extension DetailResViewController: UITableViewDelegate, UITableViewDataSource{
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
            let ingredients = apidata[indexPath.row].ingredients
            
            cell.midLabel.text = "⚠️ "
            ingredients.forEach {
                cell.midLabel.text! += "\($0) "
            }
        }
        
        if let imageURL = URL(string: apidata[indexPath.row].thumbnail ){
            cell.menuImageView.kf.setImage(with: imageURL)
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        cell.bottomLabel.textColor = .mainBlueColor
        cell.bottomLabel.font = UIFont.boldSystemFont(ofSize: 17)
        cell.bottomLabel.text = "₩" + numberFormatter.string(from: NSNumber(value: apidata[indexPath.row].price))!
//        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "May I take your order?", message: nil, preferredStyle: .alert)
        let orderButton = UIAlertAction(title: "Order", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        let cancelButton = UIAlertAction(title: "No", style: .destructive)
        alert.addAction(orderButton)
        alert.addAction(cancelButton)
        
        present(alert, animated: true)
        print(indexPath)
    }
}
