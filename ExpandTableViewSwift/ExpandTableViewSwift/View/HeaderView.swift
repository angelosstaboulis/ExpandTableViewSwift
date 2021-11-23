//
//  HeaderView.swift
//  ExpandTableViewSwift
//
//  Created by Angelos Staboulis on 24/11/21.
//

import Foundation
import UIKit
class HeaderView{
    static let shared = HeaderView()
    private init(){}
    func createHeader(section:Int,arrayHeader:[HeaderTitle])->UIView{
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 900, height: 55))
        view.isUserInteractionEnabled = true
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: 650, height: 55))
        label.text = arrayHeader[section].title
        view.addSubview(label)
        return view
    }
   
}
