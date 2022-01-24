//
//  NewsLoader.swift
//  NeVK
//
//  Created by Mikhail Papullo on 12/14/21.
//

import UIKit

class NewsLoader {
    
    static func iNeedNews() -> [NewsModel] {
        return [NewsModel(name: "Мимимишки в Китае!", image: "mishki1"),
                NewsModel(name: "У мимимишек новость!", image: "mishki2")
        ]
    }
}
