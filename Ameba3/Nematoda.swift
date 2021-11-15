//
//  Nematoda.swift
//  Ameba3
//
//  Created by Test on 07/11/2021.
//

import Foundation
import UIKit
class Nematoda {
    static let shared = Nematoda()
    

    func createNematoda(len: Int, at: CGPoint) -> UIView{
        let toReturn = UIView.init(frame: CGRect(x: at.x, y: at.y, width: 100, height: 20))
        let body = Array.init(repeating: 1, count: len)
        
        var x = 0
        for _ in body{
            let cellBody = UIView.init(frame: CGRect(x:Int(at.x) + x, y: Int(at.y), width: 6, height: 6))
            cellBody.backgroundColor = UIColor.magenta
            cellBody.accessibilityIdentifier = "nematoda"
            toReturn.addSubview(cellBody)
            x+=7
        }
        return toReturn
        
        
        }
        
        
   

    
    
}
