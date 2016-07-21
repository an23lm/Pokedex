//
//  ViewController.swift
//  Pokédex
//
//  Created by Ansèlm Joseph on 21/7/16.
//  Copyright © 2016 an23lm. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pokeCollectionView: UICollectionView!
    @IBOutlet weak var pokeSearchTextField: UITextField!
    var pokeSelected = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let pokeCollectionViewLayout = pokeCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        pokeCollectionViewLayout?.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        pokeCollectionViewLayout?.invalidateLayout()
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
            destvc?.pokeNumber = pokeSelected
        }
    }

    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        
    }

}

extension ViewController: UITextViewDelegate {
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 151
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = pokeCollectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCollectionViewCell
        //cell?.backgroundColor = UIColor.black()
        let pokeImageName = "\(indexPath.item! + 1)"
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
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        pokeSelected = indexPath.item! + 1
        performSegue(withIdentifier: "PokeDetails", sender: nil)
    }
}
