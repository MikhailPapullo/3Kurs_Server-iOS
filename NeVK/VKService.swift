//
//  VKService.swift
//  NeVK
//
//  Created by Mikhail Papullo on 1/10/22.
//

import UIKit
import WebKit
import Alamofire

class VKService: UIViewController {
    
    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    
    var session = SessionOrangeVK.instance
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAuth()
    }
}

private extension VKService {
    func loadAuth() {
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "8047697"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "offline, friends, photos, groups"),
            URLQueryItem(name: "response_type", value: "token"),
        ]
        let request = URLRequest(url: urlComponents.url!)
        webView.load(request)
    }
}

extension VKService: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationResponse: WKNavigationResponse,
                 decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url,
              url.path == "/blank.html",
              let fragment = url.fragment
        else {
            decisionHandler(.allow)
            return
        }
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=")}
            .reduce([String:String]()) {result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        if let token = params["access_token"], let userId = params["user_id"] {
            session.token = token
            session.userId = Int(userId)!
            print(token)
            print(userId)
            decisionHandler(.cancel)
            performSegue(withIdentifier: "login", sender: self)
            
        }
    }
}
