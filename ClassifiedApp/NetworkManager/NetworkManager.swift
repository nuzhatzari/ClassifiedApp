//
//  NetworkManager.swift
//  ClassifiedApp
//
//  Created by Nuzhat Zari on 18/02/21.
//  Copyright © 2021 Nuzhat Zari. All rights reserved.
//

import UIKit

var APIKEY = ""

//APPError enum which shows all possible errors
enum APPError: Error {
    case networkError(Error)
    case dataNotFound(Error)
    case jsonParsingError(Error)
    case invalidStatusCode(Error)
}

//Result enum to show success or failure
enum APIResult<T> {
    case success(T)
    case failure(APPError)
}

class Response: NSObject, Decodable {
    
}

protocol ParseData {
    associatedtype outputData
    associatedtype inputData
    func parseDataFromServer(_ input: inputData) -> outputData
}


protocol NetworkManager: class {

    var baseUrl: String { get set }
    var route: String { get set }
    var method: String { get set }
    var body: [String: Any]? { get set }
    var headers: [String: String] { get set }
    
    func fetchData<T: Decodable>(completion: @escaping (APIResult<T>) -> Void)
    //objectType: T.Type,
}

extension NetworkManager {
    
    var baseUrl: String {
        get { return Bundle.main.apiBaseURL } set {}
    }
    var headers: [String: String] {
        get { return ["content-type": "application/json",
                      "Accept": "application/json"] }
        set {}
    }
    var route: String {
        get { return "" } set {}
    }
    var method: String {
        get { return "GET" } set {}
    }
    var body: [String : Any]? {
        get { return [:] } set {}
    }

    //objectType: T.Type
    func fetchData<T: Decodable>(completion: @escaping (APIResult<T>) -> Void) {
        
        let url = URL(string: "\(baseUrl.replacingOccurrences(of: "ROUTE", with: route).replacingOccurrences(of: "APIKEY", with: APIKEY))")!
        let urlRequest = NSMutableURLRequest(url: url)

        var jsonData: Data? = nil
        if let requestBody = body, let jsonBody = try? JSONSerialization.data(withJSONObject: requestBody, options: []) {
            jsonData = jsonBody
        }
        
        urlRequest.httpMethod = method
        switch method {
        case "GET":
            break
        default:
            if (jsonData != nil) {
                urlRequest.httpBody = jsonData
            }
        }
        
        for (key, value) in headers {
            urlRequest.setValue(value, forHTTPHeaderField:key)
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest as URLRequest) { data, response, error in

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {

                let userInfo = [
                    NSLocalizedDescriptionKey: NSLocalizedString("Error with the response: unexpected status code", comment: "")
                ]
                let error = NSError(domain: "NetworkingErrorDomain", code: 1001, userInfo: userInfo)
                completion(.failure(APPError.networkError(error)))
                return
            }

            if data == nil  {
                let defaultError = NSError(domain: "NetworkingErrorDomain", code: 1001, userInfo: [
                    NSLocalizedDescriptionKey: NSLocalizedString("Something went wrong.", comment: "")
                ])
                
                if let error = error {
                    completion(.failure(APPError.dataNotFound(error)))
                } else {
                    completion(.failure(APPError.dataNotFound(defaultError)))
                }

            } else {
            
                do {
                    //create decodable object from data
                    let json = try JSONDecoder().decode(T.self, from: data!)
                    completion(.success(json))
                } catch let error as NSError {
                    completion(.failure(APPError.jsonParsingError(error)))
                 }
            }
        }
        
        task.resume()
    }
}

extension Bundle {
    var apiBaseURL: String {
        return object(forInfoDictionaryKey: "BaseURL") as? String ?? ""
    }
}
