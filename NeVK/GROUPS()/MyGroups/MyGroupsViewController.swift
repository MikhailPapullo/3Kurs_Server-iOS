//
//  TableViewController.swift
//  NeVK
//
//  Created by Mikhail Papullo on 12/3/21.
//

import UIKit

final class MyGroupsViewController: UITableViewController {
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        return session
    }()
	override func viewDidLoad() {
		super.viewDidLoad()
        getUserGroupList()
	}
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addGroup" {
            guard
                let groupsViewController = segue.source as? GroupsViewController
            else {
                return }

            }
        }
    }

	// MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		3
	}

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard
			let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupCell", for: indexPath) as? MyGroupsCell
		else {
			return UITableViewCell()
		}

		return cell
	}

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			tableView.deleteRows(at: [indexPath], with: .fade)
		}
	}
    private extension MyGroupsViewController {

        func getUserGroupList() {
            var urlConstructor = URLComponents()

            urlConstructor.scheme = "https"
            urlConstructor.host = "api.vk.com"
            urlConstructor.path = "/method/groups.get"
            urlConstructor.queryItems = [
                URLQueryItem(name: "access_token", value: SessionOrangeVK.instance.token),
                URLQueryItem(name: "user_id", value: String(SessionOrangeVK.instance.userId!)),
                URLQueryItem(name: "extended", value: "1"),
                URLQueryItem(name: "v", value: "5.131")
            ]

            guard let url = urlConstructor.url else {
                return
            }

            let request = URLRequest(url: url)
            let task = session.dataTask(with: request) { (data, response, error) in
                let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                print(">>> GET GROUP LIST: \(json)")
            }
            task.resume()
    }
}

