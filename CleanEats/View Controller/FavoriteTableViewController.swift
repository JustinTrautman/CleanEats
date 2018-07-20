//
//  FavoriteTableViewController.swift
//  CleanEats
//
//  Created by Huzaifa Gadiwala on 5/7/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import UIKit

class FavoriteTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBarItems()
       // setUpNavbarHeight()
    }

    // Adding Image to Navigation Item
    func setupNavigationBarItems() {
        let logo = UIImage(named: "DineRiteNew")
        var imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        imageView = UIImageView(image: logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
    }
    
    func setUpNavbarHeight() {
        for subview in (self.navigationController?.navigationBar.subviews)! {
            if NSStringFromClass(subview.classForCoder).contains("BarBackground") {
                var subViewFrame: CGRect = subview.frame
                let subView = UIView()
                // subViewFrame.origin.y = -20;
                subViewFrame.size.height = 90
                subView.frame = subViewFrame
                // Convert an image view to a view
                // Constrain it to the center and size it
                let logo = UIImage(named: "DineRiteNew")
                var imageView = UIImageView()
                imageView = UIImageView(image: logo)
                imageView.contentMode = .scaleAspectFit
                //                self.navigationItem.titleView = imageView
                subView.addSubview(imageView)
                imageView.translatesAutoresizingMaskIntoConstraints = false
                imageView.topAnchor.constraint(equalTo: subView.topAnchor, constant: 0).isActive = true
                imageView.bottomAnchor.constraint(equalTo: subView.bottomAnchor, constant: -15).isActive = true
                imageView.centerXAnchor.constraint(equalTo: subView.centerXAnchor).isActive = true
                imageView.widthAnchor.constraint(equalToConstant: 114).isActive = true
                imageView.heightAnchor.constraint(equalToConstant: 35).isActive = true
                subview.backgroundColor = .clear
                //                navigationController?.navigationItem.titleView?.backgroundColor = .red
                navigationController?.navigationBar.addSubview(subView)
                
                //                let titleImage = #imageLiteral(resourceName: "DineRiteNew")
                //
                //                self.view.addSubview(titleImage)
            
        }
    }
}

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return RestaurantController.sharedRestaurant.restaurants.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteRestaurant", for: indexPath) as? FavoriteTableViewCell else {return  UITableViewCell()}
        let restaurant = RestaurantController.sharedRestaurant.restaurants[indexPath.row]
        cell.restaurant = restaurant
        
        return cell
    }
 


    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }  
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
