//
//  SelectPokemonViewController.swift
//  Pokédex
//
//  Created by Ansèlm Joseph on 19/08/16.
//  Copyright © 2016 an23lm. All rights reserved.
//

import UIKit

protocol SelectedPokemonDelegate {
    func pokemonSelected(pokemon: Pokemon)
}

class SelectPokemonViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    var selectedId: Int! = nil
    
    var pokeData: PokeData! = nil
    var pokemon: Pokemon! = nil
    
    var delegate: SelectedPokemonDelegate! = nil
    
    var pokeList: [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleView.backgroundColor = pokemon.secondaryColor
        titleLabel.textColor = pokemon.tertiaryColor
        backButton.setTitleColor(pokemon.tertiaryColor, forState: .Normal)
        view.backgroundColor = pokemon.primaryColor
        tableView.backgroundColor = pokemon.primaryColor
        
        searchTextField.layer.cornerRadius = 5
        pokeList = pokeData.pokemon
        
        tableView.contentInset.top = 56
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension SelectPokemonViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokeList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PokeCell") as! PokeTableViewCell
        
        let poke = pokeList[indexPath.row]
        cell.nameLabel.text = poke.name
        cell.idLabel.text = String(poke.id)
        cell.pokeImageView.image = UIImage(named: "\(poke.id)")
        cell.pokeImageView.contentMode = UIViewContentMode.ScaleAspectFit
        cell.contentView.backgroundColor = poke.primaryColor
        cell.nameLabel.textColor = poke.secondaryColor
        cell.idLabel.textColor = poke.secondaryColor
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        delegate.pokemonSelected(pokeList[indexPath.row])
        performSegueWithIdentifier("unwindSegue", sender: nil)
    }
}

extension SelectPokemonViewController: UITextFieldDelegate {
    
    @IBAction func textFieldDidChange(sender: UITextField) {
        
        print(sender.text)
        
        if sender.text == "" {
            pokeList = pokeData.pokemon
        }
        else if let number = Int(sender.text!) {
            pokeList.removeAll()
            searchPokemon(withPartialNumber: number)
        }
        else {
            pokeList.removeAll()
            searchPokemon(withPartialName: sender.text!)
        }
        tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Fade)
    }
    
    func searchPokemon(withPartialName name: String) {
        for poke in pokeData.pokemon {
            if poke.name.lowercaseString.containsString(name.lowercaseString) {
                pokeList.append(poke)
            }
        }
    }
    func searchPokemon(withPartialNumber number: Int) {
        for poke in pokeData.pokemon {
            if poke.id == number {
                pokeList.append(poke)
            }
        }
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        print("Begin")
        UIView.animateWithDuration(0.1, animations: {
            textField.backgroundColor = UIColor.whiteColor()
            textField.textColor = UIColor.blackColor()
        })
    }
    func textFieldDidEndEditing(textField: UITextField) {
        print("End")
        UIView.animateWithDuration(0.1, animations: {
            textField.backgroundColor = UIColor.clearColor()
            textField.textColor = self.pokemon.secondaryColor
        })
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.endEditing(true)
        return false
    }
}