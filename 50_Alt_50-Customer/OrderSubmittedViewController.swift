//
//  OrderSubmittedViewController.swift
//  50_Alt_50-Customer
//
//  Created by dirtbag on 4/27/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import UIKit

class OrderSubmittedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionHome(_ sender: Any) {
        
        performSegue(withIdentifier: "homeSegue", sender: nil)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
