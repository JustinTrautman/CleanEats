//
//  FavoriteViewController.swift
//  CleanEats
//
//  Created by Justin Trautman on 7/19/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import UIKit
import CoreData

class FavoritesViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var favoriteTableView: UITableView!
    
    // MARK: Properties
    let fetchedResultsController: NSFetchedResultsController<Favorite> = {
        let internalFetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        
        internalFetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        return NSFetchedResultsController(fetchRequest: internalFetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
    }()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
                
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Error performing fetch from results controller. \(error.localizedDescription)")
        }
        
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        favoriteTableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBarItems()
        updateTableView()
    }
    
    // Adding Image to Navigation Item
    func setupNavigationBarItems() {
        let logo = UIImage(named: "DineRiteNew")
        var imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 5))
        imageView = UIImageView(image: logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
    }
    
    func updateTableView() {
        if self.fetchedResultsController.fetchedObjects?.count == 0 {
            self.favoriteTableView.setEmptyMessage("You don't have any saved favorites! Go explore the map and click the star icon on the restaurants you like!")
        } else {
            self.favoriteTableView.backgroundView = UIView()
        }
        
        DispatchQueue.main.async {
            self.favoriteTableView.reloadData()
        }
    }
}

// MARK: - TableView Datasource
extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as? FavoriteTableViewCell else { return  UITableViewCell() }

        guard let favorites = fetchedResultsController.fetchedObjects else {
            return cell
        }

        let favorite = favorites[indexPath.row]
        cell.favorite = favorite

        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let favorite = fetchedResultsController.fetchedObjects?[indexPath.row] {
                FavoriteController.delete(favorite: favorite)
            }
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - FetchResultsControllerDelegate Methods
extension FavoritesViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            guard let indexPath = indexPath else { return }
            favoriteTableView.deleteRows(at: [indexPath], with: .fade)

        case .insert:
            guard let indexPath = newIndexPath else { return }
            favoriteTableView.insertRows(at: [indexPath], with: .automatic)

        case .move:
            guard let indexPath = indexPath,
                let newIndexPath = newIndexPath else { return }
            favoriteTableView.moveRow(at: indexPath, to: newIndexPath)

        case .update:
            guard let indexPath = indexPath else { return }
            favoriteTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}
