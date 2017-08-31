//
//  SeguedViewController.swift
//  MultipleMVCStart
//
//  Created by Monika on 2017-08-24.
//  Copyright © 2017 Monika. All rights reserved.
//

import UIKit

class SeguedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationvc = segue.destination
        if let splashColor = destinationvc as? MVCViewController {

            if let identifier = segue.identifier {
                switch identifier{
                case "addRed": splashColor.selectedColor = UIColor.red;if splashColor.checkRange(splashColor.redComponent){} else { splashColor.redComponent = splashColor.returnClosestBound(splashColor.redComponent) }//splashColor.BigX.backgroundColor = UIColor.red
                case "addGreen": splashColor.selectedColor = UIColor.green;if splashColor.checkRange(splashColor.greenComponent){} else { splashColor.greenComponent = splashColor.returnClosestBound(splashColor.greenComponent) }//splashColor.BigX.backgroundColor = UIColor.green
                case "addBlue": splashColor.selectedColor = UIColor.blue;if splashColor.checkRange(splashColor.blueComponent){} else { splashColor.blueComponent = splashColor.returnClosestBound(splashColor.blueComponent) }//splashColor.BigX.backgroundColor = UIColor.blue
                case "addYellow": splashColor.selectedColor = UIColor.yellow;if splashColor.checkRange(splashColor.yellowComponent){} else { splashColor.yellowComponent = splashColor.returnClosestBound(splashColor.yellowComponent) }//splashColor.BigX.backgroundColor = UIColor.yellow
                default: splashColor.selectedColor = UIColor.black//splashColor.BigX.backgroundColor = UIColor.black
                }
            }
            
        }
    }
    

}
