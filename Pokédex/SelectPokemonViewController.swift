//
//  SelectPokemonViewController.swift
//  Pokédex
//
//  Created by Ansèlm Joseph on 19/08/16.
//  Copyright © 2016 an23lm. All rights reserved.
//

import UIKit

protocol SelectedPokemonDelegate {
    func pokemonSelected(id: Int)
}

class SelectPokemonViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedId: Int! = nil
    
    var pokeData: PokeData! = nil
    var pokemon: Pokemon! = nil
    
    var delegate: SelectedPokemonDelegate! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleView.backgroundColor = pokemon.secondaryColor
        titleLabel.textColor = pokemon.tertiaryColor
        backButton.setTitleColor(pokemon.tertiaryColor, forState: .Normal)
        view.backgroundColor = pokemon.primaryColor
        tableView.backgroundColor = pokemon.primaryColor
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
        return pokeData.pokemon.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PokeCell") as! PokeTableViewCell
        
        let poke = pokeData.pokemon[indexPath.row]
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
        delegate.pokemonSelected(indexPath.row + 1)
        performSegueWithIdentifier("unwindSegue", sender: nil)
    }
}
