//
//  RestaurantProfileViewController.swift
//  CleanEats
//
//  Created by Joshua Danner on 6/28/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import UIKit

class RestaurantProfileViewController: UIViewController, UIScrollViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slideScrollView.delegate = self
        slides = createSlides()
        setupSlideScrollView(slides: slides)
        slidePageControl.numberOfPages = slides.count
        slidePageControl.currentPage = 0
        view.bringSubview(toFront: slidePageControl)
    }
    
    // Horizontal ScrollView
    var slides: [Slide] = []
    
    func createSlides() -> [Slide] {
        let slide1 : Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide1.slideImageView.image = UIImage(named: "pooh1")
        slide1.contentMode = .scaleAspectFit
        let slide2 : Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide2.slideImageView.image = UIImage(named: "pooh2")
        slide2.contentMode = .scaleAspectFit
        let slide3 : Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide3.slideImageView.image = UIImage(named: "pooh3")
        slide3.contentMode = .scaleAspectFit
        let slide4 : Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide4.slideImageView.image = UIImage(named: "pooh4")
        slide4.contentMode = .scaleAspectFit
        let slide5 : Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide5.slideImageView.image = UIImage(named: "pooh5")
        slide5.contentMode = .scaleAspectFit
        
        return [slide1, slide2, slide3, slide4, slide5]
    }
    
    func setupSlideScrollView(slides : [Slide]) {
        
        slideScrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height / 4.4)
        slideScrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height / 4.4)
        slideScrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            slideScrollView.addSubview(slides[i])
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        slidePageControl.currentPage = Int(pageIndex)
        
        let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
        let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
        
        // vertical
        let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
        let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
        
        let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
        let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
        
    }
    
    
    
    
    // MARK: - IBActions
    
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        
        let getIndex = segmentedControl.selectedSegmentIndex
        switch getIndex
        {
        case 0:
            print("First Segment Selected")
            aboutContainerView.isHidden = false
            healthRatingContainerView.isHidden = true
            reviewContainerView.isHidden = true
        case 1:
            print("Second Segment Selected")
            aboutContainerView.isHidden = true
            healthRatingContainerView.isHidden = false
            reviewContainerView.isHidden = true
        case 2:
            print("Third segment selected")
            aboutContainerView.isHidden = true
            healthRatingContainerView.isHidden = true
            reviewContainerView.isHidden = false
            
        default:
            break
        }
        
    }
    
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var aboutContainerView: UIView!
    @IBOutlet weak var healthRatingContainerView: UIView!
    @IBOutlet weak var reviewContainerView: UIView!
    
    @IBOutlet weak var slideScrollView: UIScrollView!{
        didSet {
            slideScrollView.delegate = self
        }
    }
    @IBOutlet weak var slidePageControl: UIPageControl!
    
}




