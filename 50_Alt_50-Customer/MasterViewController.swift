//
//  MasterViewController.swift
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

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil

    var farms = [
        FarmItem(id: 1, name: "Lattin Farm", distance: 15.0),
        FarmItem(id: 2, name: "Carson River Farm", distance: 25.0),
        FarmItem(id: 3, name: "Medwaldt Organics", distance: 40.0),
    ]
    
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        addLogo()
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
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
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                
                // pass section choice to Detail view
                controller.selectedSection = indexPath.row
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return farms.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let farmItem = farms[indexPath.row]
        cell.textLabel?.text = farmItem.name
        cell.detailTextLabel?.text = "\(farmItem.distance) miles away"

        return cell
    }

}

