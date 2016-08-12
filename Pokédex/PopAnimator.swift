//
//  PopAnimator.swift
//  Pokédex
//
//  Created by Ansèlm Joseph on 23/7/16.
//  Copyright © 2016 an23lm. All rights reserved.
//

import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration    = 0.5
    var presenting  = true
    var originFrame = CGRect.zero
    var pokeNumber = 0
    var cellIndexPath = NSIndexPath(forItem: 0, inSection: 0)
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView()
        
        if presenting {
            
            let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        
            let toViewController = (transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as? DetailViewController)!
            
            let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
            let fromViewController = (transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as? ViewController)!
            
            let finalFrame = toViewController.pokeImageView.convertRect(toViewController.pokeImageView.bounds, toView: toView)
            
            let imageView = UIImageView(frame: finalFrame)
            imageView.image = UIImage(named: "\(pokeNumber)")
            imageView.contentMode = UIViewContentMode.ScaleAspectFit
            
            let initalFrame = CGRect(x: originFrame.origin.x + 8, y: originFrame.origin.y + 8, width: 50, height: 50)
            
            let scaleX = initalFrame.width/finalFrame.width
            let scaleY = initalFrame.height/finalFrame.height
            
            let scaleTransform = CGAffineTransformMakeScale(scaleX, scaleY)
            
            imageView.transform = scaleTransform
            imageView.center = CGPoint(x: initalFrame.midX, y: initalFrame.midY)
            imageView.clipsToBounds = true
            
            let navBar = toViewController.titleBarView
            let navBarY = (navBar?.frame.height)!
            navBar?.frame.origin.y -= navBarY
            
            let baseView = toViewController.pokeScrollView
            let baseViewY = baseView?.frame.height
            baseView?.frame.origin.y += baseViewY!
            
            let backViewTitleBarColor = UIColor(red: 35/255, green: 53/255, blue: 145/255, alpha: 1)
            let backViewColor = UIColor(red: 53/255, green: 74/255, blue: 164/255, alpha: 1)
            let backViewTransform = CGAffineTransformMakeScale(0.9, 0.9)
            
            let cell = fromViewController.pokeCollectionView.cellForItemAtIndexPath(cellIndexPath) as? PokeCollectionViewCell
            let cellImage = cell?.pokeImageView
            
            _ = fromViewController.blurView
            
            let viewColor = toView.backgroundColor
            toView.backgroundColor = UIColor.clearColor()
            toViewController.pokeImageView.alpha = 0
            containerView!.addSubview(toView)
            containerView!.addSubview(imageView)
            cellImage?.hidden = true
            
            UIView.animateWithDuration(duration, animations: {
                imageView.transform = CGAffineTransformIdentity
                imageView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
                navBar?.frame.origin.y += navBarY
                baseView?.frame.origin.y -= baseViewY!
                fromView.transform = backViewTransform
                fromViewController.pokeTitleBar.backgroundColor = UIColor(red: 46/255, green: 55/255, blue: 146/255, alpha: 1)
                fromViewController.pokeCollectionView.backgroundColor = UIColor(red: 26/255, green: 35/255, blue: 126/255, alpha: 1)
            },
                           completion: {
                            _ in
                            cellImage?.hidden = false
                            fromViewController.pokeTitleBar.backgroundColor = backViewTitleBarColor
                            fromViewController.pokeCollectionView.backgroundColor = backViewColor
                            fromView.transform = CGAffineTransformIdentity
                            toView.backgroundColor = viewColor
                            toViewController.pokeImageView.alpha = 1
                            imageView.removeFromSuperview()
                            transitionContext.completeTransition(true)
            })
            
        }
    }
}
