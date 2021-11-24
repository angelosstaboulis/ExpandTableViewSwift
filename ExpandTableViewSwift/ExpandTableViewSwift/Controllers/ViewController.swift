//
//  ViewController.swift
//  ExpandTableViewSwift
//
//  Created by Angelos Staboulis on 22/11/21.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet var mainTableView: UITableView!
    var viewmodel:ViewModel!
    var indexPathArray:[IndexPath]=[]
    var isExpanded:Bool!=false
    override func viewDidLoad() {
        super.viewDidLoad()
        initialView()
        // Do any additional setup after loading the view.
    }
    
    
}
extension ViewController{
    func initialView(){
        mainTableView.delegate = self
        mainTableView.dataSource = self
        viewmodel = ViewModel()
        viewmodel.fetchInitialValues { array in
            self.mainTableView.reloadData()
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return  5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewmodel.arrayTitles.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = createHeader(section:section, arrayHeader: viewmodel.arrayTitles)
        view.bringSubviewToFront(mainTableView)
        return view
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
            cell.textLabel?.text = viewmodel.arrayTitles[indexPath.row].title
        }
        return cell
    }
    
    func createHeader(section:Int,arrayHeader:[HeaderTitle])->UIView{
        let view = HeaderView.shared.createHeader(section: section, arrayHeader: viewmodel.sharedData.array)
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
