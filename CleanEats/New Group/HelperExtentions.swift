//
//  HelperExtentions.swift
//  CleanEats
//
//  Created by Huzaifa Gadiwala on 19/7/18.
//  Copyright © 2018 Justin Trautman. All rights reserved.
//

import UIKit
extension UINavigationBar {
    
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
       
        return CGSize(width: UIScreen.main.bounds.size.width, height: 80.0)
    }
    
}



extension UINavigationController {
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
}
 

