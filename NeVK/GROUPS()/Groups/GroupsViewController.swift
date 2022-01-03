//
//  GroupsViewController.swift
//  NeVK
//
//  Created by Mikhail Papullo on 12/3/21.
//

import UIKit

    final class GroupsViewController: UITableViewController {
        
        var groups = GroupsLoader.iNeedGroups()

    override func viewDidLoad() {
        super.viewDidLoad()

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

        let name = groups[indexPath.row].name
        let avatar = groups[indexPath.row].avatar
      
        cell.configure(name: name, avatar: UIImage(named: avatar)!)

        return cell
    }
}
