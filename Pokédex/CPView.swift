//
//  CPView.swift
//  Pokédex
//
//  Created by Ansèlm Joseph on 23/7/16.
//  Copyright © 2016 an23lm. All rights reserved.
//

import UIKit

@IBDesignable class CPView: UIView {

    @IBInspectable var currentCP: Int = 50
    @IBInspectable var maxCP: Int = 150
    @IBInspectable var levelCap: Int = 100
    
    @IBInspectable var color1: UIColor = UIColor.blueColor()
    @IBInspectable var color2: UIColor = UIColor(white: 1, alpha: 0.4)
    @IBInspectable var color3: UIColor = UIColor.cyanColor()
    
    let π:CGFloat = CGFloat(M_PI)
    
    override func drawRect(rect: CGRect) {
     
        let center = CGPoint(x: bounds.width/2, y: bounds.height)
        let radius = max(bounds.width, bounds.height)
        let arcWidth: CGFloat = 5.0
        let startAngle: CGFloat = π
        let endAngle: CGFloat = 0
     
        let path = UIBezierPath(arcCenter: center,
                                radius: radius/2.0 - CGFloat(arcWidth)/2.0,
                                startAngle: startAngle,
                                endAngle: endAngle,
                                clockwise: true)
        
        path.lineWidth = arcWidth
        color2.setStroke()
        path.stroke()
        
        let angleDifference: CGFloat = 2 * π - startAngle + endAngle
        
        let arcLengthPerGlass = angleDifference / CGFloat(maxCP)
        
        
        var outlineEndAngle = arcLengthPerGlass * CGFloat(levelCap) + startAngle
        
        var outlinePath = UIBezierPath(arcCenter: center,
                                   radius: radius/2.0 - CGFloat(arcWidth)/2.0,
                                   startAngle: startAngle,
                                   endAngle: outlineEndAngle,
                                   clockwise: true)
        
        color3.setStroke()
        outlinePath.lineWidth = arcWidth
        outlinePath.stroke()
        

        outlineEndAngle = arcLengthPerGlass * CGFloat(currentCP) + startAngle
        
        outlinePath = UIBezierPath(arcCenter: center,
                                radius: radius/2.0 - CGFloat(arcWidth)/2.0,
                                startAngle: startAngle,
                                endAngle: outlineEndAngle,
                                clockwise: true)
        
        color1.setStroke()
        outlinePath.lineWidth = arcWidth
        outlinePath.stroke()
        
    }
}
