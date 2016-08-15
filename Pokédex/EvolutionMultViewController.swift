//
//  EvolutionMultViewController.swift
//  Pokédex
//
//  Created by Ansèlm Joseph on 23/7/16.
//  Copyright © 2016 an23lm. All rights reserved.
//

import UIKit

class EvolutionMultViewController: UIViewController {

    @IBOutlet weak var currentName: UILabel!
    @IBOutlet weak var currentId: UILabel!
    
    @IBOutlet weak var currentCPView: CPView!
    @IBOutlet weak var currentImageView: UIImageView!
    
    @IBOutlet weak var combatPoint: UITextField!
    
    @IBOutlet weak var evolutionName: UILabel!
    @IBOutlet weak var evolutionID: UILabel!
    @IBOutlet weak var evolutionCPView: CPView!
    @IBOutlet weak var evolutionImageView: UIImageView!
    @IBOutlet weak var titleBar: UIView!
    
    @IBOutlet weak var evoutionCP: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var combatPointsLabel: UILabel!
    @IBOutlet weak var trainerLevelLabel: UILabel!
    
    @IBOutlet weak var disclamerView: UIView!
    @IBOutlet weak var disclamerText: UILabel!
    
    @IBOutlet weak var trainerLevelUp: CounterButton!
    @IBOutlet weak var trainerLevelDown: CounterButton!
    @IBOutlet weak var trainerLevel: UILabel!
    
    var pokemon: Pokemon? = nil
    var pokeData: PokeData? = nil
    var evolutionPokemon: Pokemon? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = pokemon!.primaryColor
        self.titleBar.backgroundColor = pokemon!.secondaryColor
        
        titleLabel.textColor = pokemon?.tertiaryColor
        backButton.setTitleColor(pokemon?.tertiaryColor, forState: .Normal)
        currentName.textColor = pokemon?.tertiaryColor
        currentId.textColor = pokemon?.tertiaryColor
        
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        pokemon?.tertiaryColor.getRed(&r, green: &g, blue: &b, alpha: &a)
        let textColor = UIColor(red: r, green: g, blue: b, alpha: a)
        combatPointsLabel.textColor = textColor
        trainerLevelLabel.textColor = textColor
        trainerLevelUp.fillColor = (pokemon?.secondaryColor)!
        trainerLevelDown.fillColor = (pokemon?.secondaryColor)!
        trainerLevelUp.strokeColor = textColor
        trainerLevelDown.strokeColor = textColor
        
        trainerLevel.textColor = pokemon?.tertiaryColor
        
        combatPoint.backgroundColor = pokemon?.secondaryColor
        combatPoint.textColor = pokemon?.tertiaryColor
        
        evolutionName.textColor = pokemon?.tertiaryColor
        evolutionID.textColor = pokemon?.tertiaryColor
        
        evoutionCP.textColor = pokemon?.tertiaryColor
        
