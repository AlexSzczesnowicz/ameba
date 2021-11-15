//
//  Ameba.swift
//  Ameba3
//
//  Created by Test on 02/11/2021.
//

import Foundation
import UIKit
var containerWidth = 0
var containerHeight = 0
class Ameba {
    static let shared = Ameba()
    
    enum funct{
        case empty
        case citoPlasm
        case border
        case core
        case shellEktoplasma
        case shellEndoplasma
        case vakuol
        case enemy
        
        
    }
    
    
    struct leftCornerLocation{
        var x: Int
        var y: Int
    }
    
    
    
    struct cell:  Hashable{
        var function: funct
        var status: Int
        var x: Int
        var y: Int
        var kolor: UIColor
        var identf: String
        var kornRad: CGFloat
        var size: CGFloat
        var num: Int
        
       
    }
    
   
    
    
    
    
    
    
    
    
    func createAContainer(width:Int, height: Int)->[[cell]]{
       /* let barierCell = cell.init(function: funct.border, status: 1, x: 0, y: 0, kolor: .red, identf: "B", kornRad: 0, size: 3, num: 0)
       */
        let barierCell = cell.init(function: funct.empty, status: 1, x: 0, y: 0, kolor: .clear, identf: "E", kornRad: 0, size: 3, num: 0)
        let insideCell = cell.init(function: funct.empty, status: 1, x: 0, y: 0, kolor: .clear, identf: "E", kornRad: 0, size: 3, num: 0)
        
        
        let barierTop = [cell](repeating: barierCell, count: width)
        var barierMid = [cell](repeating: insideCell, count: width)
        barierMid[0] = barierCell
        barierMid[width-1] = barierCell
        var toReturn = [barierTop,barierMid,barierTop]
        for i in 1...height-3{
            toReturn.insert(barierMid, at: i)
        }
        for i in 0..<toReturn.count{
            for j in 0..<toReturn[i].count{
                toReturn[i][j].x = j
                toReturn[i][j].y = i
            }
        }
        
       return toReturn
        
    }
    
 /*   func createAmeba(width:Int, height: Int)->[[cell]]{
        let barierCell = cell.init(function: funct.shellEktoplasma, status: 1, x: 0, y: 0, kolor: .cyan, identf: "ASEkt", kornRad: 1, size: 2, num: 0)
        let insideCell = cell.init(function: funct.shellEndoplasma, status: 1, x: 0, y: 0, kolor: .blue, identf: "ASEnd", kornRad: 1, size: 2.8, num: 0)
        
        
        let barierTop = [cell](repeating: barierCell, count: width)
        var barierMid = [cell](repeating: insideCell, count: width)
        barierMid[0] = barierCell
        barierMid[width-1] = barierCell
        var toReturn = [barierTop,barierMid,barierTop]
        for i in 1...height-3{
            toReturn.insert(barierMid, at: i)
        }
        var nr = 1
        for i in 0..<toReturn.count{
            for j in 0..<toReturn[i].count{
                if toReturn[i][j].identf == "ASEkt"{
                    toReturn[i][j].num = nr
                    nr+=1
                }
                
            }
        }
       
       return toReturn
        
    }
   */
    func invaseAmeba(toVolume: [[cell]], amebaBody:[[cell]], at: leftCornerLocation ) -> [[cell]]{
        var toReturn = toVolume
        for i in 0..<amebaBody.count{
            for j in 0..<amebaBody[i].count{
                toReturn[i+at.y][j+at.x] = amebaBody[i][j]
            }
            
        }
        return toReturn
    }
    
    func putAmeba(atPole: UIView){
        //let amb = createAmeba(width: amebaWidth, height: amebaHeight)
        let amb = symbolTranslator(symbolArr: amebaBody)
        let point = CGPoint(x: 150, y: 50)
        drawBody(body: amb, placeAt: point, putInto: atPole)
        //gameScene = invaseAmeba(toVolume: gameScene, amebaBody: amb, at: leftCornerLocation(x: amebaWidth , y: amebaHeight))
    }
   
    
    
    
    
    func symbolTranslator(symbolArr: [String]) -> [[cell]]{
        let barierCell = cell.init(function: funct.shellEktoplasma, status: 1, x: 0, y: 0, kolor: .darkGray, identf: "Shell", kornRad: 2.3, size: 5, num: 0)
        let insideCell = cell.init(function: funct.shellEndoplasma, status: 1, x: 0, y: 0, kolor: .blue, identf: "Endoplasm", kornRad: 2, size: 4.6, num: 0)
        let jadroCell = cell.init(function: funct.core, status: 1, x: 0, y: 0, kolor: .orange, identf: "Core", kornRad: 1, size:3 , num: 0)
        let vakuolCell = cell.init(function: funct.vakuol, status: 1, x: 0, y: 0, kolor: .green, identf: "Vakuol", kornRad: 2.5, size: 5, num: 0)
        
        var arrToReturn:[[cell]] = []
        for arr in symbolArr{
            var cellsArr: [cell] = []
            for char in arr{
                if char == "X"{
                    cellsArr.append(barierCell)
                } else if char == "E"{
                    cellsArr.append(insideCell)
                } else if char == "o"{
                    cellsArr.append(jadroCell)
                } else if char == "d"{
                    cellsArr.append(vakuolCell)
                }
                
           }
            arrToReturn.append(cellsArr)
        }
        
        return arrToReturn
    }
    
    func drawBody(body:[[Ameba.cell]], placeAt: CGPoint, putInto: UIView){
        var per = 0
        for i in 0..<body.count{
           // let wPreskaler = GamePole.frame.maxX / 40
          //  let hPreskaler = GamePole.frame.maxY / 60
           
            for j in 0..<body[i].count{
                if body[i][j].function != Ameba.funct.empty{
                    let t = UIView.init()
                    t.frame = CGRect(x: CGFloat( j * 3) + placeAt.x , y: CGFloat( i * 3) + placeAt.y, width: body[i][j].size, height: body[i][j].size)
                    t.backgroundColor = body[i][j].kolor
                    t.accessibilityIdentifier = "\(body[i][j].identf)"
                    t.layer.masksToBounds = true
                    t.layer.cornerRadius = body[i][j].kornRad
                    if body[i][j].function == funct.shellEktoplasma{
                       // print("add \(per)")
                        let text = UILabel.init()
                        text.frame = t.frame
                        text.text = String(per)
                        text.font = UIFont(name:"FontAwesome",size:7)
                        per+=1
                        t.addSubview(text)
                        
                    }
                  
                    putInto.addSubview(t)
                }
            }
        }
        
    }
    
    func addPerimetrMass(){
        perimetrMass = UIDynamicItemBehavior(items: shell)
        perimetrMass.elasticity = 1
        perimetrMass.resistance = 0.5
        perimetrMass.density = 30
        perimetrMass.angularResistance = 0.1
        animator.addBehavior(perimetrMass)
        
    }
    
    func addVacuolMass(){
        vacuolMass = UIDynamicItemBehavior(items: vacuol)
        vacuolMass.elasticity = 1
        vacuolMass.resistance = 0.5
        vacuolMass.density = 0.03
        vacuolMass.angularResistance = 0.1
        animator.addBehavior(vacuolMass)
    }
    
    
    
    
}


