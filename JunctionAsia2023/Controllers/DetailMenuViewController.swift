//
//  DetailMenuViewController.swift
//  JunctionAsia2023
//
//  Created by 최지철 on 2023/08/20.
//

import UIKit

class DetailMenuViewController: BaseViewController {
    public var id:Int?
    private var apidata:[MenuData] = []
    private let api = DetailService()
    public var ressubLabel = UILabel().then{
        $0.text = "School|Food"
        $0.textColor =  UIColor(hexString: "#FFFFFF", alpha: 0.6)
        $0.font = UIFont.boldSystemFont(ofSize: 20)
    }
    public var resNameLabel = UILabel().then{
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
extension DetailMenuViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apidata.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        
        cell.resNameLabel.text = apidata[indexPath.row].name
        cell.resNameLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        
        if apidata[indexPath.row].ingredients.isEmpty {
            cell.titleLabel.text = ""
        } else {
            cell.titleLabel.text = "⚠️ " + apidata[indexPath.row].ingredients[0]
        }
        
        if let imageURL = URL(string: apidata[indexPath.row].thumbnail) {
            cell.img.kf.setImage(with: imageURL)
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        cell.subtitleLabel.textColor =  UIColor(hexString: "#3E24FF")
        cell.subtitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        cell.subtitleLabel.text = "₩" + numberFormatter.string(from: NSNumber(value: apidata[indexPath.row].price))!
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }

}
