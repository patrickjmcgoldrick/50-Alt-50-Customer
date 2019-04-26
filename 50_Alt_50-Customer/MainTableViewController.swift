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
    var price : Float
    var image : String
    var selected : Bool
    var quantity : Int
    
}

class MainTableViewController: UITableViewController {
    let sectionSizes = [4, 3, 2]
    let sectionNames = ["Lattin Farm (15 mi)", "Carson River Farm (25 mi)", "Medwaldt Organics (40 mi)"]
    
    var data = [
        LineItem(id: 1, title: "Garlic", price: 4.0, image: "garlic", selected: false, quantity: 0),
        LineItem(id: 2, title: "Canteloupe",  price: 0.52, image: "cantaloupe", selected: false, quantity: 0),
        LineItem(id: 3, title: "Honeydew", price: 0.83, image: "honeydew", selected: false, quantity: 0),
        LineItem(id: 4, title: "Red Pepper", price: 2.32, image: "red_pepper", selected: false, quantity: 0),
        LineItem(id: 5, title: "Radishes", price: 1.46, image: "radishes", selected: false, quantity: 0),
        LineItem(id: 6, title: "Beets", price: 0.94, image: "beets", selected: false, quantity: 0),
        LineItem(id: 7, title: "Green Peas", price: 1.66, image: "green_peas", selected: false, quantity: 0),
        LineItem(id: 8, title: "Ace Tomatos", price: 2.25, image: "ace_tomatos", selected: false, quantity: 0),
        LineItem(id: 9, title: "Asian Baby Eggplant", price: 2.25, image: "baby_eggplant", selected: false, quantity: 0),    ]
    
    var footer: FooterTableViewCell?
    
    public var rowIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return sectionNames.count
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sectionSizes[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomerCell", for: indexPath)
            cell.selectionStyle = .blue
        
        let lineItem = data[indexPath.row]
        cell.textLabel?.text = lineItem.title
        cell.detailTextLabel?.text = "$\(lineItem.price)/lbs"

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
            cell.detailTextLabel?.text = "$\(lineItem.price)/lbs"
            data[indexPath.row].selected = false
            let sum = calculateTotal()
            let sumString = String.localizedStringWithFormat("%.2F", sum)
            self.footer?.lblTotal.text = "Total $\(sumString)"
            
        } else {
            getQuantity(indexPath: indexPath, cell: cell)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionNames[rowIndex]
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
//        if section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FooterCell") as! FooterTableViewCell
            
            footer = cell
            return cell
//        }
//
//        return nil
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
            
            if let quantity = Int(alert.textFields![0].text!) {
                self.data[indexPath.row].selected = true
                self.data[indexPath.row].quantity = quantity
                cell.accessoryType = .checkmark
                cell.detailTextLabel?.text = "\(quantity) x $\(lineItem.price)/lbs"
                
                let sum = self.calculateTotal()
                
                let sumString = String.localizedStringWithFormat("%.2F", sum)
                
                self.footer?.lblTotal.text = "Total $\(sumString)"
                
            } else {
                print ("failed to parse")
            }
            
        })
        alert.addTextField(configurationHandler: {(textField: UITextField!) in
            textField.keyboardType = .numberPad
        //textField.placeholder = "Enter text:"
        })
        self.present(alert, animated: true, completion: nil)
    }
    
    func calculateTotal() -> Float {
        var sum: Float = 0.0
        for row in data {
            if row.selected == true {
                sum += Float(row.quantity) * row.price
            }
        }
        return sum
    }
}
