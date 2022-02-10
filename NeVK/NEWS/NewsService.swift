//
//  NewsService.swift
//  NeVK
//
//  Created by Mikhail Papullo on 2/8/22.
//

import Foundation
import RealmSwift

enum NewsError: Error {
    case parseError
    case requestError(Error)
}

fileprivate enum TypeMethods: String {
    case newsGet = "/method/groups.get"
    case newsSearch = "/method/groups.search"
}

fileprivate enum TypeRequests: String {
    case get = "GET"
    case post = "POST"
}

class NewsService {
    
    private var realm = RealmCacheService()
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        return session
    }()

    private let scheme = "https"
    private let host = "api.vk.com"
    private let cacheKey = "news"

    private let decoder = JSONDecoder()

    func loadNews(completion: @escaping (Result<[News], NewsError>) -> Void) {
        
        if checkExpiry(key: cacheKey) {
            guard let realm = try? Realm() else { return }
            let news = realm.objects(News.self)
            
            if !news.isEmpty {
                completion(.success(groupsArray))
                return
            }
        }
            
        guard let token = SessionOrangeVK.instance.token else { return }
        let params: [String: String] = ["extended": "1"]
        
        let url = configureUrl(token: token,
                               method: .newsGet,
                               htttpMethod: .get,
                               params: params)
        print(url)
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                return completion(.failure(.requestError(error)))
            }
            guard let data = data else {
                return
            }
            do {
                let result = try self.decoder.decode(SearchGroup.self, from: data).response.items
                
                DispatchQueue.main.async {
                    self.realm.create(result)
                }

                return completion(.success(result))
            } catch {
                completion(.failure(.parseError))
            }
        }
        task.resume()
    }

    func loadnewsSearch(searchText: String, completion: @escaping(Result<[News], NewsError>) -> Void) {
        guard let token = SessionOrangeVK.instance.token else { return }
        let params: [String: String] = ["extended": "1",
                                        "q": searchText,
                                        "count": "40"]
        let url = configureUrl(token: token,
                               method: .newsSearch,
                               htttpMethod: .get,
                               params: params)
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                return completion(.failure(.requestError(error)))
            }
            guard let data = data else {
                return
            }
            do {
                let result = try self.decoder.decode(SearchNews.self, from: data)
                return completion(.success(result.response.items))
            } catch {
                return completion(.failure(.parseError))
            }
        }
        task.resume()
    }
}

private extension GroupsService {

    func setExpiry(key: String, time: Double) {
        let date = (Date.init() + time).timeIntervalSince1970
        UserDefaults.standard.set(String(date), forKey: key)
    }

    func checkExpiry(key: String) -> Bool {
        let expiryDate = UserDefaults.standard.string(forKey: key) ?? "0"
        let currentDate = String(Date.init().timeIntervalSince1970)

        if expiryDate > currentDate {
            return true
        } else {
            return false
        }
    }

    func configureUrl(token: String,
                      method: TypeMethods,
                      htttpMethod: TypeRequests,
                      params: [String: String]) -> URL {
        var queryItems = [URLQueryItem]()
        queryItems.append(URLQueryItem(name: "access_token", value: token))
        queryItems.append(URLQueryItem(name: "v", value: "5.131"))

        for (param, value) in params {
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


