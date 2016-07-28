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
    
    @IBOutlet weak var maxCP: UILabel!
    @IBOutlet weak var levelCap: UILabel!
    @IBOutlet weak var cpLvl: UILabel!
    
    var currentCP: Int = 0 {
        didSet {
            cpView.currentCP = currentCP
            cpView.setNeedsDisplay()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        plusTrainerButton.isAddButton = true
        pokeImageView.image = UIImage(named: "\((pokemon?.id)!)")
        pokeImageView.contentMode = UIViewContentMode.ScaleAspectFit
        trainerLevel.text = "\((pokeData?.trainerLevel)!)"
        maxCP.text = "\((pokemon?.maxCP)!)"
        let lev = pokeData?.levelInfo[(pokeData?.trainerLevel)! - 1]
        let cap = Double((pokemon?.maxCP)!) * lev!
        levelCap.text = "\(Int(cap))"
        cpLvl.text = "\((pokemon?.powerCP)!)"
        cpView.currentCP = currentCP
        cpView.levelCap = Int(cap)
        cpView.maxCP = Int((pokemon?.maxCP)!)
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
        cpView.setNeedsDisplay()
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
        cpView.setNeedsDisplay()
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
            textField.backgroundColor = self.pokeTitleView.backgroundColor
            textField.textColor = UIColor.whiteColor()
        })
        if textField.isFirstResponder() {
            textField.resignFirstResponder()
        }
        currentCP = Int(textField.text!)!
    }
}
