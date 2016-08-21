//
//  ViewController.swift
//  Pokédex
//
//  Created by Ansèlm Joseph on 21/7/16.
//  Copyright © 2016 an23lm. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var pokeTitleBar: UIView!
    @IBOutlet weak var pokeCollectionView: UICollectionView!
    @IBOutlet weak var pokeSearchTextField: UITextField!
    
    var cellIndexPath = NSIndexPath(forItem: 0, inSection: 0)
    var pokeSelected = 4
    let data: PokeData = PokeData()
    var pokemon: [Pokemon] = []
    var pokeSearchResult: [Pokemon] = []
    var isSearching: Bool = false
    var rect: CGRect = CGRect.zero
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    let transition = PopAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        let defaults = NSUserDefaults.standardUserDefaults()
        if let trianerLevel = defaults.stringForKey("trainerLevel") {
            data.trainerLevel = Int(trianerLevel)!
        }
        
        let pokeCollectionViewLayout = pokeCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        pokeCollectionViewLayout?.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        pokeCollectionViewLayout?.invalidateLayout()
        pokeCollectionView.contentInset.top = 60
        pokemon = data.pokemon
        
        self.view.clipsToBounds = true
        self.pokeTitleBar.clipsToBounds = true
        self.pokeCollectionView.clipsToBounds = true
        self.view.layer.cornerRadius = 5
        self.view.layer.masksToBounds = true
    }

    override func viewWillAppear(animated: Bool) {
        pokeSearchTextField.text = ""
        pokeCollectionView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        
        if segue.identifier == "PokeDetails" {
            //print("segue")
            let destvc = segue.destinationViewController as? DetailViewController
            destvc?.transitioningDelegate = self
            destvc?.pokeNumber = pokeSelected
            destvc?.pokeData = data
            destvc?.isFirstDetailVC = true
        }
    }

    func textFieldDidBeginEditing(textField: UITextField) {
        UIView.animateWithDuration(0.2, animations: {
            self.pokeSearchTextField.backgroundColor = UIColor.whiteColor()
            self.pokeSearchTextField.textColor = self.pokeTitleBar.backgroundColor
        })
    }
    
    @IBAction func textFieldDidChange(sender: AnyObject) {
        if sender.text != "" {
            isSearching = true
            pokeSearchResult.removeAll()
            if let num = Int(sender.text) {
                searchPokemon(withPartialNumber: num)
            }
            searchPokemon(withPartialName: sender.text!)
            pokeCollectionView.reloadData()
        }
        else {
            isSearching = false
            pokeCollectionView.reloadData()
        }
    }
    func textFieldDidEndEditing(textField: UITextField) {
        UIView.animateWithDuration(0.2, animations: {
            self.pokeSearchTextField.backgroundColor = UIColor.clearColor()
            self.pokeSearchTextField.textColor = UIColor.whiteColor()
        })
        if textField.isFirstResponder() {
            textField.resignFirstResponder()
        }
        isSearching = false
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.endEditing(true)
        return false
    }
    func searchPokemon(withPartialName name: String) {
        for poke in pokemon {
            if poke.name.lowercaseString.containsString(name.lowercaseString) {
                pokeSearchResult.append(poke)
            }
        }
        //print(pokeSearchResult.count)
    }
    func searchPokemon(withPartialNumber number: Int) {
        for poke in pokemon {
            if poke.id == number {
                pokeSearchResult.append(poke)
            }
        }
    }
    
    @IBAction override func unwindForSegue(unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        super.unwindForSegue(unwindSegue, towardsViewController: subsequentVC)
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearching {
            return pokeSearchResult.count
        }
        return pokemon.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = pokeCollectionView.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokeCollectionViewCell
        let pokeImageName: String
        if !isSearching {
            pokeImageName = "\(pokemon[indexPath.item].id)"
        }
        else {
            pokeImageName = "\(pokeSearchResult[indexPath.item].id)"
        }
        let pokeImage = UIImage(named: pokeImageName)
        cell?.pokeImageView.image = pokeImage
        cell?.pokeImageView.contentMode = UIViewContentMode.ScaleAspectFit
        cell?.clipsToBounds = true
        return cell!
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let size = CGSize(width: 70, height: 70)
        return size
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        cell.layoutIfNeeded()
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if !isSearching {
            pokeSelected = pokemon[indexPath.item].id
        }
        else {
            pokeSelected = pokeSearchResult[indexPath.item].id
        }
        cellIndexPath = indexPath
        //let att = pokeCollectionView.layoutAttributesForItem(at: indexPath)
        let att = pokeCollectionView.layoutAttributesForItemAtIndexPath(indexPath)
        rect = (att?.frame)!
        self.performSegueWithIdentifier("PokeDetails", sender: nil)
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.originFrame = pokeCollectionView.convertRect(rect, toView: pokeCollectionView.superview)
        //print(transition.originFrame)
        transition.presenting = true
        transition.pokeNumber = pokeSelected
        transition.cellIndexPath = cellIndexPath
        return transition
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}
