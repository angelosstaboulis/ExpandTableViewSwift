//
//  ViewModel.swift
//  ExpandTableViewSwift
//
//  Created by Angelos Staboulis on 24/11/21.
//

import Foundation
class ViewModel{
    var sharedData:DataManager
    var arrayTitles:[HeaderTitle] = []
    init(){
        sharedData = DataManager.shared
    }
    func fetchInitialValues(completion:@escaping ([HeaderTitle])->()){
        sharedData.initialValues { array in
            self.arrayTitles.append(contentsOf: array)
            completion(self.arrayTitles)
        }
    }
}
