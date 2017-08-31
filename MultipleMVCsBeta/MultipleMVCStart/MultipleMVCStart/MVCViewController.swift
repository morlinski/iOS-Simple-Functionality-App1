//
//  MVCViewController.swift
//  MultipleMVCStart
//
//  Created by Monika on 2017-08-24.
//  Copyright © 2017 Monika. All rights reserved.
//

import UIKit

extension UserDefaults {
    func setColor(value: UIColor?, forKey: String){
        guard let value = value else { set(nil, forKey: forKey); return }
        set(NSKeyedArchiver.archivedData(withRootObject: value), forKey: forKey)
    }
    func colorForKey(key:String)->UIColor? {
        guard let data = data(forKey: key), let color = NSKeyedUnarchiver.unarchiveObject(with: data) as? UIColor
        else {return UIColor.black}
        return color
    }
}

class MVCViewController: UIViewController {
    
    var persistedCustomColor : UIColor? {
        get{
            return UserDefaults.standard.colorForKey(key: "customColor")
        }
        set {
            UserDefaults.standard.setColor(value: newValue, forKey: "customColor")
        }
    }

    @IBOutlet weak var BigX: UIButton!
    @IBOutlet weak var ContainerForBigX: UIView!
    var pinched: Bool!
    
    @IBAction func hideScreenGestureAtion(_ sender: UIPinchGestureRecognizer) {
        if !pinched {
            pinched = true
            print("pinched!")
            
            
            if let navcon = self.parent as? UINavigationController {
                print("in navigation wrapper")
            } else {
                print("not in nav wrapper")
                if self.canResignFirstResponder{
                    print("resignable")
                    self.resignFirstResponder()
                    let storyboard = UIStoryboard(name: "Main", bundle:nil)
                    let controller = storyboard.instantiateInitialViewController()
                    self.present(controller!, animated:true, completion: nil)
                }
                else{
                    print("not resignable")
                }
            }
            
            }
        //reference.
        /*if let navcon = self as? UINavigationController {
            return navcon.visibleViewController
        } else {
            return self
        }*/
    }

    
    var redComponent = 0 {
        didSet{
            updateCustomColor()
            print("red changed to \(redComponent)")
        }
    }
    var greenComponent = 0 {
        didSet{
            updateCustomColor()
            print("green changed to \(greenComponent)")
        }
    }
    var blueComponent = 0 {
        didSet{
            updateCustomColor()
            print("blue changed to \(blueComponent)")
        }
    }
    var yellowComponent = 0 {
        didSet{
            updateCustomColor()
            print("yellow changed to \(yellowComponent)")
        }
    }
    
    func updateCustomColor () {
        //customColor = UIColor(red: 0.5, green: 0.8, blue: 0.0, alpha: 0.7)
        
        print("rgba(\(Double(redComponent)/255),\(Double(greenComponent)/255),\(Double(blueComponent)/255))")
        
        customColor = UIColor(red: CGFloat(redComponent)/255, green: CGFloat(greenComponent)/255, blue: CGFloat(blueComponent)/255, alpha: 0.7)
        
        if ContainerForBigX != nil{
            print("updating scene \(customColor)")
            ContainerForBigX.backgroundColor = customColor
        }
    }
    
    func checkRange(_ check: Int) -> Bool {
        if check >= 0 && check < 255 { return true }
        return false
    }
    
    func returnClosestBound(_ check: Int) -> Int {
        if check < 0 { print("\(check) reset to zero");return 0 }
        print("\(check) reset to 255")
        return 255
    }
    
    var customColor = UIColor.black {
        didSet
        {
            if ContainerForBigX != nil {
                ContainerForBigX.backgroundColor = customColor
            }
        }

    }

    var selectedColor = UIColor.gray {
        didSet
        {
            if BigX != nil {
                BigX.backgroundColor = selectedColor
            }
        }
    }
    
    @IBAction func closeMe(_ sender: Any) {
        //changed to modify the color of the background.
        //and used to subtract the main color selection.
        switch selectedColor {
        case UIColor.red: if checkRange(redComponent) { redComponent -= 5 } else { redComponent = returnClosestBound(redComponent) }
            case UIColor.green: if checkRange(greenComponent) { greenComponent -= 5 } else { greenComponent = returnClosestBound(greenComponent) }
            case UIColor.blue: if checkRange(blueComponent) { blueComponent -= 5 } else { blueComponent = returnClosestBound(blueComponent) }
        case UIColor.yellow: reset(); if checkRange(yellowComponent) { yellowComponent -= 5 } else { yellowComponent = returnClosestBound(yellowComponent) }
            default: break
        }
    }
    @IBAction func saturateColor(_ sender: Any) {
        switch selectedColor {
        case UIColor.red: if checkRange(redComponent) { redComponent += 5 } else { redComponent = returnClosestBound(redComponent) }
        case UIColor.green: if checkRange(greenComponent) { greenComponent += 5 } else { greenComponent = returnClosestBound(greenComponent) }
        case UIColor.blue: if checkRange(blueComponent) { blueComponent += 5 } else { blueComponent = returnClosestBound(blueComponent) }
        case UIColor.yellow: reset(); if checkRange(yellowComponent) { yellowComponent += 5 } else { yellowComponent = returnClosestBound(yellowComponent) }
        default: break
        }

    }
    
    private func saveColorStatus(){
        //UserDefaults.standard.set(customColor, forKey: "customColor")
        UserDefaults.standard.set(redComponent, forKey: "red")
        UserDefaults.standard.set(greenComponent, forKey: "green")
        UserDefaults.standard.set(blueComponent, forKey: "blue")
        UserDefaults.standard.set(yellowComponent, forKey: "yellow")
        persistedCustomColor = customColor
        print("Saving \(customColor) now.")
    }
    private func retrieveColorStatus(){
        /*if let customColor = UserDefaults.standard.object(forKey: "customColor") as? UIColor {
        
        }
        else { customColor = UIColor.black }*/
        redComponent = UserDefaults.standard.integer(forKey: "red")
        greenComponent = UserDefaults.standard.integer(forKey: "green")
        blueComponent = UserDefaults.standard.integer(forKey: "blue")
        yellowComponent = UserDefaults.standard.integer(forKey: "yellow")
        customColor = persistedCustomColor!
        ContainerForBigX.backgroundColor = customColor
        print("Retreiving \(customColor) now.")
    }
    private func reset(){
        redComponent = 0
        greenComponent = 0
        blueComponent = 0
        yellowComponent = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveColorStatus()
        BigX.backgroundColor = selectedColor
        ContainerForBigX.backgroundColor = customColor
        pinched = false
        print("\(selectedColor)")
    }
    
    override  func viewWillAppear(_ animated: Bool) {
        if let navcon = self.parent as? UINavigationController {
        }
        else {
            
        }

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        saveColorStatus()
        super.viewWillDisappear(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