        disclamerText.textColor = textColor
        disclamerView.backgroundColor = pokemon?.secondaryColor
        currentCPView.color1 = (pokemon?.tertiaryColor)!
        currentCPView.color2 = (pokemon?.secondaryColor)!
        evolutionCPView.color1 = (pokemon?.tertiaryColor)!
        evolutionCPView.color2 = (pokemon?.secondaryColor)!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setup()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        currentCPView.animateCircles(1.0)
        evolutionCPView.animateCircles(1.0)
        currentCPView.animateCpCapCircle(1.0)
        evolutionCPView.animateCpCapCircle(1.0)
    }
   
    @IBAction func backButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func swipeOut(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func setup() {
        
        trainerLevelUp.isAddButton = true
        
        currentName.text = pokemon!.name
        currentId.text = "#\(pokemon!.id)"
        
        if evolutionPokemon == nil {
            evolutionName.text = pokemon!.nextEvolution.first!.name
            evolutionID.text = "#\(pokemon!.nextEvolution.first!.id)"
            evoutionCP.text = "??? CP"
            evolutionImageView.image = UIImage(named: "\(pokemon!.nextEvolution.first!.id)")
        }
        else {
            evolutionName.text = evolutionPokemon!.name
            evolutionID.text = "#\(evolutionPokemon!.id)"
            evoutionCP.text = "??? CP"
            evolutionImageView.image = UIImage(named: "\(evolutionPokemon!.id)")
        }
        
        currentImageView.image = UIImage(named: "\(pokemon!.id)")
        currentImageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        evolutionImageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        currentCPView.maxCP = pokemon!.maxCP
        let lev = pokeData!.levelInfo[pokeData!.trainerLevel - 1]
        //print("lev: \(lev)")
        var cap = Double((pokemon?.maxCP)!) * lev
        currentCPView.levelCap = (Int(cap))
        currentCPView.maxCP = (pokemon?.maxCP)!
        
        if evolutionPokemon == nil {
            cap = Double((pokemon!.nextEvolution.first!.maxCP)) * lev
            evolutionCPView.levelCap = (Int(cap))
            evolutionCPView.maxCP = (pokemon!.nextEvolution.first!.maxCP)
            //print("1: \(Int(cap))")
            //print("1: \(pokemon!.nextEvolution.first!.maxCP)")
        }
        else {
            cap = Double(evolutionPokemon!.maxCP) * lev
            evolutionCPView.levelCap = Int(cap)
            evolutionCPView.maxCP = (evolutionPokemon!.maxCP)
            //print("1: \(Int(cap))")
            //print("1: \(evolutionPokemon!.maxCP)")
        }
        
        currentCPView.currentCP = 0
        evolutionCPView.currentCP = 0
        
        trainerLevel.text = "\(pokeData!.trainerLevel)"
    }
    
    func update() {
        if combatPoint.text != "" {
            currentCPView.currentCP = Int(combatPoint.text!)!
            let currentCP = Int(combatPoint.text!)
            let multi = (pokemon?.evolutionMultiplier)! * Float(currentCP!)
            evolutionCPView.currentCP = Int(multi)
            evoutionCP.text = "\(Int(multi)) CP"
            currentCPView.animateCurrentCpCircle(1)
            evolutionCPView.animateCurrentCpCircle(1)
        }
        else {
            currentCPView.currentCP = 0
            let currentCP = 0
            let multi = (pokemon?.evolutionMultiplier)! * Float(currentCP)
            evolutionCPView.currentCP = Int(multi)
            evoutionCP.text = "??? CP"
            currentCPView.animateCurrentCpCircle(1)
            evolutionCPView.animateCurrentCpCircle(1)
        }
    }
    
    @IBAction func tapOutside(sender: AnyObject) {
        if combatPoint.isFirstResponder() {
            combatPoint.resignFirstResponder()
        }
    }
    
    @IBAction func trainerLevelUpButton(sender: AnyObject) {
        //print("up")
        if pokeData!.trainerLevel < 40 {
            pokeData!.trainerLevel += 1
        }
        let lev = pokeData!.levelInfo[(pokeData?.trainerLevel)! - 1]
        var cap = Double((pokemon?.maxCP)!) * lev
        currentCPView.levelCap = Int(cap)
        
        cap = Double((pokemon!.nextEvolution.first!.maxCP)) * lev
        evolutionCPView.levelCap = Int(cap)
        currentCPView.animateCpCapCircle(0.3)
        evolutionCPView.animateCpCapCircle(0.3)
        trainerLevel.text = "\((pokeData?.trainerLevel)!)"
    }
    
    @IBAction func trainerLevelDownButton(sender: AnyObject) {
        //print("down")
        if pokeData!.trainerLevel > 1 {
            pokeData!.trainerLevel -= 1
        }
        let lev = pokeData!.levelInfo[(pokeData?.trainerLevel)! - 1]
        var cap = Double((pokemon?.maxCP)!) * lev
        currentCPView.levelCap = Int(cap)
        
        cap = Double((pokemon!.nextEvolution.first!.maxCP)) * lev
        evolutionCPView.levelCap = Int(cap)
        currentCPView.animateCpCapCircle(0.3)
        evolutionCPView.animateCpCapCircle(0.3)
        trainerLevel.text = "\((pokeData?.trainerLevel)!)"
    }
    
}

extension EvolutionMultViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(textField: UITextField) {
        UIView.animateWithDuration(0.1, animations: {
            textField.backgroundColor = UIColor.whiteColor()
            textField.textColor = UIColor.blackColor()
        })
    }
    func textFieldDidEndEditing(textField: UITextField) {
        UIView.animateWithDuration( 0.1, animations: {
            textField.backgroundColor = self.pokemon?.secondaryColor
            textField.textColor = self.pokemon?.tertiaryColor
        })
        update()
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.endEditing(true)
        return false
    }
}
