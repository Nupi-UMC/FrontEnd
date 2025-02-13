//
//  API+Extension.swift
//  Nupi
//
//  Created by Dana Lim on 1/15/25.
//

import Alamofire
import Foundation

// APIClient 클래스 정의
class APIClient {
    static let shared = APIClient()         // 앱 어디에서든 접근 가능하도록 설정
    private init() {}
}

extension APIClient {
    
    // Base URL 설정
    private static let baseURL = "https://api-nupi.shop"

    // MARK: Headers
    // 기본 json형식에 맞는 헤더 생성 함수
     static func getHeaders() -> HTTPHeaders {
        
         var headers: HTTPHeaders = [
            "accept": "*/*",
            "Content-Type": "application/json"
        ]
         if let accessToken = KeychainService.load(for: "accessToken") {
            headers["Authorization"] = "Bearer \(accessToken)"
        }
        return headers
    }
    
    // multipart/form-data에 맞는 헤더 생성 함수
    private static func getMultipartHeaders(withToken token: String? = nil) -> HTTPHeaders {
        var headers: HTTPHeaders = [
            "accept": "*/*",
            "Content-Type": "multipart/form-data"
        ]
        if let token = token {
            headers["Authorization"] = "Bearer \(token)"
        }
        return headers
    }
    
    // MARK: GET
    // 공통 GET 요청 함수
    static func getRequest<T: Decodable>(endpoint: String, token: String? = nil, completion: @escaping (Result<T, AFError>) -> Void) {
        let url = "\(baseURL)\(endpoint)"
        let headers = getHeaders()
        
        AF.request(url, method: .get, headers: headers).responseDecodable(of: T.self) { response in
            handleResponse(response, endpoint: endpoint, completion: completion)
        }
    }
    
    // 공통 GET 요청 함수 (parameters 추가)
    static func getRequest<T: Decodable>(endpoint: String, parameters: [String: Any]? = nil, token: String? = nil, completion: @escaping (Result<T, AFError>) -> Void) {
        let url = "\(baseURL)\(endpoint)"
        let headers = getHeaders()
        
        AF.request(url, method: .get, parameters: parameters, headers: headers).responseDecodable(of: T.self) { response in
            handleResponse(response, endpoint: endpoint, completion: completion)
        }
    }
    
