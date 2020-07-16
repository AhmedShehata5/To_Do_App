//
//  ViewController.swift
//  ToDoListZag
//
//  Created by Mohamed Arafa on 2/21/20.
//  Copyright © 2020 SolxFy. All rights reserved.
//

import UIKit
import DGElasticPullToRefresh

class ToDoListVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var toDoArr: [getToDo] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.separatorStyle = .none
        setupUI()
        pullToRefresh()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
  tableView.separatorStyle = .none
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
          tableView.separatorStyle = .none
        tableView.dg_removePullToRefresh()
    }

    //MARK: - IBAction
    
    
    @IBAction func goToAddVC(_ sender: UIBarButtonItem) {
        let addVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "AddToDoVC") as! AddToDoVC
              addVC.delegate = self
              self.navigationController?.pushViewController(addVC, animated: true)
        
      
    }
    @IBAction func upBtnPressed(_ sender: UIButton) {
        if sender.tag != 0{
              
                 toDoArr.swapAt(sender.tag, sender.tag - 1)
                 tableView.reloadData()
             }
    }
    
    @IBAction func downBtnPressed(_ sender: UIButton) {
        if sender.tag != toDoArr.count - 1{
                
                toDoArr.swapAt(sender.tag, sender.tag + 1)
                tableView.reloadData()
            }
    }
    

    
    //MARK: - Helper Functions
    
    func setupUI(){
        
        //tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    func pullToRefresh(){
        
        // Initialize tableView
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tableView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
            // Add your logic here
            print("Reload")
            // Do not forget to call dg_stopLoading() at the end
            self?.tableView.dg_stopLoading()
        }, loadingView: loadingView)
        tableView.dg_setPullToRefreshFillColor(#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1))
        tableView.dg_setPullToRefreshBackgroundColor(tableView.backgroundColor!)
    }

}

extension ToDoListVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ToDoListTVC
        
        cell.orderlistLbl.text = toDoArr[indexPath.row].list
        
        cell.upBtnOutLet.tag = indexPath.row
        cell.downBtnOutLet.tag = indexPath.row
        
        cell.upBtnOutLet.addTarget(self, action: #selector(self.upBtnPressed(_:)), for: .touchUpInside)
        cell.downBtnOutLet.addTarget(self, action: #selector(self.downBtnPressed(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.SCREENHeight / 12
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .normal, title: "Delete") { (action, view, completion) in
            
            self.toDoArr.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
        
        delete.image = #imageLiteral(resourceName: "pin")
        delete.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        
        
        let swip = UISwipeActionsConfiguration(actions: [delete])
        swip.performsFirstActionWithFullSwipe = false
        return swip
    }
}

extension ToDoListVC: toDoItems{
    
    func addNewItem(item: getToDo) {
        toDoArr.append(item)
        tableView.reloadData()
    }

}

