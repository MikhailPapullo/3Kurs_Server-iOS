//
//  FriendService.swift
//  NeVK
//
//  Created by Mikhail Papullo on 1/13/22.
//

import Foundation

enum FriendsError: Error {
    case parseError
    case requestError(Error)
}

fileprivate enum TypeMethods: String {
    case friendsGet = "/method/friends.get"
}

fileprivate enum TypeReqests: String {
    case get = "GET"
    case post = "POST"
}

final class FriendService {
    private  let scheme = "https"
    private let host = "api.vk.com"
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        return session
    }()
    
    func loadFriend(complition: @escaping ((Result<FriendsVK, FriendsError>) -> ())) {
        guard let token = SessionOrangeVK.instance.token else {
            return
        }
        let params: [String: String] = ["v": "5.81",
                                        "access_token": token,
                                        "fields": "photo_50"
        ]
        
        let url = configureUrl(token: token,
                               method: .friendsGet,
                               htttpMethod: .get,
                               params: params)
        print(url)
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                return complition(.failure(.requestError(error)))
            }
            
            guard let data = data else { return }
            let decoder = JSONDecoder()
            
            do {
                let result = try decoder.decode(FriendsVK.self, from: data)
                print(result)
                return complition(.success(result))
            } catch {
                return complition(.failure(.parseError))
            }
        }
        task.resume()
    }
}

private extension FriendService {
    func configureUrl(token: String,
                      method: TypeMethods,
                      htttpMethod: TypeReqests,
                      params: [String: String]) -> URL {
        var queryItems = [URLQueryItem]()
        queryItems.append(URLQueryItem(name: "access_token", value: token))
        queryItems.append(URLQueryItem(name: "v", value: "5.131"))
        
        for(param, value) in params {
            queryItems.append(URLQueryItem(name: param, value: value))
        }
        
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = method.rawValue
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            fatalError("URL is invalid")
        }
        return url
    }
}
