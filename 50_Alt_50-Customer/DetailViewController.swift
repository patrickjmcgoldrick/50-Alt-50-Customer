//
//  DetailViewController.swift
//  50_Alt_50-Customer
//
//  Created by dirtbag on 4/26/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import UIKit

struct LineItem {
    
    var id : Int
    var title : String
    var price : Float
    var image : String
    var selected : Bool
    var quantity : Int
    
}

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var lblTotal: UILabel!
        
    @IBAction func actionPlaceOrder(_ sender: Any) {
        
        // goto submitted order screen
        performSegue(withIdentifier: "orderSubmittedSegue", sender: nil)
    }
    
    var data = [
        [
        LineItem(id: 1, title: "Garlic", price: 4.0, image: "garlic", selected: false, quantity: 0),
        LineItem(id: 2, title: "Canteloupe",  price: 0.52, image: "cantaloupe", selected: false, quantity: 0),
        LineItem(id: 3, title: "Honeydew", price: 0.83, image: "honeydew", selected: false, quantity: 0),
        LineItem(id: 4, title: "Red Pepper", price: 2.32, image: "red_peppers", selected: false, quantity: 0)
        ], [
        LineItem(id: 5, title: "Beets", price: 0.94, image: "beets", selected: false, quantity: 0),
        LineItem(id: 6, title: "Green Peas", price: 1.66, image: "green_peas", selected: false, quantity: 0),
        LineItem(id: 7, title: "Radishes", price: 1.46, image: "radishes", selected: false, quantity: 0)
        ], [
        LineItem(id: 8, title: "Ace Tomatos", price: 2.25, image: "ace_tomatos", selected: false, quantity: 0),
        LineItem(id: 9, title: "Asian Baby Eggplant", price: 2.25, image: "baby_eggplant", selected: false, quantity: 0)
        ]
    ]
    
    var selectedSection: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addLogo()
    }
    
    func addLogo() {
        let navController = navigationController!
        
        let image = UIImage(named: "navbarImage")
        let imageView = UIImageView(image: image)
        
        let bannerWidth = navController.navigationBar.frame.size.width
        let bannerHeight = navController.navigationBar.frame.size.height
        
        let bannerX = bannerWidth / 2 - (image?.size.width)! / 2
        let bannerY = bannerHeight / 2 - (image?.size.height)! / 2
        
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        imageView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = imageView
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data[selectedSection!].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)
        cell.selectionStyle = .blue
        
        let lineItem = data[selectedSection!][indexPath.row]
        cell.textLabel?.text = lineItem.title
        cell.detailTextLabel?.text = "$\(lineItem.price)/lbs"
        
        let image = UIImage(named: lineItem.image)
        cell.imageView?.image = image
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let lineItem = data[selectedSection!][indexPath.row]
        
        updateQuanityOnUI(lineItem: lineItem, indexPath: indexPath)
    }

    func updateQuanityOnUI(lineItem: LineItem, indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
        
            if lineItem.selected {
                cell.accessoryType = .none
                cell.detailTextLabel?.text = "$\(lineItem.price)/lbs"
                data[selectedSection!][indexPath.row].selected = false
                
                updateTotalLabel()
                
            } else {
                getQuantity(indexPath: indexPath, cell: cell)
            }
        }
    }

    func getQuantity(indexPath: IndexPath, cell: UITableViewCell) {
        
        let lineItem = data[selectedSection!][indexPath.row]
        
        let alert = UIAlertController(title: lineItem.title, message: "How many pounds would you like?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Save", style: UIAlertAction.Style.default) {
            UIAlertAction in
            
            if let quantity = Int(alert.textFields![0].text!) {
                self.data[self.selectedSection!][indexPath.row].selected = true
                self.data[self.selectedSection!][indexPath.row].quantity = quantity
                cell.accessoryType = .checkmark
                cell.detailTextLabel?.text = "\(quantity) x $\(lineItem.price)/lbs"
                
                self.updateTotalLabel()
               
            } else {
                print ("failed to parse")
            }
            
        })
        alert.addTextField(configurationHandler: {(textField: UITextField!) in
            textField.keyboardType = .numberPad
        })
        self.present(alert, animated: true, completion: nil)
    }
    
    /// calculate order total and update label
    func updateTotalLabel() {
        var sum: Float = 0.0
        for row in data[selectedSection!] {
            if row.selected == true {
                sum += Float(row.quantity) * row.price
            }
        }
        
        let sumString = String.localizedStringWithFormat("%.2F", sum)
        
        lblTotal.text = "Total $\(sumString)"
    }
}

