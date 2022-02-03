//
//  TableViewController.swift
//  NeVK
//
//  Created by Mikhail Papullo on 12/3/21.
//

import UIKit
import RealmSwift

final class MyGroupsViewController: UITableViewController {
    
    private let service = GroupsService()
    private lazy var realm = RealmCacheService()
    private var groupResponse: Results<Group>? {
        realm.read(Group.self)
    }

    private var notificationToken: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createNotificationGroupToken()
        getUserGroupList()
    }
}

	// MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupResponse?.count ?? 0
	}

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard
			let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupCell", for: indexPath) as? MyGroupsCell
		else {
			return UITableViewCell()
		}
        if let groups = groupResponse {
            cell.configure(group: groups[indexPath.row])
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
            service.loadGroups { result in
                switch result {
                case .success(_):
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print("\(error)")
                }
            }
        }

        func createNotificationGroupToken() {
            notificationToken = groupResponse?.observe{ [weak self] result in
                guard let self = self else { return }
                switch result {
                case .initial(let groupsData):
                    print("init with \(groupsData.count) groups")
                case .update(let groups,
                             deletions: let deletetions,
                             insertions: let insertions,
                             modifications: let modifications):
                    print("""
    new count \(groups.count)
    deletions \(deletetions)
    insertions \(insertions)
    modifications \(modifications)
    """)
                    let deletionsIndexPath = deletetions.map { IndexPath(row: $0, section: $0) }
                    let insertionsIndexPath = insertions.map { IndexPath(row: $0, section: $0) }
                    let modificationsIndexPath = modifications.map { IndexPath(row: $0, section: $0) }

                    DispatchQueue.main.async {

                        self.tableView.beginUpdates()

                        self.tableView.deleteRows(at: deletionsIndexPath, with: .automatic)

                        self.tableView.insertRows(at: insertionsIndexPath, with: .automatic)

                        self.tableView.reloadRows(at: modificationsIndexPath, with: .automatic)

                        self.tableView.endUpdates()
                    }
                case .error(let error):
                    print("\(error)")
                }
            }
        }
    }

