//
//  Hanting.swift
//  Ameba3
//
//  Created by Test on 05/11/2021.
//

import Foundation
import UIKit
class Hanting{
    static let shared = Hanting()
    
    enum snak{
        case salt
        case sugar
        case nematod
        case infuzoria
    }
    
    
    
    func placeSnack(atPoint: CGPoint) -> UIView{
        var backColor: CGColor
        if snakFromButton == snak.sugar{
            backColor = .init(red: 0.7, green: 0.7, blue: 0.3, alpha: 1)
        } else {
            backColor = .init(red: 0.6, green: 0, blue: 0.4, alpha: 1)
        }
        let view = UIView.init()
        view.frame = CGRect(x: atPoint.x - 5, y: atPoint.y - 5, width: 10, height: 10)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 4
        view.layer.backgroundColor = backColor
        view.accessibilityIdentifier = "snak"
        return view
        
        
    }
    
    func moveAmebaSnap(toPoint: CGPoint){
        if (snap != nil) {
            animator.removeBehavior(snap)
                        }
                let item = calculations.searchANearest(toPoint: toPoint, inArr: shell)
              snap = UISnapBehavior(item: item, snapTo: toPoint)
        
               snap.damping = 25
                animator.addBehavior(snap)
                vacuolMove(toCell: item)
    }
    
    func vacuolMove(toCell: UIView){
        if vakuolMoveBehavior != nil{
            animator.removeBehavior(vakuolMoveBehavior)
                //  print("vacuol move removed")
        }
        
        vakuolMoveBehavior = UIAttachmentBehavior(item: vacuol[5], attachedTo: toCell)
        vakuolMoveBehavior.length = 4
        vakuolMoveBehavior.damping = 5
        vakuolMoveBehavior.frequency = 7
        animator.addBehavior(vakuolMoveBehavior)
        
    }
    
    func searchASnack(inViews:[UIView])->CGPoint{
        var toReturn: CGPoint = CGPoint(x: 0, y: 0)
        inViews.forEach({
            if $0.accessibilityIdentifier == "snak"{
                toReturn = $0.center
            }
        })
        return toReturn
    }
    
    func moveAmebaPush(toPoint: CGPoint){
        if (push != nil) {
            animator.removeBehavior(push)
                        }
                let item = calculations.searchANearest(toPoint: toPoint, inArr: shell)
           //    snap = UISnapBehavior(item: item, snapTo: toPoint)
       
        push = UIPushBehavior.init(items: [item], mode: UIPushBehavior.Mode.instantaneous)
        
        push.magnitude = 10
        
        let difX = (toPoint.x-item.center.x) / 600
        let difY = (toPoint.y-item.center.y) / 600
        let vector = CGVector(dx: difX, dy: difY)
        push.pushDirection = vector
        push.active = true
        
               // snap.damping = 50
                animator.addBehavior(push)
        hunting.vacuolMove(toCell: item)
    }
    

    
    
    
    
    
}
