//
//  ApiManager.swift
//  Nupi
//
//  Created by narong on 2/10/25.
//

import Alamofire
import Foundation

class ApiManager {
    static let shared = ApiManager() 
    private init() {}
    
    
    private var baseURL: String {
        guard let url = Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") as? String else {
            fatalError("🚨 API_BASE_URL이 Info.plist에 없습니다!")
        }
        return url
    }

    func fetchRouteStores(cursor: Int? = nil, completion: @escaping (Result<[RouteStore], Error>) -> Void) {
        let url = "\(baseURL)/stores/around"
        var parameters: [String: Any] = [:]
        
        if let cursor = cursor {
            parameters["cursor"] = cursor
        }
        
            AF.request(url, method: .get)
                .validate()
                .responseDecodable(of: RouteStoreResponse.self) { response in
                    switch response.result {
                    case .success(let data):
                        if data.isSuccess {
                            completion(.success(data.result.storeList))
                        } else {
                            let error = NSError(domain: "com.nupi.api", code: -1, userInfo: [NSLocalizedDescriptionKey: data.message])
                            completion(.failure(error))
                        }
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
    }
}
