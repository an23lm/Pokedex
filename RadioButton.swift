//
//  RadioButton.swift
//  Pokédex
//
//  Created by Ansèlm Joseph on 14/08/16.
//  Copyright © 2016 an23lm. All rights reserved.
//

import UIKit

class RadioButton: UIView {

    var fillColor: UIColor = UIColor(white: 1, alpha: 0.5)
    var highlightFillColor: UIColor = UIColor.blueColor()
    var strokeColor: UIColor = UIColor.whiteColor()
    
    var checkLayer: CAShapeLayer!
    var highlightLayer: CAShapeLayer!
    
    var cen: CGPoint = CGPointZero
    var rect: CGRect = CGRectZero
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        let path = UIBezierPath(ovalInRect: rect)
        fillColor.setFill()
        path.fill()
     
        cen.x = bounds.width/2
        cen.y = bounds.height/2
        self.rect = rect
    }
    
    func drawLayers() {
        
        var path = UIBezierPath(ovalInRect: CGRect(x: rect.origin.x - 5, y: rect.origin.y - 5, width: rect.width + 10, height: rect.height + 10))
        
        highlightLayer = CAShapeLayer()
        highlightLayer.path = path.CGPath
        highlightLayer.fillColor = highlightFillColor.CGColor
        highlightLayer.strokeColor = strokeColor.CGColor
        highlightLayer.lineWidth = 1
        highlightLayer.strokeEnd = 1
        highlightLayer.bounds = bounds
        highlightLayer.position = CGPoint(x: cen.x, y: cen.y)
        
        var transformation = CATransform3DIdentity
        transformation = CATransform3DScale(transformation, 0, 0, 0)
        highlightLayer.transform = transformation
        
        layer.addSublayer(highlightLayer)
        
        
        path = UIBezierPath()
        
        var x = cen.x - cen.x/1.1
        var y = cen.y
        
        path.moveToPoint(CGPoint(x: x, y: y))
        
        x = cen.x - (cen.x)/2.1
        y = cen.y + cen.y/1.5
        
        path.addLineToPoint(CGPoint(x: x, y: y))
        
        x = cen.x + (cen.x * 3)/3.5
        y = cen.y - (cen.y)/2
        
        path.addLineToPoint(CGPoint(x: x, y: y))
        
        checkLayer = CAShapeLayer()
        checkLayer.path = path.CGPath
        checkLayer.fillColor = UIColor.clearColor().CGColor
        checkLayer.strokeColor = strokeColor.CGColor
        checkLayer.lineWidth = 2
        checkLayer.strokeEnd = 0
        checkLayer.lineCap = kCALineCapRound
        layer.addSublayer(checkLayer)
    }
    
    func checkEnableAnimation() {
        var animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 0.5
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        checkLayer.strokeEnd = 1
        checkLayer.addAnimation(animation, forKey: "checkEnableAnimation")
        
        animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 0.5
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        var transformation = CATransform3DIdentity
        transformation = CATransform3DScale(transformation, 1, 1, 1)
        highlightLayer.transform = transformation
        highlightLayer.addAnimation(animation, forKey: "checkEnableAnimation")
    }
    
    func checkDisableAnimation() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 1
        animation.toValue = 0
        animation.duration = 1
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        checkLayer.strokeEnd = 0
        checkLayer.addAnimation(animation, forKey: "checkDisableAnimation")
    }

}