    // MARK: POST
    // 공통 POST 요청 함수
    static func postRequest<T: Decodable, U: Encodable>(endpoint: String, parameters: U, token: String? = nil, completion: @escaping (Result<T, AFError>) -> Void) {
        let url = "\(baseURL)\(endpoint)"
        let headers = getHeaders()
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).responseDecodable(of: T.self) { response in
            completion(response.result)
        }
    }
    
    // 공통 POST 요청 함수 (parameters가 필요없을 때)
    static func postRequestWithoutParameters<T: Decodable>(endpoint: String, token: String? = nil, completion: @escaping (Result<T, AFError>) -> Void) {
        let url = "\(baseURL)\(endpoint)"
        let headers = getHeaders()
        
        AF.request(url, method: .post, headers: headers).responseDecodable(of: T.self) { response in
            completion(response.result)
        }
    }
    
    // 이미지 업로드 POST 요청 함수
    static func postImageRequest<T: Decodable>(endpoint: String, imageData: Data, token: String? = nil, completion: @escaping (Result<T, AFError>) -> Void) {
        let url = "\(baseURL)\(endpoint)"
        let headers = getMultipartHeaders(withToken: token)
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "uploadFiles", fileName: "image.jpeg", mimeType: "image/jpeg")
        }, to: url, method: .post, headers: headers)
        .responseDecodable(of: T.self) { response in
            completion(response.result)
        }
    }
    
    // MARK: PUT
    // PUT 요청 함수
    static func putRequest<T: Decodable, U: Encodable>(endpoint: String, parameters: U, token: String? = nil, completion: @escaping (Result<T, AFError>) -> Void) {
        
        let url = "\(baseURL)\(endpoint)"
        let headers = getHeaders()
        
        AF.request(url, method: .put, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).responseDecodable(of: T.self) { response in
            completion(response.result)
        }
    }
    
    // 공통 DELETE 요청 함수
    static func deleteRequest<T: Decodable>(endpoint: String, token: String? = nil, completion: @escaping (Result<T, AFError>) -> Void) {
        let url = "\(baseURL)\(endpoint)"
        let headers = getHeaders()
        
        AF.request(url, method: .delete, headers: headers).responseDecodable(of: T.self) { response in
            completion(response.result)
        }
    }
    
    // MARK: PATCH
    // 공통 PATCH 요청 함수 (parameters 추가)
    static func patchRequest<T: Decodable, U: Encodable>(endpoint: String, parameters: U, token: String? = nil, completion: @escaping (Result<T, AFError>) -> Void) {
        let url = "\(baseURL)\(endpoint)"
        let headers = getHeaders()
        
        AF.request(url, method: .patch, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).responseDecodable(of: T.self) { response in
            completion(response.result)
        }
    }
    
    // 공통 PATCH 요청 함수 (parmeters가 필요없을때)
    static func patchRequestWithoutParameters<T: Decodable>(endpoint: String, token: String? = nil, completion: @escaping (Result<T, AFError>) -> Void) {
        let url = "\(baseURL)\(endpoint)"
        let headers = getHeaders()
        
        AF.request(url, method: .patch, headers: headers).responseDecodable(of: T.self) { response in
            completion(response.result)
        }
    }
    private static func handleResponse<T: Decodable>(
            _ response: AFDataResponse<T>,
            endpoint: String,
            parameters: [String: Any]? = nil,
            completion: @escaping (Result<T, AFError>) -> Void
        ) {
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                if response.response?.statusCode == 401 {
                    print("Access Token 만료, Refresh Token으로 재발급 시도")
                    FCMTokenManager.shared.refreshAccessToken { newToken in
                        guard let newToken = newToken else {
                            print("Refresh Token도 만료됨. 재로그인 필요")
                            completion(.failure(error))
                            return
                        }
                        print("새로운 Access Token 발급 완료. API 재요청")
                        
                        // 새로운 토큰으로 재요청
                        let headers = getHeaders()
                        AF.request("\(baseURL)\(endpoint)", method: .get, parameters: parameters, headers: headers)
                            .responseDecodable(of: T.self) { retryResponse in
                                completion(retryResponse.result)
                            }
                    }
                } else {
                    completion(.failure(error))
                }
            }
        }
    
}

extension APIClient {
    // 나의 경로 API
    static func fetchMyRoutes(
        memberId: Int,
        myRoute: String,
        completion: @escaping (Result<MyRouteResponse, AFError>) -> Void)
    {
        let endpoint = "/api/home/\(memberId)/route?myRoute=\(myRoute)"
        getRequest(endpoint: endpoint, completion: completion)
    }
    
    // 놀거리 탐색 API
    static func fetchSearchStores(
        memberId: Int,
        latitude: Double,
        longitude: Double,
        category: Int,
        sort: String,
        completion: @escaping (Result<StoreResponse, AFError>) -> Void)
    {
        let endpoint = "/api/home/\(memberId)/search?latitude=\(latitude)&longitude=\(latitude)&category=\(category)&sort=\(sort)"
        getRequest(endpoint: endpoint, completion: completion)
    }
    
    // 뭐하고 놀지? API
    static func fetchWhatToPlay(
        groupName: String,
        completion: @escaping (Result<StoreResponse, AFError>) -> Void)
    {
        let endpoint = "/api/home/\(groupName))"
        
        print("[DEBUG] 요청 URL: \(endpoint)")
        getRequest(endpoint: endpoint, completion: completion)
    }
    // 어디서 놀지? API
    static func fetchWhereToPlay(
        //memberId: Int,
        regionId: Int,
        latitude: Double,
        longitude: Double,
        category: Int,
        sort: String,
        completion: @escaping (Result<StoreResponse, AFError>) -> Void)
    {
        let endpoint = "/api/home/\(regionId)?latitude=\(latitude)&longitude=\(longitude)&category=\(category)&sort=\(sort)"
        
        print("[DEBUG] 요청 URL: \(endpoint)")
        getRequest(endpoint: endpoint, completion: completion)
    }
}
