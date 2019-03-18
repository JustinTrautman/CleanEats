//
//  AboutViewController.swift
//  CleanEats
//
//  Created by Huzaifa Gadiwala on 9/7/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var howHealthScoringWorksExplanationLabel: UILabel!
    @IBOutlet weak var criticalViolationExplanationLabel: UILabel!
    @IBOutlet weak var nonCriticalViolationExplanationLabel: UILabel!
    @IBOutlet weak var violationPointsExplanationLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarItems()
        
        howHealthScoringWorksExplanationLabel.text = Constants.howHealthScoringWorks
        criticalViolationExplanationLabel.text = Constants.criticalViolationsText
        nonCriticalViolationExplanationLabel.text = Constants.noncriticalViolationsText
        violationPointsExplanationLabel.text = Constants.pointExplanation
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Dynamically adjust label height
        howHealthScoringWorksExplanationLabel.setHeight(parentView: view)
        criticalViolationExplanationLabel.setHeight(parentView: view)
        nonCriticalViolationExplanationLabel.setHeight(parentView: view)
        violationPointsExplanationLabel.setHeight(parentView: view)
    }
    
    func setupNavigationBarItems() {
        let logo = UIImage(named: "DineRiteNew")
        var imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        imageView = UIImageView(image: logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
    }
}
