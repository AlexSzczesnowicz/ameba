//
//  Calculations.swift
//  Ameba3
//
//  Created by Test on 03/11/2021.
//

import Foundation
import UIKit
class Calculations{
   static let shared = Calculations()
    
    
    func searchANearest(toPoint: CGPoint, inArr: [UIView])->UIView{
        var diff:[CGFloat] = []
        inArr.forEach({
            
           let dif =  abs($0.layer.position.x - toPoint.x) + abs($0.layer.position.y - toPoint.y)
            diff .append(dif)
                      
        })
        let minimalDistance = diff.min()
        let viewsAndDistance = zip(inArr, diff)
        var toReturn: UIView?
        viewsAndDistance.forEach({
            if $0.1 == minimalDistance{
                toReturn = $0.0
            }
        })
        return toReturn!
    }
    
    func searchAFurther(toPoint: CGPoint, inArr: [UIView])->UIView{
        var diff:[CGFloat] = []
        inArr.forEach({
            
           let dif =  abs($0.layer.position.x - toPoint.x) + abs($0.layer.position.y - toPoint.y)
            diff .append(dif)
                      
        })
        let minimalDistance = diff.max()
        let viewsAndDistance = zip(inArr, diff)
        var toReturn: UIView?
        viewsAndDistance.forEach({
            if $0.1 == minimalDistance{
                toReturn = $0.0
            }
        })
        return toReturn!
    }
    
    
    
    
    
    
    
    
    func createPerimetrArrs() -> [[Int]]{
        var perimetr: [Int] = []
        let len = amebaWidth * 2 + 2 * amebaHeight - 4
        for i in 0..<len{
            perimetr.append(i)
        }
        let top = Array( perimetr[0..<amebaWidth])
        let index = perimetr.count - amebaWidth
        let bottom = Array( perimetr[index..<perimetr.count])
        
        let newArr = perimetr.filter{
            $0 > top.last!
        }
        let doubleArr = newArr.filter{
            $0 <= bottom.first!
        }
        var chetArr = doubleArr.filter{
            $0%2 == 0
        }
        chetArr.insert(top.first!, at: 0)
        
        var nieChetArr = doubleArr.filter{
            $0%2 != 0
        }
        nieChetArr.insert(top.last!, at: 0)
        nieChetArr.append(bottom.last!)
        let toReturn = [top, chetArr, nieChetArr, bottom]
        
        return toReturn
        
    }
    func  createPerimetr(inArr: [UIView])-> [[Int]] {
        var centry: [CGFloat] = []
        inArr.forEach({
            let center = $0.center.y
            centry.append(center)
        })
        let firstOfTop = centry.first
        let lastOfBottom = centry.last
        
        var topCower:[Int] = []
        var anotherPart:[Int] = []
        var bottomCower:[Int] = []
        var levPart:[Int] = []
        var pravPart:[Int] = []
        for i in 0..<centry.count{
            if centry[i] == firstOfTop{
                topCower.append(i)
            } else if centry[i] == lastOfBottom{
                bottomCower.append(i)
            } else if i%2 == 0{
                levPart.append(i)
            } else{
                pravPart.append(i)
            }
                
        }
        
        levPart.insert(topCower.first!, at: 0)
        levPart.append(bottomCower.first!)
        pravPart.insert(topCower.last!, at: 0)
        pravPart.append(bottomCower.last!)
        //pravPart.append(bottomCower.last!)
    
        let toReturn = [topCower, levPart, pravPart, bottomCower]
       print("top:\(toReturn[0]) lev\(toReturn[1]) prav\(toReturn[2]) bottom\(toReturn[3])")
        return toReturn
    }
    
    func isInPerimetr(aView:UIView) -> Bool{
        var locations:[CGPoint] = []
        shell.forEach({
            locations.append($0.center)
        })
        let sortedByX = locations.sorted{
            $0.x < $1.x
        }
        let sortedByY = locations.sorted{
            $0.y < $1.y
        }
        if aView.center.x > sortedByX.first!.x && aView.center.x < sortedByX.last!.x && aView.center.y > sortedByY.first!.y && aView.center.y < sortedByY.last!.y{
            return true
        } else {
            return false
        }
    }
    
    func isTouchPerimetr(aView:UIView, withR: CGFloat) -> Bool{
        var locations:[CGPoint] = []
        shell.forEach({
            locations.append($0.center)
        })
        let sortedByX = locations.sorted{
            $0.x < $1.x
        }
        let sortedByY = locations.sorted{
            $0.y < $1.y
        }
        if aView.center.x > sortedByX.first!.x - withR && aView.center.x < sortedByX.last!.x + withR && aView.center.y > sortedByY.first!.y - withR && aView.center.y < sortedByY.last!.y + withR{
            return true
        } else {
            return false
        }
    }
    
    
    
    
    
    func takeAmebaCenter() -> CGPoint{
        var locations:[CGPoint] = []
        shell.forEach({
            locations.append($0.center)
        })
        let sortedByX = locations.sorted{
            $0.x < $1.x
        }
        let sortedByY = locations.sorted{
            $0.y < $1.y
        }
        
        
        let localCenterX = abs(sortedByX.first!.x - sortedByX.last!.x) / 2
        let centerX = localCenterX + sortedByX.first!.x
        
        let localCenterY = abs(sortedByY.first!.y - sortedByY.last!.y) / 2
        let centerY = localCenterY + sortedByY.first!.y
        
        return CGPoint(x: centerX, y: centerY)
        
    }
    
    
    
    
    
    
    
    
    }
