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
    
    func transitionDuration(_ transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView()
        
        if presenting {
        
            let toView = transitionContext.view(forKey: UITransitionContextToViewKey)!
            let toViewController = (transitionContext.viewController(forKey: UITransitionContextToViewControllerKey) as? DetailViewController)!
            
            let fromView = transitionContext.view(forKey: UITransitionContextFromViewKey)!
            let fromViewController = (transitionContext.viewController(forKey: UITransitionContextFromViewControllerKey) as? ViewController)!
            
            let finalFrame = toViewController.pokeImageView.convert(toViewController.pokeImageView.bounds, to: toView)
            
            let imageView = UIImageView(frame: finalFrame)
            imageView.image = UIImage(named: "\(pokeNumber)")
            imageView.contentMode = UIViewContentMode.scaleAspectFit
            
            let initalFrame = CGRect(x: originFrame.origin.x + 8, y: originFrame.origin.y + 8, width: 50, height: 50)
            
            let scaleX = initalFrame.width/finalFrame.width
            let scaleY = initalFrame.height/finalFrame.height
            
            let scaleTransform = CGAffineTransform(scaleX: scaleX, y: scaleY)
            
            imageView.transform = scaleTransform
            imageView.center = CGPoint(x: initalFrame.midX, y: initalFrame.midY)
            imageView.clipsToBounds = true
            
            let navBar = toViewController.titleBarView
            let navBarY = (navBar?.frame.height)!
            navBar?.frame.origin.y -= navBarY
            
            let baseView = toViewController.pokeScrollView
            let baseViewY = baseView?.frame.height
            baseView?.frame.origin.y += baseViewY!
            
            let backViewTitleBarColor = fromViewController.pokeTitleBar.backgroundColor
            let backViewTransform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            
            let cell = fromViewController.pokeCollectionView.cellForItem(at: IndexPath(item: pokeNumber - 1, section: 0)) as? PokeCollectionViewCell
            let cellImage = cell?.pokeImageView
            
            let viewColor = toView.backgroundColor
            toView.backgroundColor = UIColor.clear()
            toViewController.pokeImageView.alpha = 0
            containerView.addSubview(toView)
            containerView.addSubview(imageView)
            cellImage?.isHidden = true
            
            UIView.animate(withDuration: duration, animations: {
                imageView.transform = CGAffineTransform.identity
                imageView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
                navBar?.frame.origin.y += navBarY
                baseView?.frame.origin.y -= baseViewY!
                fromView.transform = backViewTransform
                fromViewController.pokeTitleBar.backgroundColor = UIColor.black()
                fromViewController.pokeCollectionView.backgroundColor = UIColor.black()
            },
                           completion: {
                            _ in
                            cellImage?.isHidden = false
                            fromViewController.pokeTitleBar.backgroundColor = backViewTitleBarColor
                            fromViewController.pokeCollectionView.backgroundColor = viewColor
                            fromView.transform = CGAffineTransform.identity
                            toView.backgroundColor = viewColor
                            toViewController.pokeImageView.alpha = 1
                            imageView.removeFromSuperview()
                            transitionContext.completeTransition(true)
            })
            
        }
        
        /*
        let pokeDetailView = presenting ? toView : transitionContext.view(forKey: UITransitionContextFromViewKey)!
        
        
        let initialFrame = presenting ? originFrame : pokeDetailView.frame
        let finalFrame = presenting ? pokeDetailView.frame : originFrame
        
        let xScaleFactor = presenting ?
            initialFrame.width / finalFrame.width :
            finalFrame.width / initialFrame.width
        
        let yScaleFactor = presenting ?
            initialFrame.height / finalFrame.height :
            finalFrame.height / initialFrame.height
        
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        
        if presenting {
            pokeDetailView.transform = scaleTransform
            pokeDetailView.center = CGPoint(
                x: initialFrame.midX,
                y: initialFrame.midY)
            pokeDetailView.clipsToBounds = true
        }
        
        containerView.addSubview(toView)
        containerView.bringSubview(toFront: pokeDetailView)
        
        UIView.animate(withDuration: duration, delay:0.0,
                                   usingSpringWithDamping: 0.4,
                                   initialSpringVelocity: 0.0,
                                   options: [],
                                   animations: {
                                    pokeDetailView.transform = self.presenting ? CGAffineTransform.identity : scaleTransform
                                    
                                    pokeDetailView.center = CGPoint(x: finalFrame.midX,
                                                              y: finalFrame.midY)
                                    
            }, completion:{_ in
                transitionContext.completeTransition(true)
        })
 */
    }
}
