//
//  ModalUpdateViewController.swift
//  testeAPP
//
//  Created by João Pedro Vieira Pereira on 09/11/16.
//  Copyright © 2016 SistemaInfo. All rights reserved.
//

import UIKit


protocol modalViewControllerDelegate {
    func sendText(let new: String, let old: String)
}


class ModalUpdateViewController: UIViewController {
    
    @IBOutlet weak var txtDescricao: UITextField!
    var desc:String?
    var delegate: modalViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtDescricao.text = desc;
        
                
    }
    
    @IBAction func confirmaUpdate(sender: AnyObject) {
        delegate.sendText(self.txtDescricao.text!, old: self.desc!)
        navigationController?.popViewControllerAnimated(true)
    }
}
