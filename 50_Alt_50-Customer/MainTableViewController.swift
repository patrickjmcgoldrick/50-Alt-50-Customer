//
//  MainTableViewController.swift
//  50_Alt_50-Customer
//
//  Created by dirtbag on 4/25/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import UIKit

struct LineItem {
    
    var id : Int
    var title : String
    var price : String
    var image : String
    var selected : Bool
    var quantity : Int
    
}

class MainTableViewController: UITableViewController {
    
    var data = [
        LineItem(id: 1, title: "Garlic", price: "$4/lbs", image: "garlic", selected: false, quantity: 0),
        LineItem(id: 2, title: "Canteloupe", price: "$0.52/lbs", image: "cantaloupe", selected: false, quantity: 5),
        LineItem(id: 3, title: "Honeydew", price: "$0.83/lbs", image: "honeydew", selected: false, quantity: 0),
        LineItem(id: 4, title: "Red Pepper", price: "$2.32/lbs", image: "red_pepper", selected: false, quantity: 10),
    ]
    

    override func viewDidLoad() {
        super.viewDidLoad()

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
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomerCell", for: indexPath)
            cell.selectionStyle = .blue
        
        let lineItem = data[indexPath.row]
        cell.textLabel?.text = lineItem.title
        cell.detailTextLabel?.text = lineItem.price
        
        let image = UIImage(named: lineItem.image)
        cell.imageView?.image = image
        // Configure the cell...
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let lineItem = data[indexPath.row]
        
        updateQuanityOnUI(lineItem: lineItem, indexPath: indexPath)
        
    }
    
    func updateQuanityOnUI(lineItem: LineItem, indexPath: IndexPath) {
        var cell = tableView.cellForRow(at: indexPath)!
        
        if lineItem.selected {
            cell.accessoryType = .none
            cell.detailTextLabel?.text = lineItem.price
            data[indexPath.row].selected = false
        } else {
            getQuantity(indexPath: indexPath, cell: cell)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func getQuantity(indexPath: IndexPath, cell: UITableViewCell) {
        
        let lineItem = data[indexPath.row]
        
        var alert = UIAlertController(title: lineItem.title, message: "How many pounds would you like?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Save", style: UIAlertAction.Style.default) {
            UIAlertAction in
            
            print (alert.textFields![0].text!)
            if let quantity = Int(alert.textFields![0].text!) {
                self.data[indexPath.row].selected = true
                self.data[indexPath.row].quantity = quantity
                cell.accessoryType = .checkmark
                cell.detailTextLabel?.text = "\(quantity) x \(lineItem.price)"
            } else {
                print ("failed to parse")
            }
            
            print ("Done")
        })
        alert.addTextField(configurationHandler: {(textField: UITextField!) in
            textField.keyboardType = .numberPad
        //textField.placeholder = "Enter text:"
        })
        self.present(alert, animated: true, completion: nil)
    }
}
