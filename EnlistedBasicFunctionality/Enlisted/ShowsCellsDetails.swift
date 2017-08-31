//
//  ShowsCellsDetails.swift
//  Enlisted
//
//  Created by Monika on 2017-08-30.
//  Copyright © 2017 Monika. All rights reserved.
//

import UIKit

class ShowsCellsDetails: UIViewController {
    @IBOutlet weak var theImage: UIImageView!
    @IBOutlet weak var theName: UILabel!
    @IBOutlet weak var theDescription: UITextView!
    
    var theImagePreGui: UIImage!
    var theNamePreGui: String!
    var theDescriptionPreGui: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        theImage.image = theImagePreGui
        theName.text = theNamePreGui
        theDescription.text = theDescriptionPreGui
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
    }
    

}
