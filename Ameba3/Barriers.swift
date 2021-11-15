//
//  Barriers.swift
//  Ameba3
//
//  Created by Test on 06/11/2021.
//

import Foundation
import UIKit
class Barriers{
    static let shared = Barriers()
    var cellWidth: CGFloat!
    var cellHeight: CGFloat!
    
    func barierTranslate(forList: [String], inFrame: CGRect)->UIView{
        let toReturn = UIView.init(frame: inFrame)
        print("inframe size \(inFrame.size)")
        cellWidth = inFrame.height / CGFloat( forList.count-1)
        cellHeight = inFrame.width / CGFloat( forList[0].count)
        
        print("cell width = \(String(describing: cellWidth)) cell height = \(String(describing: cellHeight))")
        
        var y = 0
        for line in forList{
            var x = 0
            for char in line{
                if char  == "X"{
                    let bar = createBar(atX: x * Int(cellWidth), atY: y * Int(cellHeight))
                    toReturn.addSubview(bar)
                   
                    
                }
                x+=1
            }
            y+=1
        }
       /* let rtt = UIView.init(frame: CGRect(x: 300, y: 504, width: 14, height: 14))
        rtt.backgroundColor = UIColor.blue
        toReturn.addSubview(rtt)*/
    return toReturn
}
    
    
    func createBar(atX: Int, atY: Int)-> UIView{
        let barrier = UIView(frame: CGRect(x: atX, y: atY, width: Int(cellWidth)-1, height: Int(cellHeight)-1))
        barrier.backgroundColor = UIColor.brown
        barrier.alpha = 0.5
        collision.addBoundary(withIdentifier: "barrier" as NSCopying, for: UIBezierPath(rect: barrier.frame))
        return barrier
    }
    
    
}
