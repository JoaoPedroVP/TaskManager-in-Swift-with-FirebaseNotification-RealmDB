//
//  ViewController.swift
//  testeAPP
//
//  Created by Sistemainfo Mobile on 08/11/16.
//  Copyright © 2016 SistemaInfo. All rights reserved.
//

import UIKit
import RealmSwift


import Firebase
import FirebaseInstanceID
import FirebaseMessaging

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate, CustomTableViewCellDelegate,  modalViewControllerDelegate {

    @IBOutlet weak var taskNameTxtField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    var tarefas=[String]()
    
    var desc:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        try! Realm().write(){
            try! Realm().deleteAll()
        }*/
        tableView.rowHeight = UITableViewAutomaticDimension
        self.loadTarefas()
        //self.printaToken()
        
    }
    
    func printaToken(){
        let token = FIRInstanceID.instanceID().token()
        print("InstanceID token: \(token!)")
    }
    
    func loadTarefas(){
        print("LOADTAREFAS")
        let tars = try! Realm().objects(TarefasObj.self)
        for index in 0 ..< tars.count {
            print("Tarefa : \(tars[index].name) - Completed : \(tars[index].competed)")
            tarefas.append(tars[index].name)
            tableView.reloadData()
        }
        
    }

    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CustomTableViewCell
        
        
        cell.lblDesc.text = tarefas[indexPath.row]
        cell.tarefa = cell.lblDesc.text
        cell.delegate = self
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tarefas.count
    }
    

    @IBAction func addTask() {
        if (taskNameTxtField.text!.isEmpty) {
            return;
        }
        
        let tar = TarefasObj()
        let realm = try! Realm()
        
        tar.name = taskNameTxtField.text!
        
        try! realm.write {
            realm.add(tar)
        }
        
        tarefas.append(taskNameTxtField.text!)
        
        taskNameTxtField.text=""
        taskNameTxtField.resignFirstResponder()
        tableView.reloadData()
        print(tarefas)
        
    }
    
    
    
    
    func tarefaItemDeletado(tarefa: String) {
        let realm = try! Realm()
        if tarefas.indexOf(tarefa) != nil{
            tarefas.removeAtIndex(tarefas.indexOf(tarefa)!)
        }
        for index in 0 ..< tableView.visibleCells.count{
            
            let cell = tableView.visibleCells[index] as! CustomTableViewCell
            if cell.lblDesc.text == tarefa {
                let idx = tableView.indexPathForCell(tableView.visibleCells[index])
                tableView.deleteRowsAtIndexPaths([(idx)!], withRowAnimation: .Automatic)
                let tar = realm.objects(TarefasObj.self).filter("name = '\(tarefa)'")
                try! realm.write {
                    realm.delete(tar)
                }
                return;
            }
        }
    }
    
    
    func tarefaItemUpdate(tarefa: String) {
        for index in 0 ..< tableView.visibleCells.count{
            let cell = tableView.visibleCells[index] as! CustomTableViewCell
            if cell.lblDesc.text == tarefa {
                
                desc = tarefa;
                
                self.performSegueWithIdentifier("modalUpdate", sender: desc)
               
                
            }
        }
    }
    
   
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "modalUpdate") {
            let secondViewController = segue.destinationViewController as! ModalUpdateViewController
            let descri = sender as! String
            secondViewController.desc = descri
            secondViewController.delegate = self
            
        }
    }
    
    
    // modalUpdate delegate
    func sendText(let new: String, let old: String){
        
            for index in 0 ..< tableView.visibleCells.count{
                let cell = tableView.visibleCells[index] as! CustomTableViewCell
                if cell.lblDesc.text == old {
                    let iy = tarefas.indexOf(old)!
                    tarefas[iy] = new
                    cell.lblDesc.text = new
                    
                    //tableView.insertRowsAtIndexPaths([tableView.indexPathForCell(cell)!], withRowAnimation: .Automatic)
                    self.tableView.reloadRowsAtIndexPaths([tableView.indexPathForCell(cell)!], withRowAnimation: UITableViewRowAnimation.Top)
                    
                    let realm = try! Realm()
                    let tar = realm.objects(TarefasObj.self).filter("name = '\(old)'")
                    try! realm.write {
                        tar[0].name = new
                    }
                    print("CHEGOUUUU" + old + cell.lblDesc.text! + " " )
                }
            }
        
        
    }
    
    
    
    
    
    /*
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            tarefas.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    */
   
    
    
    //TextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        addTask()
        return true
    }

}

