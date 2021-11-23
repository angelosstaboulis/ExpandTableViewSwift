//
//  ViewController.swift
//  ExpandTableViewSwift
//
//  Created by Angelos Staboulis on 22/11/21.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet var mainTableView: UITableView!
    var array:[HeaderTitle] = []
    var indexPathArray:[IndexPath]=[]
    var isExpanded:Bool!=false
    func initialValues(){
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.separatorStyle = .none
        array.append(HeaderTitle(title: "Expanding row - 1.0"))
        array.append(HeaderTitle(title: "Expanding row - 2.0"))
        array.append(HeaderTitle(title: "Expanding row - 3.0"))
        array.append(HeaderTitle(title: "Expanding row - 4.0"))
        array.append(HeaderTitle(title: "Expanding row - 5.0"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialValues()
        // Do any additional setup after loading the view.
    }
    
    
}
extension ViewController{
    func numberOfSections(in tableView: UITableView) -> Int {
        return  5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return createHeader(section:section, arrayHeader: array)
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isExpanded == false {
            return 0
        }
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if isExpanded {
            cell.textLabel?.text = "Expand row - " + String(indexPath.section+1) + "." + String(indexPath.row)
        }
        else{
            cell.textLabel?.text = array[indexPath.row].title
        }
        return cell
    }
    
    func createHeader(section:Int,arrayHeader:[HeaderTitle])->UIView{
        let view = HeaderView.shared.createHeader(section: section, arrayHeader: array)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(expandCell(sender:)))
        gesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(gesture)
        gesture.view?.tag = section
        return view
    }
    @objc func expandCell(sender:UITapGestureRecognizer){
        mainTableView.beginUpdates()
        let getSection = sender.view?.tag ?? 0
        indexPathArray.removeAll()
        for row in 0..<5{
            let indexPathNew = IndexPath(item: row , section: getSection)
            indexPathArray.append(indexPathNew)
        }
        mainTableView.deleteRows(at: indexPathArray, with: .fade)
        mainTableView.insertRows(at: indexPathArray, with: .fade)
        mainTableView.endUpdates()
        if isExpanded {
            isExpanded = false
            
        }
        else{
            isExpanded = true
        }
    }
}
