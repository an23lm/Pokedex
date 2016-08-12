//
//  PowerUpViewController.swift
//  Pokédex
//
//  Created by Ansèlm Joseph on 23/7/16.
//  Copyright © 2016 an23lm. All rights reserved.
//

import UIKit

class PowerUpViewController: UIViewController {

    var pokeData: PokeData? = nil
    var pokemon: Pokemon? = nil
    
    @IBOutlet weak var cpView: CPView!
    @IBOutlet weak var pokeTitleView: UIView!
    @IBOutlet weak var pokeImageView: UIImageView!
    @IBOutlet weak var trainerLevel: UILabel!
    @IBOutlet weak var plusTrainerButton: CounterButton!
    @IBOutlet weak var minusTrainerButton: CounterButton!
    @IBOutlet weak var cpTextField: UITextField!
    @IBOutlet weak var trainerLevelLabel: UILabel!
    @IBOutlet weak var combatPointsLabel: UILabel!
    @IBOutlet weak var pokeTitleLabel: UILabel!
    @IBOutlet weak var pokeBackButton: UIButton!
   
    @IBOutlet weak var maxCPLabel: UILabel!
    @IBOutlet weak var levelCapLabel: UILabel!
    @IBOutlet weak var cpPerLevelUpLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var maxCP: UILabel!
    @IBOutlet weak var levelCap: UILabel!
    @IBOutlet weak var cpLvl: UILabel!
    
    @IBOutlet weak var disclaimerText: UILabel!
    
    var currentCP: Int = 0 {
        didSet {
            cpView.currentCP = currentCP
            cpView.animateCurrentCpCircle(1.0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        plusTrainerButton.isAddButton = true
        minusTrainerButton.isAddButton = false
        
        pokeTitleView.backgroundColor = pokemon?.secondaryColor
        self.view.backgroundColor = pokemon?.primaryColor
        trainerLevelLabel.textColor = pokemon?.tertiaryColor
        combatPointsLabel.textColor = pokemon?.tertiaryColor
        plusTrainerButton.fillColor = (pokemon?.secondaryColor)!
        minusTrainerButton.fillColor = (pokemon?.secondaryColor)!
        pokeTitleLabel.textColor = pokemon?.tertiaryColor
        pokeBackButton.setTitleColor(pokemon?.tertiaryColor, forState: .Normal)
        
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        pokemon?.tertiaryColor.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let lightTextColor = UIColor(red: r, green: g, blue: b, alpha: 0.7)
        maxCPLabel.textColor = lightTextColor
        levelCapLabel.textColor = lightTextColor
        cpPerLevelUpLabel.textColor = lightTextColor
        
        plusTrainerButton.strokeColor = lightTextColor
        minusTrainerButton.strokeColor = lightTextColor
        
        maxCP.textColor = pokemon?.tertiaryColor
        levelCap.textColor = pokemon?.tertiaryColor
        cpLvl.textColor = pokemon?.tertiaryColor
        
        cpTextField.backgroundColor = pokemon?.secondaryColor
        cpTextField.textColor = pokemon?.tertiaryColor
        
        contentView.backgroundColor = pokemon?.secondaryColor
        
        cpView.color1 = (pokemon?.tertiaryColor)!
        cpView.color2 = (pokemon?.secondaryColor)!
        
        disclaimerText.textColor = lightTextColor
        
        pokeImageView.image = UIImage(named: "\((pokemon?.id)!)")
        pokeImageView.contentMode = UIViewContentMode.ScaleAspectFit
        trainerLevel.text = "\((pokeData?.trainerLevel)!)"
        maxCP.text = "\((pokemon?.maxCP)!)"
        
        let lev = pokeData?.levelInfo[(pokeData?.trainerLevel)! - 1]
        let cap = Double((pokemon?.maxCP)!) * lev!
        levelCap.text = "\(Int(cap))"
        cpLvl.text = "\((pokemon?.powerCP)!)"
        
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        cpView.setNeedsDisplay()
        cpView.animateCircles(1.0)
        let lev = pokeData?.levelInfo[(pokeData?.trainerLevel)! - 1]
        let cap = Double((pokemon?.maxCP)!) * lev!
        cpView.currentCP = currentCP
        cpView.levelCap = Int(cap)
        cpView.maxCP = Int((pokemon?.maxCP)!)
        cpView.animateCpCapCircle(1.0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapOutside(sender: AnyObject) {
        print("resign")
        if cpTextField.isFirstResponder() {
            cpTextField.resignFirstResponder()
            print("resign")
        }
    }
    
    @IBAction func swipeOut(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func backButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func trainerLevelUp(sender: AnyObject) {
        if pokeData?.trainerLevel >= 40 {
            return
        }
        pokeData?.trainerLevel += 1
        let lev = pokeData?.levelInfo[(pokeData?.trainerLevel)! - 1]
        let cap = Double((pokemon?.maxCP)!) * lev!
        levelCap.text = "\(Int(cap))"
        cpView.levelCap = Int(cap)
        cpView.animateCpCapCircle(0.3)
        trainerLevel.text = "\((pokeData?.trainerLevel)!)"
    }
   
    @IBAction func trainerLevelDown(sender: AnyObject) {
        if pokeData?.trainerLevel <= 1 {
            return
        }
        pokeData?.trainerLevel -= 1
        let lev = pokeData?.levelInfo[(pokeData?.trainerLevel)! - 1]
        let cap = Double((pokemon?.maxCP)!) * lev!
        levelCap.text = "\(Int(cap))"
        cpView.levelCap = Int(cap)
        cpView.animateCpCapCircle(0.3)
        trainerLevel.text = "\((pokeData?.trainerLevel)!)"
    }
}

extension PowerUpViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(textField: UITextField) {
        UIView.animateWithDuration(0.1, animations: {
            textField.backgroundColor = UIColor.whiteColor()
            textField.textColor = UIColor.blackColor()
        })
    }
    func textFieldDidEndEditing(textField: UITextField) {
        UIView.animateWithDuration(0.1, animations: {
            textField.backgroundColor = self.pokemon?.secondaryColor
            textField.textColor = self.pokemon?.tertiaryColor
        })
        if textField.isFirstResponder() {
            textField.resignFirstResponder()
        }
        if textField.text != "" {
            currentCP = Int(textField.text!)!
        }
        else {
            currentCP = 0
        }
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.endEditing(true)
        return false
    }
}
