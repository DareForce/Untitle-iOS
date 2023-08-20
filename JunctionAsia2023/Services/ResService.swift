//
//  ResService.swift
//  JunctionAsia2023
//
//  Created by 최지철 on 2023/08/20.
//

import Foundation
import Alamofire
struct ResResponse: Codable {
    let message: String
    let status: Int
    let data: [RestaurantData]
}
struct RestaurantData: Codable {
    let restaurantId: Int
    let name: String
    let category: String
    let thumbnail: String?
    let menus: [String]
}
class ResService{
    func getAllBrand(completion: @escaping (Result<ResResponse, Error>) -> Void) {
        let url = "http://13.125.216.62:8080/api/v1/restaurant"
        AF.request(url).responseDecodable(of: ResResponse.self) { response in
            switch response.result {
            case .success(let brandList):
                completion(.success(brandList))
            case .failure(let error):
                print("오류:",error)
            }
        }
    }
}
