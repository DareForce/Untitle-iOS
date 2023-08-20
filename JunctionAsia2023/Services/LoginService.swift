//
//  LoginService.swift
//  JunctionAsia2023
//
//  Created by 최지철 on 2023/08/20.
//

import Foundation
import Alamofire
struct ResponseData: Codable {
    let message: String
    let status: Int
    let data: UserData
}

struct UserData: Codable {
    let userId: Int
}
class Login {
    func postLogin(gender:String, name:String,allergies:[String],addtional:[String],comletion: @escaping(Result<ResponseData,Error>) -> Void) {
        let url = "http://13.125.216.62:8080/api/v1/user/signUp"
        let parameter: Parameters = [
            "gender" : gender,
            "name" : name,
            "allergies" : allergies,
            "addtional" : addtional,
        ]
        AF.request(url,
                   method: .post,
                   parameters: parameter,
                   encoding: JSONEncoding.default).responseDecodable(of: ResponseData.self) { response in
            switch response.result {
            case.success(let response) :
                comletion(.success(response))
                print(response)
            case.failure(let error) :
                comletion(.failure(error))
                if let data = response.data, let jsonString = String(data: data, encoding: .utf8) {
                    print("Response JSON: \(jsonString)")
                }
            }
            
        }
    }
}
