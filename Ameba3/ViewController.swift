//
//  ViewController.swift
//  Ameba3
//
//  Created by Test on 02/11/2021.
//

import UIKit
let calculations = Calculations()
let barriers = Barriers()

let globalWidth = 80
let globalHeight = 120

let amebaWidth = 10
let amebaHeight = 10

let ameba = Ameba()
var vacuol: [UIView] = []
var shell:[UIView] = []
var arrOfConect:[[Int]] = []

//var namatodaCzerw:[UIView] = []

var snakFromButton = Hanting.snak.sugar
let hunting = Hanting()
var buferView: UIView!
var itemsAtPole: Int = 0
let nematoda = Nematoda()
/*{
    didSet{
        
        if buferView != nil{
            print("bufer not a nil")
        let point = hunting.searchASnack(inViews: buferView.subviews)
    
        if point != CGPoint(x: 0, y: 0){
            print("snak detected")
            hunting.moveAmebaSnap(toPoint: point)
        }
        
    }
    }
}*/
var snap: UISnapBehavior!
var animator: UIDynamicAnimator!
var vakuolMoveBehavior: UIAttachmentBehavior!
var push: UIPushBehavior!

var perimetrMass: UIDynamicItemBehavior!
var vacuolMass: UIDynamicItemBehavior!

var collision: UICollisionBehavior!
//var conectionNematoda: UIAttachmentBehavior!


class ViewController: UIViewController  {
    @IBOutlet weak var GamePole: UIView!
    
    
    @IBAction func Button_1(_ sender: Any) {
        snakFromButton = Hanting.snak.sugar
    }
    @IBOutlet weak var Buton_1: UIButton!
    @IBAction func Button_2(_ sender: Any) {
        snakFromButton = Hanting.snak.salt
    }
    @IBOutlet weak var Buton_2: UIButton!
    @IBAction func Button_3(_ sender: Any) {
    }
    @IBOutlet weak var Buton3: UIButton!
    
    @IBOutlet weak var ButtonPanel: UIView!
    //var snap: UISnapBehavior!

   
    var conectionNet: UIAttachmentBehavior!
   
    var coreBehavior: UIFieldBehavior!
    var vakuolBehavior: UIAttachmentBehavior!
   
    
    var endoPlasmBehavior: UIFieldBehavior!
    
    var snapNematoda: UISnapBehavior!
    
    
    private var observer: NSKeyValueObservation?
   
    override func viewDidLayoutSubviews() {
        addBar()
        // print("Size of View: \(GamePole.bounds) SUKA BLEAT")
    }
   

   
    override func viewDidLoad() {
        
        super.viewDidLoad()
        animator = UIDynamicAnimator(referenceView: GamePole)
        buttonPan()
       
        
        ameba.putAmeba(atPole: GamePole)
        
        amebaVarsActivate()
        GamePole.backgroundColor = UIColor.gray
       // GamePole.layer.zPosition = 2
        
        strangeFunc()
        perimetr()
        ameba.addPerimetrMass()
        ameba.addVacuolMass()
       
        coreOrganise()
        vacuolOrganise()
        EndoOrganise()
        
       
        
        
       
        addCollisions()
        putNematoda(withLen: 12, atPoint: CGPoint(x: 200, y: 300))
        namatodaConnections()
       
    }
    
    func addBar(){
        let barFrame = GamePole.bounds
        //let barFrame = CGRect(x: 0, y: 0, width: GamePole.frame.maxX, height: GamePole.frame.maxY)
        let barView = barriers.barierTranslate(forList: list1, inFrame: barFrame)
       // barView.layer.zPosition = 1
        let br = barView.subviews
        br.forEach({
            GamePole.addSubview($0)
            
        })
       
    }
    
    func putNematoda(withLen:Int, atPoint:CGPoint){
        
        let czerw = nematoda.createNematoda(len: withLen, at: atPoint)
        let czerwCells = czerw.subviews
        czerwCells.forEach({
            GamePole.addSubview($0)
        })
        
    }
    func namatodaConnections(){
        
        let namatodaCzerw = GamePole.subviews.filter({
            $0.accessibilityIdentifier == "nematoda"
        })
        for i in 1..<namatodaCzerw.count{
            conectionNet = UIAttachmentBehavior(item: namatodaCzerw[i],
                                                     attachedTo: namatodaCzerw[i-1])
            conectionNet.length = 7
            conectionNet.frequency = 4
            conectionNet.damping = 15
            
           // conectionNet.frictionTorque = 0.1
            animator.addBehavior(conectionNet)
            collision.addItem(namatodaCzerw[i])
            
          //
           // collision.translatesReferenceBoundsIntoBoundary = true
            
        }
        animator.addBehavior(collision)
    }
  
    
    func moveNematodaSnap(){
        if (snapNematoda != nil) {
            animator.removeBehavior(snapNematoda)
                        }
        let namatodaCzerw = GamePole.subviews.filter({
                                                        $0.accessibilityIdentifier == "nematoda"})
        
        let itemFirst = namatodaCzerw.first
        let itemLast = namatodaCzerw.last
       
        let randY = CGFloat.random(in: -70...70)
        let randDest = CGPoint(x: (itemFirst?.center.x)!, y: itemLast!.center.y + randY)
        snapNematoda = UISnapBehavior(item: itemFirst!, snapTo: randDest)
        
               snapNematoda.damping = 25
                animator.addBehavior(snapNematoda)
              
    }
    
    
    
    
    
