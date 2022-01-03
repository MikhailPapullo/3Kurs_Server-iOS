//
//  NewsController.swift
//  NeVK
//
//  Created by Mikhail Papullo on 12/11/21.
//

import UIKit

    final class NewsController: UITableViewController {
    var news = NewsLoader.iNeedNews()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CustomNewsCell", bundle: nil), forCellReuseIdentifier: "NewsCellId")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCellId", for: indexPath) as? CustomNewsCell
            else {
                return UITableViewCell()
            }
            
        let name = news[indexPath.row].name
        let image = news[indexPath.row].image
        
        cell.configure(name: name, image: UIImage(named: image)!)
            return cell
        }
        
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 517
    }
}
