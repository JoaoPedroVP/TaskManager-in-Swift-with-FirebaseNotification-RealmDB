//
//  CustomTableViewCell.swift
//  testeAPP
//
//  Created by João Pedro Vieira Pereira on 08/11/16.
//  Copyright © 2016 SistemaInfo. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblDesc: UILabel!
    var initialPosition:CGPoint?
    var initialColor:UIColor?
    var deleteOnDragRelease: Bool!
    var updateOnDragRelease:Bool!
    
    var tarefa:String!
    var delegate: CustomTableViewCellDelegate?
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        // self.backgroundColor = UIColor.frontColor()
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(CustomTableViewCell.handlePan(_:)))
        gesture.delegate = self
        self.addGestureRecognizer(gesture)
    }
    
    
    
    func handlePan(rec : UIPanGestureRecognizer){
        if rec.state == .Began{
            initialPosition=self.center
            initialColor = self.backgroundColor
        }
        
        if rec.state == .Changed {
            let translation = rec.translationInView(self)
            self.center = CGPoint(x : initialPosition!.x + translation.x , y: initialPosition!.y)
            deleteOnDragRelease=self.frame.origin.x < (-self.frame.size.width / 2)
            updateOnDragRelease = self.frame.origin.x > (self.frame.size.width / 2)
            
            if deleteOnDragRelease! {
                self.backgroundColor = UIColor.redColor()
            } else if updateOnDragRelease!{
                self.backgroundColor = UIColor.frontColor()
            } else {
                self.backgroundColor = initialColor
            }
        }
        
        if rec.state == .Ended{
            let originalFrame = CGRect(x:0, y: self.frame.origin.y,width: self.bounds.size.width, height: self.bounds.size.height)
            if deleteOnDragRelease! {
                if tarefa != nil {
                    delegate?.tarefaItemDeletado(tarefa!)
                    self.backgroundColor = UIColor.redColor()
                }
            }else if updateOnDragRelease! {
                UIView.animateWithDuration(0.2, animations: { self.frame = originalFrame })
                self.backgroundColor = UIColor.backgroundColor()
                if tarefa != nil {
                    delegate?.tarefaItemUpdate(tarefa)
                }
                
            } else {
              UIView.animateWithDuration(0.2, animations: { self.frame = originalFrame })  
            }
        }
        
    }
    
    
    
    override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer is UIPanGestureRecognizer{
            let rec = gestureRecognizer as! UIPanGestureRecognizer
            let tras = rec.translationInView(self.superview)
        
            if fabs(tras.x) > fabs(tras.y){
                return true
        
            }
        }
        return false
    }
    
    
}