    func strangeFunc(){
        let displayLink = CADisplayLink(target: self,
                                            selector: #selector(step))
        displayLink.preferredFramesPerSecond = 1
        displayLink.add(to: RunLoop.main, forMode: RunLoop.Mode.default)
        }
             
    @objc func step(displaylink: CADisplayLink) {
        let t = self.GamePole.subviews
        let snacks = t.filter{
            $0.accessibilityIdentifier == "snak"
        }
        if snacks.count != 0 {
            hunting.moveAmebaSnap(toPoint: snacks[0].center)
           //hunting.moveAmebaPush(toPoint: snacks[0].center)
            if calculations.isTouchPerimetr(aView: snacks[0], withR: 3){
                       snacks[0].removeFromSuperview()
                endoGrow(atPoint: calculations.takeAmebaCenter())
                EndoOrganise()
                addCollisions()
            }
        }
        testIsInPerimetr()
        let namatodaCzerw = GamePole.subviews.filter({
            $0.accessibilityIdentifier == "nematoda"
        })
        if namatodaCzerw.count > 0{
            moveNematodaSnap()
            
        }
        
        
        }
    
    func endoGrow(atPoint:CGPoint){
        let insideCell = Ameba.cell.init(function: Ameba.funct.shellEndoplasma, status: 1, x: 0, y: 0, kolor: .yellow, identf: "Endoplasm", kornRad: 1.5, size: 8.2, num: 0)
        let t = UIView.init()
        t.frame = CGRect(x: atPoint.x , y:atPoint.y, width: insideCell.size, height: insideCell.size)
        t.backgroundColor = insideCell.kolor
        t.accessibilityIdentifier = "\(insideCell.identf)"
        t.layer.masksToBounds = true
        t.layer.cornerRadius = insideCell.kornRad
        GamePole.addSubview(t)
    }
   
    
    
    
    
override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if touch.view == GamePole{
                let currentPoint = touch.location(in: GamePole)
                 let snakAtPole = hunting.placeSnack(atPoint: currentPoint)
                GamePole.addSubview(snakAtPole)
                buferView = GamePole
          //moveAmebaSnap(toPoint: currentPoint)
         //   moveAmebaPush(toPoint: currentPoint)
        }
        }}
    
    func buttonPan(){
        ButtonPanel.backgroundColor = UIColor.lightGray
        ButtonPanel.layer.masksToBounds = true
        ButtonPanel.layer.cornerRadius = 30
        Buton_1.setTitle("🍭", for: .normal)
        Buton_1.titleLabel?.font = .systemFont(ofSize: 30)
        Buton_2.setTitle("🧂", for: .normal)
        Buton_2.titleLabel?.font = .systemFont(ofSize: 30)
        
    }
    
    
    
    func amebaVarsActivate(){
        vacuol = GamePole.subviews.filter{
            $0.accessibilityIdentifier == "Vakuol"}
        shell = GamePole.subviews.filter{
                        $0.accessibilityIdentifier == "Shell"}
        
       arrOfConect = calculations.createPerimetr(inArr: shell)
    }
    
    func testIsInPerimetr(){
        let endo = GamePole.subviews.filter{
            $0.accessibilityIdentifier == "Endoplasm" || $0.accessibilityIdentifier == "Vakuol" ||
                $0.accessibilityIdentifier == "Core"
            
        }
        endo.forEach({
            if calculations.isInPerimetr(aView: $0) != true{
                $0.removeFromSuperview()
            }
        })
        
        
    }
    
    
    
    
   
    
    
   
    
    
   
    
    
    func perimetr(){
            for i in 0..<arrOfConect.count{
            for j in 1..<arrOfConect[i].count{
                conectionNet = UIAttachmentBehavior(item: shell[arrOfConect[i][j]],
                    attachedTo: shell[arrOfConect[i][j - 1]])
                conectionNet.length = 7
                conectionNet.frequency = 4
                conectionNet.damping = 15
                
               // conectionNet.frictionTorque = 0.1
                animator.addBehavior(conectionNet)
                //conectionNet.addChildBehavior(attachment)
            }
        }
        
    }
    func coreOrganise(){
        let core = GamePole.subviews.filter{
            $0.accessibilityIdentifier == "Core"
        }
        coreBehavior = UIFieldBehavior.magneticField()
        for cell in core{
            coreBehavior.addItem(cell)
            coreBehavior.falloff = 80
        }
        
        animator.addBehavior(coreBehavior)
    }
  
    func EndoOrganise(){
        if endoPlasmBehavior != nil{
            animator.removeBehavior(endoPlasmBehavior)
        }
        let endo = GamePole.subviews.filter{
            $0.accessibilityIdentifier == "Endoplasm"
        }
        endoPlasmBehavior = UIFieldBehavior.magneticField()
        for cell in endo{
            endoPlasmBehavior.addItem(cell)
            endoPlasmBehavior.falloff = 80
        }
        
        animator.addBehavior(endoPlasmBehavior)
    }
    
    
    
    func vacuolOrganise(){
       
        for cell in vacuol{
            vakuolBehavior = UIAttachmentBehavior(item: cell, attachedTo: vacuol[5])
            vakuolBehavior.length = 3
            vakuolBehavior.damping = 4
            vakuolBehavior.frequency = 2
            animator.addBehavior(vakuolBehavior)
        }
    }
    
   
    
    func addCollisions(){
        if collision != nil{
            animator.removeBehavior(collision)
        }
        let allCells = GamePole.subviews.filter{
            $0.accessibilityIdentifier == "Vakuol" ||
                $0.accessibilityIdentifier == "Core" ||
                $0.accessibilityIdentifier == "Endoplasm" ||
            $0.accessibilityIdentifier == "Shell" }
            
        collision = UICollisionBehavior(items: allCells)
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        }
   
   
}

