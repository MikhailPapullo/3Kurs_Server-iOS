//
//  CacheTestViewController.swift
//  NeVK
//
//  Created by Mikhail Papullo on 1/20/22.
//

import UIKit
import SwiftKeychainWrapper

class CacheTestViewController: UIViewController {
    
    let userDefault = UserDefaults.standard
    let keyChain = KeychainWrapper.standard
    let coreDataService = CoreDataServiceManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        userDefault.set("red", forKey: ColorString.userDefaultsKey)
//        keyChain.set("red", forKey: ColorString.userDefaultsKey)
        keyChain.removeObject(forKey: ColorString.userDefaultsKey)
//        saveUser()
        loadUser()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        guard let backgroundColor = userDefault.string(forKey: ColorString.userDefaultsKey) else { return }
        guard let backgroundColor = keyChain.string(forKey: ColorString.userDefaultsKey) else { return }
        let color = ColorString.init(rawValue: backgroundColor)?.color
        view.backgroundColor = color
    }
}

extension CacheTestViewController {
    func saveUser() {
        let context = coreDataService.persistantContainer.viewContext
        let newHuman = Human(context: context)
        
        newHuman.age = 28
        newHuman.birthday = Date()
        newHuman.name = "Alena"
        coreDataService.saveContext()
        print(context)
    }
    
    func loadUser() {
        let context = coreDataService.persistantContainer.viewContext
        let results = try! context.fetch(Human.fetchRequest()) as! [Human]
        let human = results.first
        print(human)
        
    }
}

enum ColorString: String {
    case red = "red"
    case blue = "blue"
    case yellow = "yellow"
    
    static let userDefaultsKey = "color"
    
    var color: UIColor {
        switch self {
        case .red: return .red
        case .blue: return .blue
        case .yellow: return .yellow
        default: return .white
        }
    }
}
