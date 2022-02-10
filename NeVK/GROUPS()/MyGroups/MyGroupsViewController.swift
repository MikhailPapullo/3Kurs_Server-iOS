//
//  TableViewController.swift
//  NeVK
//
//  Created by Mikhail Papullo on 12/3/21.
//

import UIKit
import FirebaseDatabase
import RealmSwift

final class MyGroupsViewController: UITableViewController {
    
    private let service = GroupsService()
    private lazy var realm = RealmCacheService()
    
    private var groupResponse: Results<Group>? {
        realm.read(Group.self)
    }

    private var communitiesFirebase = [FirebaseCommunity]()
    private let ref = Database.database().reference(withPath: "Communities")
    
    private var notificationToken: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createNotificationGroupToken()
        getUserGroupList()
        ref.observe(.value, with: { snapshot in
            var communities: [FirebaseCommunity] = []
            
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let group = FirebaseCommunity(snapshot: snapshot) {
                    communities.append(group)
                }
            }
            print("Обновлен список добавленных групп")
            communities.forEach { print($0.groupName) }
            print(communities.count)
            
        })
    }

    @IBAction func addGroup(segue: UIStoryboardSegue) {
        if segue.identifier == "addCommunitySegue" {
            let allCommunityController = segue.source as! AllGroupsViewController
            if let indexPath = allCommunityController.tableView.indexPathForSelectedRow {
                let community = allCommunityController.filteredGroups[indexPath.row]
                service.addGroup(idGroup: community.id) { [weak self] result in
                    switch result {
                    case .success(let success):
                        if success.response == 1 {
                            let fireCom = FirebaseCommunity(name: community.name, id: community.id)
                            let comRef = self?.ref.child(community.name.lowercased())
                            comRef?.setValue(fireCom.toAnyObject())
                        }
                    case .failure(let error):
                        print("\(error)")
                    }
                }
            }
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension MyGroupsController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupResponse?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? MyGroupCell
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
//            myGroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

private extension MyGroupsController {

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
                let deletionsIndexPath = deletetions.map { IndexPath(row: $0, section: 0) }
                let insertionsIndexPath = insertions.map { IndexPath(row: $0 , section: 0) }
                let modificationsIndexPath = modifications.map { IndexPath(row: $0, section: 0) }

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
