//
//  AddToDoVC.swift
//  ToDoListZag
//
//  Created by Mohamed Arafa on 2/21/20.
//  Copyright © 2020 SolxFy. All rights reserved.
//

import UIKit

protocol toDoItems {
    func addNewItem(item: getToDo)
}

class AddToDoVC: UIViewController {

    //MARK: - OutLet
    @IBOutlet weak var toDoTF: UITextField!{
        didSet{
         
                     toDoTF.layer.cornerRadius = toDoTF.frame.height / 2
            toDoTF.attributedPlaceholder = NSAttributedString(string: "Add To Do List", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(0.5)])
                 
              
             //   toDoTF.layer.cornerRadius = toDoTF.frame.height / 2
              //  toDoTF.layer.borderWidth = 1
               // toDoTF.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
    }
    @IBOutlet weak var addBtnOutLet: UIButton!{
        didSet{
            addBtnOutLet.layer.cornerRadius = addBtnOutLet.frame.height / 2
            addBtnOutLet.layer.borderWidth = 1
            addBtnOutLet.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    
    //MARK: - Constants
    
    var delegate: toDoItems?
    
    var myGetList: getToDo!
    
    static var flag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if AddToDoVC.flag == 1{
            delegate?.addNewItem(item: myGetList!)
            AddToDoVC.flag = 0
        }
        
    }
    
    //MARK: - IBActions
    
    @IBAction func addNewItemBtnPressed(_ sender: UIButton) {
        
        if toDoTF.text != ""{
            
            myGetList = getToDo(list: toDoTF.text!)
            
            AddToDoVC.flag = 1
            
            self.navigationController?.popViewController(animated: true)
        }else{
            
            let alert = UIAlertController(title: "Error", message: "Empty Text Field", preferredStyle: .alert)
            
            let alertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alert.addAction(alertAction)
            
            present(alert, animated: true, completion: nil)
            
        }
    }
    
    
    //MARK: - Helper Functions

    func setupUI(){
        
        navigationController?.navigationBar.prefersLargeTitles = false
        
    }
    
}
