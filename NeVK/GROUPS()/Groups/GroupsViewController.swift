//
//  GroupsViewController.swift
//  NeVK
//
//  Created by Mikhail Papullo on 12/3/21.
//

import UIKit

final class GroupsViewController: UITableViewController {
    
    private let service = GroupsService()
    private let serviceImage = FriendsServiceManager()
    
    private var groups: [Group] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchGroups()
        
    }
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as? GroupsViewCell
        else {
            return UITableViewCell()
        }
        
        serviceImage.loadImage(url:groups[indexPath.row].photo100) { image in
            cell.groupAvatar.image = image
        }
        cell.groupName.text = groups[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let group = groups[indexPath.row]
        navigationController?.popViewController(animated: true)
    }
}

private extension GroupsViewController {
    func fetchGroups() {
        service.loadGroups { [weak self] model in
            switch model {
            case .success(let group):
                DispatchQueue.main.async {
                    self?.groups = group
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("\(error)")
            }
        }
    }
}
