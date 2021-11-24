//
//  DataManager.swift
//  ExpandTableViewSwift
//
//  Created by Angelos Staboulis on 24/11/21.
//

import Foundation
class DataManager{
    static let shared = DataManager()
    var array:[HeaderTitle] = []
    private init(){}
    func initialValues(completion:@escaping (([HeaderTitle])->()))
    {
        array.append(HeaderTitle(title: "Expanding row - 1.0"))
        array.append(HeaderTitle(title: "Expanding row - 2.0"))
        array.append(HeaderTitle(title: "Expanding row - 3.0"))
        array.append(HeaderTitle(title: "Expanding row - 4.0"))
        array.append(HeaderTitle(title: "Expanding row - 5.0"))
        completion(array)
    }
}
