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
    
    var groups: [Group] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
    }
    // MARK: - UITableViewDelegate, UITableViewDataSource
    extension AllGroupsViewController: UITableViewDelegate, UITableViewDataSource {

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            filteredGroups.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as? AllGroupsCell
            else {
                return UITableViewCell()
            }
            cell.configure(group: filteredGroups[indexPath.row])

            return cell
        }
    }

    // MARK: - UISearchBarDelegate
    extension AllGroupsViewController: UISearchBarDelegate {


        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

            let text = searchText.isEmpty ? " " : searchText
            filteredGroups = []
            service.loadGroupSearch(searchText: text) { [weak self] result in
                switch result {
                case .success(let group):
                    self?.filteredGroups = group
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                case .failure(let error):
                    print("\(error)")
                }
            }
        }
    }
