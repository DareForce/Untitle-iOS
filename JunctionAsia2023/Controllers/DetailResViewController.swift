//
//  DetailResViewController.swift
//  JunctionAsia2023
//
//  Created by 최지철 on 2023/08/19.
//

import UIKit

class DetailResViewController: BaseViewController {
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
    public var topVIew = UIView().then{
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
}
extension DetailResViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5

    }    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130

    }
    
}
