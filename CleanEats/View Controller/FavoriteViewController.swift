//
//  FavoriteViewController.swift
//  CleanEats
//
//  Created by Justin Trautman on 7/19/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
        
        static let shared = FavoriteViewController()
    
    // MARK: - Outlets
   
    @IBOutlet weak var favoriteTableView: UITableView!
    
    // MARK: - View Lifecycle
        override func viewDidLoad() {
            super.viewDidLoad()
            
            //setupNavigationBarItems()
            
            favoriteTableView.delegate = self
            favoriteTableView.dataSource = self
            
            updateTableView()
        }
        
        //    // Adding Image to Navigation Item
        //    func setupNavigationBarItems() {
        //        let logo = UIImage(named: "DineRiteNew")
        //        var imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        //        imageView = UIImageView(image: logo)
        //        imageView.contentMode = .scaleAspectFit
        //        self.navigationItem.titleView = imageView
        //    }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            setUpNavbarHeight()
            updateTableView()
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
    
    func updateTableView() {
        
        if FavoriteController.shared.favorites.count == 0 {
            showNoFavoritesAlert()
            favoriteTableView.tableFooterView = UIView()
            
            print(FavoriteController.shared.favorites.count)
        }
        
        guard let tableView = favoriteTableView else { return }
        
        tableView.reloadData()
    }
    
    func showNoFavoritesAlert() {
        
        let noFavoritesAlert = UIAlertController(title: nil, message: "You have no saved favorites!", preferredStyle: .alert)
        noFavoritesAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(noFavoritesAlert, animated: true)
    }
}

// MARK: - TableView Datasource 
extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return FavoriteController.shared.favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as? FavoriteTableViewCell else { return  UITableViewCell() }
        
        let favorite = FavoriteController.shared.favorites[indexPath.row]
        
//        cell.restaurantNameLabel.text = favorite.restaurantName
//        cell.restaurantImageView.image = UIImage(named: "Spitz1")
//        cell.restaurantRatingImageView.image = UIImage(named: "4Star")
//        cell.restaurantScoreLabel.text = "\(cell.restaurantScoreLabel)"
//        cell.restaurantPhoneNumber.text = "\(cell.restaurantPhoneNumber)"
//        cell.restaurantDescriptionLabel.text = "\(cell.restaurantDescriptionLabel)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let favorite = FavoriteController.shared.favorites[indexPath.row]
            
            FavoriteController.shared.delete(favorite: favorite)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
