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
    @IBOutlet weak var howHealthScoringWorksTextView: UITextView!
    @IBOutlet weak var howHealthScoringWorksTextViewHeight: NSLayoutConstraint!
    @IBOutlet weak var criticalViolationTextView: UITextView!
    @IBOutlet weak var criticalViolationTextViewHeight: NSLayoutConstraint!
    @IBOutlet weak var nonCriticalViolationTextView: UITextView!
    @IBOutlet weak var nonCriticalViolationTextViewHeight: NSLayoutConstraint!
    @IBOutlet weak var violationPointsTextView: UITextView!
    @IBOutlet weak var violationPointsTextViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupNavigationBarItems()
        
        howHealthScoringWorksTextView.text = Constants.howHealthScoringWorks
        criticalViolationTextView.text = Constants.criticalViolationsText
        nonCriticalViolationTextView.text = Constants.noncriticalViolationsText
        violationPointsTextView.text = Constants.pointExplanation
        
        updateViewConstraints()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        howHealthScoringWorksTextViewHeight.constant = howHealthScoringWorksTextView.contentSize.height
        criticalViolationTextViewHeight.constant = criticalViolationTextView.contentSize.height
        nonCriticalViolationTextViewHeight.constant = nonCriticalViolationTextView.contentSize.height
        violationPointsTextViewHeight.constant = violationPointsTextView.contentSize.height
    }
//    func setupNavigationBarItems() {
//        let logo = UIImage(named: "DineRiteNew")
//        var imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
//        imageView = UIImageView(image: logo)
//        imageView.contentMode = .scaleAspectFit
//        self.navigationItem.titleView = imageView
//    }
}
