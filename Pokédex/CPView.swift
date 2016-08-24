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
    
    var currentPositionCpCap: CGFloat = 0
    var currentPositionCurrentCp: CGFloat = 0
    
    @IBInspectable var color1: UIColor = UIColor.blueColor()
    @IBInspectable var color2: UIColor = UIColor(white: 1, alpha: 0.4)
    @IBInspectable var color3: UIColor = UIColor.cyanColor()
    
    let π: CGFloat = CGFloat(M_PI)
    
    var maxCpCircleLayer: CAShapeLayer!
    var cpCapCircleLayer: CAShapeLayer!
    var currentCpCircleLayer: CAShapeLayer!
    
    var ucenter: CGPoint!
    var radius: CGFloat!
    var arcWidth: CGFloat = 5
    let startAngle: CGFloat = CGFloat(M_PI)
    let endAngle: CGFloat = 0
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        setup()
    }
    
    func setup() {
        ucenter = CGPoint(x: bounds.width/2, y: bounds.height)
        radius = min(bounds.width, bounds.height)
    }
    
    func animate(duration: NSTimeInterval) {
        
        self.animateCircles(1.0)
        
    }
    
    
    func animateCircles(duration: NSTimeInterval) {
        
        var circlePath = UIBezierPath(arcCenter: ucenter,
                                      radius: radius,
                                      startAngle: startAngle,
                                      endAngle: endAngle,
                                      clockwise: true)
        
        
        maxCpCircleLayer = CAShapeLayer()
        maxCpCircleLayer.path = circlePath.CGPath
        maxCpCircleLayer.fillColor = UIColor.clearColor().CGColor
        maxCpCircleLayer.strokeColor = color2.CGColor
        maxCpCircleLayer.lineWidth = 7
        maxCpCircleLayer.strokeEnd = 0
        maxCpCircleLayer.lineCap = kCALineCapRound
        layer.addSublayer(maxCpCircleLayer)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        maxCpCircleLayer.strokeEnd = 1
        maxCpCircleLayer.addAnimation(animation, forKey: "animateCircles")
        
        
        circlePath = UIBezierPath(arcCenter: ucenter,
                                   radius: radius,
                                   startAngle: startAngle,
                                   endAngle: endAngle,
                                   clockwise: true)
        
        cpCapCircleLayer = CAShapeLayer()
        cpCapCircleLayer.path = circlePath.CGPath
        cpCapCircleLayer.fillColor = UIColor.clearColor().CGColor
        cpCapCircleLayer.strokeColor = color3.CGColor
        cpCapCircleLayer.lineWidth = 2
        cpCapCircleLayer.strokeEnd = 0
        cpCapCircleLayer.lineCap = kCALineCapRound
        layer.addSublayer(cpCapCircleLayer)
        
        circlePath = UIBezierPath(arcCenter: ucenter,
                                  radius: radius,
                                  startAngle: startAngle,
                                  endAngle: endAngle,
                                  clockwise: true)
        
        
        currentCpCircleLayer = CAShapeLayer()
        currentCpCircleLayer.path = circlePath.CGPath
        currentCpCircleLayer.fillColor = UIColor.clearColor().CGColor
        currentCpCircleLayer.strokeColor = color1.CGColor
        currentCpCircleLayer.lineWidth = 7.2
        currentCpCircleLayer.strokeEnd = 0
        currentCpCircleLayer.lineCap = kCALineCapRound
        layer.addSublayer(currentCpCircleLayer)
        
    }
    
    func animateCpCapCircle(duration: NSTimeInterval) {
        
        
        let currentValue = CGFloat(levelCap)/CGFloat(maxCP)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = currentPositionCpCap
        animation.toValue = currentValue
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    
        cpCapCircleLayer.strokeEnd = currentValue
        cpCapCircleLayer.addAnimation(animation, forKey: "animateCpCapCircle")
        
        currentPositionCpCap = currentValue
        
    }

    func animateCurrentCpCircle(duration: NSTimeInterval) {
        
        let currentValue = CGFloat(currentCP)/CGFloat(maxCP)
        
        let animation = CABasicAnimation(keyPath: "stokeEnd")
        animation.duration = duration
        animation.fromValue = currentPositionCurrentCp
        animation.toValue = currentValue
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        currentCpCircleLayer.strokeEnd = currentValue
        currentCpCircleLayer.addAnimation(animation, forKey: "animateCurrentCpCircle")
        
        currentPositionCurrentCp = currentValue
    }
}