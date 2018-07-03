 //
 //  SearchPageViewController.swift
 //  CleanEats
 //
 //  Created by Justin Trautman on 6/27/18.
 //  Copyright © 2018 Justin Trautman. All rights reserved.
 //
 
 import UIKit
 
 class SearchPageViewController: UIViewController {
    
    static let sharedViewController = SearchPageViewController()
    
    // MARK: - Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var findFoodButton: UIButton!
    @IBOutlet weak var fastFoodButton: UIButton!
    @IBOutlet weak var deliveryButton: UIButton!
    
    // MARK: - Actions
    @IBAction func findFoodButtonTapped(_ sender: UIButton) {
    }
    
    // View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        initializeFindFoodButton()
        setupNavigationBarItems()
    }
    
    // Adding Image to Navigation Item
    func setupNavigationBarItems() {
        let logo = UIImage(named: "DineRiteNew")
        var imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        imageView = UIImageView(image: logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
    }
    
    
    func initializeFindFoodButton() {
        
        // Find Food Button
        findFoodButton?.layer.cornerRadius = 3.0
        findFoodButton?.clipsToBounds = true
        findFoodButton?.layer.shadowRadius = 3.0
        findFoodButton?.layer.cornerRadius = 30
        findFoodButton?.layer.shadowColor = UIColor.black.cgColor
        findFoodButton?.layer.shadowOpacity = 1.0
        findFoodButton?.layer.shadowOffset = CGSize(width: 5, height: 5)
        findFoodButton?.layer.masksToBounds = false
        findFoodButton?.backgroundColor = UIColor(displayP3Red: 0.25, green: 0.25, blue: 0.25, alpha: 1)
        findFoodButton?.setTitle("FIND FOOD", for: .normal)
        findFoodButton?.setTitleColor(.white, for: .normal)
        findFoodButton?.titleLabel?.font = UIFont(name: "Helvetica", size: 16)
    }
    
    @objc func startHighlight(sender: UIButton) {
        deliveryButton.layer.borderColor = UIColor.black.cgColor
        deliveryButton.layer.borderWidth = 3
    }
    @objc func stopHighlight(sender: UIButton) {
        deliveryButton.layer.borderColor = UIColor.black.cgColor
        deliveryButton.layer.borderWidth = 1
    }
 }
