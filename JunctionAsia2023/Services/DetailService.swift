//
//  DetailService.swift
//  JunctionAsia2023
//
//  Created by 최지철 on 2023/08/20.
//

import Foundation
import Alamofire
struct MenuResponse: Codable {
    let message: String
    let status: Int
    let data: [MenuData]
}

struct MenuData: Codable {
    let menuId: Int
    let name: String
    let thumbnail: String
    let ingredients: [String]
    let price: Int
}
class DetailService{
    func getAllBrand(restaurantId: Int ,completion: @escaping (Result<MenuResponse, Error>) -> Void) {
        let url = "http://13.125.216.62:8080/api/v1/restaurant/\(restaurantId)/menu?userId=4"
        AF.request(url).responseDecodable(of: MenuResponse.self) { response in
            switch response.result {
            case .success(let brandList):
                completion(.success(brandList))
            case .failure(let error):
                print("오류:",error)
            }
        }
    }
}
