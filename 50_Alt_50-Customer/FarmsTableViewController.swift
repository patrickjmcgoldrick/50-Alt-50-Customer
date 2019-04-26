//
//  FarmsTableViewController.swift
//  50_Alt_50-Customer
//
//  Created by dirtbag on 4/26/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import UIKit

struct FarmItem {
    
    var id : Int
    var name : String
    var distance : Float
}

class FarmsTableViewController: UITableViewController {
    
    let sectionNames = ["Lattin Farm", "Carson River Farm", "Medwaldt Organics"]
    var data = [
        FarmItem(id: 1, name: "Lattin Farm", distance: 35.0),
        FarmItem(id: 1, name: "Carson River Farm", distance: 45.0),
        FarmItem(id: 1, name: "Medwaldt Organics", distance: 50.0),
    ]
    
    var selectedIndex = 0
    
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

    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sectionNames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FarmCell", for: indexPath)

        // Configure the cell...
        let farmItem = data[indexPath.row]
        cell.textLabel?.text = farmItem.name
        cell.detailTextLabel?.text = "\(farmItem.distance) miles away"

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "detailSegue", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let controller = (segue.destination as! UINavigationController).topViewController as! MainTableViewController
        controller.rowIndex = selectedIndex
        controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        controller.navigationItem.leftItemsSupplementBackButton = true

    }
    

}
