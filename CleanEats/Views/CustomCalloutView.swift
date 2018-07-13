//
//  CustomCalloutView.swift
//
//
//  Created by Huzaifa Gadiwala on 12/7/18.
//
import UIKit

@IBDesignable class CustomCalloutView: UIView {
    
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var restaurantPrice: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var restaurantDistance: UILabel!
    
    @IBInspectable var cornerRadius: CGFloat = 5 {
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
