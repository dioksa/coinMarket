//
//  RequestExecution.swift
//  CoinMarket
//
//  Created by Oksana Dionisieva on 15.04.2022.
//

import Foundation

typealias GenericResponse<T> = (T) -> Void

protocol RequestExecution {
    func execute<T: Codable>(_ request: URLRequest, completion: @escaping (Result<T, Error>) -> Void)
}

extension RequestExecution {
    func execute<T: Codable>(_ request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
        commonExecute(request, success: { successData in
            do {
                let successModel = try JSONDecoder().decode(T.self, from: successData)
                completion(.success(successModel))
            } catch let error {
                print(error)
                completion(.failure(error))
            }
        }, failure: { errorData in
            // TODO: - Here should be 'do' -> 'catch' case
        })
    }
}


// MARK: - Extension
private extension RequestExecution {
    func commonExecute(_ request: URLRequest, success: @escaping GenericResponse<Data>, failure: @escaping GenericResponse<Data>) {
        
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            DispatchQueue.main.async {
                if let httpResponse = response as? HTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200, 201:
                        success(data!)
                    default:
                        failure(data!)
                    }
                }
            }
        }).resume()
    }
}
