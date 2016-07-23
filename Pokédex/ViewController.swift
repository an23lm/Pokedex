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
    var pokeSelected = 4
    let data = PokeData()
    var pokemon: [Pokemon] = []
    var pokeSearchResult: [Pokemon] = []
    var isSearching: Bool = false
    var rect: CGRect = CGRect.zero
    
    let transition = PopAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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

    override func viewWillAppear(_ animated: Bool) {
        pokeSearchTextField.text = ""
        pokeCollectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "PokeDetails" {
            print("segue")
            let destvc = segue.destinationViewController as? DetailViewController
            destvc?.transitioningDelegate = self
            destvc?.pokeNumber = pokeSelected
            destvc?.pokeData = data
        }
    }

    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.2, animations: {
            self.pokeSearchTextField.backgroundColor = UIColor.white()
            self.pokeSearchTextField.textColor = self.pokeTitleBar.backgroundColor
        })
    }
    @IBAction func textFieldDidChange(_ sender: AnyObject) {
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
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.2, animations: {
            self.pokeSearchTextField.backgroundColor = UIColor.clear()
            self.pokeSearchTextField.textColor = UIColor.white()
        })
        if textField.isFirstResponder() {
            textField.resignFirstResponder()
        }
        isSearching = false
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return false
    }
    func searchPokemon(withPartialName name: String) {
        for poke in pokemon {
            if poke.name.lowercased().contains(name.lowercased()) {
                pokeSearchResult.append(poke)
            }
        }
        print(pokeSearchResult.count)
    }
    func searchPokemon(withPartialNumber number: Int) {
        for poke in pokemon {
            if poke.id == number {
                pokeSearchResult.append(poke)
            }
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearching {
            return pokeSearchResult.count
        }
        return pokemon.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = pokeCollectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCollectionViewCell
        let pokeImageName: String
        if !isSearching {
            pokeImageName = "\(pokemon[indexPath.item!].id)"
        }
        else {
            pokeImageName = "\(pokeSearchResult[indexPath.item!].id)"
        }
        let pokeImage = UIImage(named: pokeImageName)
        cell?.pokeImageView.image = pokeImage
        cell?.pokeImageView.contentMode = UIViewContentMode.scaleAspectFill
        cell?.clipsToBounds = true
        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: 70, height: 70)
        return size
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.layoutIfNeeded()
        if indexPath.item == 1 {
            let cel = cell as? PokeCollectionViewCell
            print(cel?.pokeImageView.frame)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !isSearching {
            pokeSelected = pokemon[indexPath.item!].id
        }
        else {
            pokeSelected = pokeSearchResult[indexPath.item!].id
        }
        let att = pokeCollectionView.layoutAttributesForItem(at: indexPath)
        rect = (att?.frame)!
        performSegue(withIdentifier: "PokeDetails", sender: nil)
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    func animationController(
        forPresentedController presented: UIViewController,
        presenting: UIViewController,
        sourceController source: UIViewController) ->
        UIViewControllerAnimatedTransitioning? {
            transition.originFrame = pokeCollectionView.convert(rect, to: pokeCollectionView.superview)
            print(transition.originFrame)
            transition.presenting = true
            transition.pokeNumber = pokeSelected
            return transition
    }
    func animationController(forDismissedController dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}
