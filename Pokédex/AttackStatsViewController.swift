//
//  AttackStatsViewController.swift
//  Pokédex
//
//  Created by Ansèlm Joseph on 13/08/16.
//  Copyright © 2016 an23lm. All rights reserved.
//

import UIKit

class AttackStatsViewController: UIViewController, SelectedPokemonDelegate {

    @IBOutlet weak var titleBar: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var selectOpponenetLabel: UILabel!
    @IBOutlet weak var selectOpponentButton: UIButton!
    @IBOutlet weak var selectOpponentButtonTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var selectFastAttackLabel: UILabel!
    @IBOutlet weak var fastAttacksContainerView: UIView!
    @IBOutlet weak var fastAttackContainerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var fastAttackContrainerViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var selectSpecialAttackLabel: UILabel!
    @IBOutlet weak var specialAttackContainerView: UIView!
    @IBOutlet weak var specialAttackContainerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var specialAttackContainerViewTopConstraint: NSLayoutConstraint!
    
    var selectedFastAttack: Int! = nil
    var selectedSpecialAttack: Int! = nil
    
    var pokeData: PokeData! = nil
    var pokemon: Pokemon! = nil
    var selectedPokemon: Pokemon! = nil
    
    var fastAttackButtons: [UIView] = []
    var fastAttackLabels: [UILabel] = []
    
    var fastAttackButtonTopConstriant: [NSLayoutConstraint] = []
    var fastAttackButtonCenterXConstriant: [NSLayoutConstraint] = []
    var fastAttackButtonWidthConstraint: [NSLayoutConstraint!] = []
    var fastAttackButtonOriginalWidth: CGFloat = 0
    var fastAttackButtonLeftConstraint: NSLayoutConstraint! = nil
    var fastAttackButtonRigthConstraint: NSLayoutConstraint! = nil
    
    var fastAttackLabelTopConstraint: [NSLayoutConstraint] = []
    var fastAttackLabelLeftConstraint: [NSLayoutConstraint] = []
    var fastAttackLabelBottomConstraint: [NSLayoutConstraint] = []
    var fastAttackLabelRigthConstraint: [NSLayoutConstraint] = []
    var fastAttackLabelCenterXConstriant: [NSLayoutConstraint] = []
    
    var specialAttackButtons: [UIView] = []
    var specialAttackLabels: [UILabel] = []
    
    var specialAttackButtonTopConstraint: [NSLayoutConstraint] = []
    var specialAttackButtonCenterXConstraint: [NSLayoutConstraint] = []
    var specialAttackButtonWidthConstraint: [NSLayoutConstraint!] = []
    var specialAttackButtonOriginalWidth: CGFloat = 0
    var specialAttackButtonLeftConstraint: NSLayoutConstraint! = nil
    var specialAttackButtonRightConstraint: NSLayoutConstraint! = nil
    
    var specialAttackLabelTopConstraint: [NSLayoutConstraint] = []
    var specialAttackLabelLeftConstraint: [NSLayoutConstraint] = []
    var specialAttackLabelBottomConstraint: [NSLayoutConstraint] = []
    var specialAttackLabelRigthConstraint: [NSLayoutConstraint] = []
    var specialAttackLabelCenterXConstriant: [NSLayoutConstraint] = []
    
    @IBOutlet weak var displayDataView: UIView!
    @IBOutlet weak var displayDataViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var fastAttackDPSLabel: UILabel!
    @IBOutlet weak var fastAttackDPSView: UIView!
    @IBOutlet weak var fastAttackDurationLabel: UILabel!
    @IBOutlet weak var fastAttackDurationValueLabel: UILabel!
    @IBOutlet weak var fastEnergyLabel: UILabel!
    @IBOutlet weak var fastEnergyValueLabel: UILabel!
    @IBOutlet weak var fastEffectiveLabel: UILabel!
    @IBOutlet weak var fastAttackStabValue: UILabel!
    @IBOutlet weak var fastAttackStabLabel: UILabel!
    @IBOutlet weak var fastAttackDPS: UILabel!
    
    @IBOutlet weak var specialAttackDPSLabel: UILabel!
    @IBOutlet weak var specialAttackDPSView: UIView!
    @IBOutlet weak var specialAttackDurationLabel: UILabel!
    @IBOutlet weak var specialAttackDurationValue: UILabel!
    @IBOutlet weak var specialAttackEnergyLabel: UILabel!
    @IBOutlet weak var specialAttackEnergyValue: UILabel!
    @IBOutlet weak var specialAttackEffectiveLabel: UILabel!
    @IBOutlet weak var specialAttackStabLabel: UILabel!
    @IBOutlet weak var specialAttackStabValue: UILabel!
    @IBOutlet weak var specialAttackDPS: UILabel!
    
    var lightSecondaryColor = UIColor()
    var lightSecondaryBGColor = UIColor()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleBar.backgroundColor = pokemon.secondaryColor
        view.backgroundColor = pokemon.primaryColor
        
        fastAttacksContainerView.backgroundColor = UIColor.clearColor()
        specialAttackContainerView.backgroundColor = UIColor.clearColor()
        
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        pokemon.tertiaryColor.getRed(&r, green: &g, blue: &b, alpha: &a)
        let lightTextColor = UIColor(red: r, green: g, blue: b, alpha: 0.7)
        
        pokemon.secondaryColor.getRed(&r, green: &g, blue: &b, alpha: &a)
        lightSecondaryColor = UIColor(red: r, green: g, blue: b, alpha: 0.7)
        lightSecondaryBGColor = UIColor(red: r, green: g, blue: b, alpha: 0.3)
        
        titleLabel.textColor = pokemon.tertiaryColor
        backButton.setTitleColor(pokemon.tertiaryColor, forState: .Normal)
        
        selectOpponentButton.backgroundColor = pokemon.secondaryColor
        
        selectFastAttackLabel.textColor = lightSecondaryColor
        selectSpecialAttackLabel.textColor = lightSecondaryColor
        selectOpponenetLabel.textColor = lightSecondaryColor
        selectOpponentButton.setTitleColor(pokemon.tertiaryColor, forState: .Normal)
        
        fastAttacksContainerView.layer.cornerRadius = 5
        specialAttackContainerView.layer.cornerRadius = 5
        selectOpponentButton.layer.cornerRadius = 5
        fastAttackDPSView.layer.cornerRadius = 5
        specialAttackDPSView.layer.cornerRadius = 5
        
        displayDataView.backgroundColor = pokemon.primaryColor
        
        fastAttackDPSLabel.textColor = lightSecondaryColor
        fastAttackDPSView.backgroundColor = pokemon.secondaryColor
        fastAttackDurationLabel.textColor = lightTextColor
        fastAttackDurationValueLabel.textColor = pokemon.tertiaryColor
        fastEnergyLabel.textColor = lightTextColor
        fastEnergyValueLabel.textColor = pokemon.tertiaryColor
        fastEffectiveLabel.textColor = pokemon.tertiaryColor
        fastAttackStabLabel.textColor = lightTextColor
        fastAttackStabValue.textColor = pokemon.tertiaryColor
        fastAttackDPS.textColor = pokemon.secondaryColor
        
        specialAttackDPSLabel.textColor = lightSecondaryColor
        specialAttackDPSView.backgroundColor = pokemon.secondaryColor
        specialAttackDurationLabel.textColor = lightTextColor
        specialAttackDurationValue.textColor = pokemon.tertiaryColor
        specialAttackEnergyLabel.textColor = lightTextColor
        specialAttackEnergyValue.textColor = pokemon.tertiaryColor
        specialAttackEffectiveLabel.textColor = pokemon.tertiaryColor
        specialAttackStabLabel.textColor = lightTextColor
        specialAttackStabValue.textColor = pokemon.tertiaryColor
        specialAttackDPS.textColor = pokemon.secondaryColor
        
        setFastAttacks()
        setSpecialAttacks()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.selectOpponentButton.layoutIfNeeded()
        selectOpponentButton.layer.shadowColor = UIColor.blackColor().CGColor
        selectOpponentButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        selectOpponentButton.layer.shadowRadius = 5
        selectOpponentButton.layer.shadowOpacity = 0.5
        selectOpponentButton.layer.shadowPath = UIBezierPath(roundedRect: selectOpponentButton.bounds, cornerRadius: 5).CGPath
        self.displayDataView.layoutIfNeeded()
        displayDataView.alpha = 0
        displayDataViewTopConstraint.constant = -displayDataView.frame.height
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if selectedFastAttack != nil && selectedSpecialAttack != nil && selectedPokemon != nil {
            setupToDPS()
        }
    }
    
    @IBAction override func unwindForSegue(unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        super.unwindForSegue(unwindSegue, towardsViewController: subsequentVC)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        if segue.identifier == "selectPokemonSegue" {
            let destVc = segue.destinationViewController as! SelectPokemonViewController
            destVc.pokeData = self.pokeData
            destVc.pokemon = self.pokemon
            destVc.delegate = self
        }
    }
    
    func pokemonSelected(pokemon: Pokemon) {
        selectedPokemon = pokemon
        setSelectedPokemon()
    }
    
    func setSelectedPokemon() {
        selectOpponentButton.backgroundColor = selectedPokemon.primaryColor
        selectOpponentButton.setTitleColor(selectedPokemon.secondaryColor, forState: .Normal)
        selectOpponentButton.setTitle(selectedPokemon.name, forState: .Normal)
        if selectedFastAttack != nil && selectedSpecialAttack != nil {
            calculateDPS()
        }
    }
    
    func setupToDPS() {
        let height1 = selectFastAttackLabel.frame.height + 5
        let height2 = selectSpecialAttackLabel.frame.height + 13
        let height3 = selectOpponenetLabel.frame.height + 5
        fastAttackContrainerViewTopConstraint.constant = -height1
        specialAttackContainerViewTopConstraint.constant = -height2
        selectOpponentButtonTopConstraint.constant = -height3
        displayDataViewTopConstraint.constant = 20
        UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseInOut, animations: {
            self.view.layoutIfNeeded()
            }, completion: nil)
        UIView.animateWithDuration(0.2, delay: 0.2, options: .CurveEaseOut, animations: {
            self.displayDataView.alpha = 1
        }, completion: nil)
    }

    func calculateDPS() {
        
        let fAttack = pokeData.getAttack(withName: pokemon.attacks[selectedFastAttack])!
        let cAttack = pokeData.getAttack(withName: pokemon.specialAttacks[selectedSpecialAttack])!
        var fStab: Bool = false
        var cStab: Bool = false
        
        let fTypeAdvantage: TypeAdvantage = pokeData.getTypeAdvantage(forType: fAttack.type)!
        let cTypeAdvantage: TypeAdvantage = pokeData.getTypeAdvantage(forType: cAttack.type)!
        var fastMulti: Float = 1
        var chargeMulti: Float = 1
        
        for type in pokemon.type {
            if fAttack.type == type {
                fStab = true
            }
            if cAttack.type == type {
                cStab = true
            }
        }
        
        for type1 in selectedPokemon.type {
            for type2 in fTypeAdvantage.advantage {
                if type1 == type2 {
                    fastMulti *= 1.25
                }
            }
            for type2 in fTypeAdvantage.disadvantage {
                if type1 == type2 {
                    fastMulti *= 0.8
                }
            }
            for type2 in cTypeAdvantage.advantage {
                if type1 == type2 {
                    chargeMulti *= 1.25
                }
            }
            for type2 in cTypeAdvantage.disadvantage {
                if type1 == type2 {
                    chargeMulti *= 0.8
                }
            }
        }
        
        var fDmgPS = fAttack.dps * fastMulti * fAttack.sec
        if fStab {
            fDmgPS *= 1.25
        }
        
        var cDmgPS = cAttack.dps * chargeMulti * cAttack.sec
        if cStab {
            cDmgPS *= 1.25
        }
        
        var fEffe = ""
        if fastMulti < 0.8 {
            fEffe = "Very ineffective"
        }
        else if fastMulti < 1 {
            fEffe = "Ineffective"
        }
        else if fastMulti == 1 {
            fEffe = "Normal"
        }
        else if fastMulti > 1.5 {
            fEffe = "Super effective"
        }
        else {
            fEffe = "Effective"
        }
        
        var cEffe = ""
        if chargeMulti < 0.8 {
            cEffe = "Very ineffective"
        }
        else if chargeMulti < 1 {
            cEffe = "Ineffective"
        }
        else if chargeMulti == 1 {
            cEffe = "Normal"
        }
        else if chargeMulti > 1.5 {
            cEffe = "Super effective"
        }
        else {
            cEffe = "Effective"
        }

        print("fastMulti \(fastMulti)")
        print("chargeMulti \(chargeMulti)")
        
        dispatch_after(DISPATCH_TIME_NOW, dispatch_get_main_queue(), {
            
            self.fastAttackDurationValueLabel.text = "\(fAttack.sec)"
            self.fastEnergyValueLabel.text = "+\(fAttack.energy)"
            if fStab {
                self.fastAttackStabValue.text = "True"
            }
            else {
                self.fastAttackStabValue.text = "False"
            }
            self.fastEffectiveLabel.text = fEffe
            self.fastAttackDPS.text = "\(fDmgPS)"
            
            
            self.specialAttackDurationValue.text = "\(cAttack.sec)"
            self.specialAttackEnergyValue.text = "\(cAttack.energy)"
            if cStab {
                self.specialAttackStabValue.text = "True"
            }
            else {
                self.specialAttackStabValue.text = "False"
            }
                        self.specialAttackEffectiveLabel.text = cEffe
            self.specialAttackDPS.text = "\(cDmgPS)"
        })
    }
    
    func setFastAttacks() {
        
        //fastAttacksContainerView.backgroundColor = UIColor.whiteColor()
        fastAttackContainerViewHeightConstraint.active = false
        
        fastAttackButtons.removeAll()
        
        for (index, fa) in pokemon.attacks.enumerate() {
            
            let view = UIView()
            view.layer.cornerRadius = 5
            view.backgroundColor = lightSecondaryBGColor
            view.tag = index
            view.layer.shadowColor = UIColor.blackColor().CGColor
            view.layer.shadowOffset = CGSize(width: 0, height: 1)
            view.layer.shadowRadius = 5
            view.layer.shadowOpacity = 0.5
            
            let label = UILabel()
            label.textColor = pokemon.tertiaryColor
            
            fastAttacksContainerView.addSubview(view)
            view.addSubview(label)
            
            view.translatesAutoresizingMaskIntoConstraints = false
            label.translatesAutoresizingMaskIntoConstraints = false
            
            label.text = fa
            label.textColor = pokemon.tertiaryColor
            label.font = UIFont.systemFontOfSize(30)
            let scale = CGAffineTransformMakeScale(0.5, 0.5)
            label.transform = scale
            
            let gest = UITapGestureRecognizer(target: self, action: #selector(self.selectFastAttack))
            view.addGestureRecognizer(gest)
            
            var top = NSLayoutConstraint()
            
            if fastAttackButtons.isEmpty {
                top = NSLayoutConstraint(item: view, attribute: .Top, relatedBy: .Equal, toItem: fastAttacksContainerView, attribute: .Top, multiplier: 1, constant: 8)
            }
            else {
                top = NSLayoutConstraint(item: view, attribute: .Top, relatedBy: .Equal, toItem: fastAttackButtons[index - 1], attribute: .Bottom, multiplier: 1, constant: 8)
            }
            let centerX = NSLayoutConstraint(item: view, attribute: .CenterX, relatedBy: .Equal, toItem: fastAttacksContainerView, attribute: .CenterX, multiplier: 1, constant: 0)
            
            let labLeft = NSLayoutConstraint(item: label, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1, constant: 0)
            let labTop = NSLayoutConstraint(item: label, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1, constant: 0)
            let labRight = NSLayoutConstraint(item: view, attribute: .Trailing, relatedBy: .Equal, toItem: label, attribute: .Trailing, multiplier: 1, constant: 0)
            let labBottom = NSLayoutConstraint(item: view, attribute: .Bottom, relatedBy: .Equal, toItem: label, attribute: .Bottom, multiplier: 1, constant: 0)
            let labCenterX = NSLayoutConstraint(item: label, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0)
            
            fastAttacksContainerView.addConstraints([top, centerX])
            view.addConstraints([labLeft, labTop, labRight, labBottom, labCenterX])
            
            fastAttackButtons.append(view)
            fastAttackLabels.append(label)
            
            fastAttackButtonTopConstriant.append(top)
            fastAttackButtonCenterXConstriant.append(centerX)
            fastAttackButtonWidthConstraint.append(nil)
            
            fastAttackLabelTopConstraint.append(labTop)
            fastAttackLabelLeftConstraint.append(labLeft)
            fastAttackLabelRigthConstraint.append(labRight)
            fastAttackLabelBottomConstraint.append(labBottom)
            fastAttackLabelCenterXConstriant.append(labCenterX)
        }

        let bottom = NSLayoutConstraint(item: fastAttacksContainerView, attribute: .Bottom, relatedBy: .Equal, toItem: fastAttackButtons.last!, attribute: .Bottom, multiplier: 1, constant: 8)
        fastAttacksContainerView.addConstraint(bottom)
        
    }
    
    func setSpecialAttacks() {
        
        //specialAttackContainerView.backgroundColor = UIColor.whiteColor()
        specialAttackContainerViewHeightConstraint.active = false
        
        specialAttackButtons.removeAll()
        
        for (index, fa) in pokemon.specialAttacks.enumerate() {
            let view = UIView()
            view.layer.cornerRadius = 5
            view.backgroundColor = lightSecondaryBGColor
            view.tag = index
            view.layer.shadowColor = UIColor.blackColor().CGColor
            view.layer.shadowOffset = CGSize(width: 0, height: 1)
            view.layer.shadowRadius = 5
            view.layer.shadowOpacity = 0.5
            //view.layer.shadowPath = UIBezierPath(roundedRect: view.frame, cornerRadius: 5).CGPath
            
            let label = UILabel()
            label.textColor = pokemon.tertiaryColor
            
            specialAttackContainerView.addSubview(view)
            view.addSubview(label)
            
            view.translatesAutoresizingMaskIntoConstraints = false
            label.translatesAutoresizingMaskIntoConstraints = false
            
            label.text = fa
            label.textColor = pokemon.tertiaryColor
            label.font = UIFont.systemFontOfSize(30)
            label.textAlignment = NSTextAlignment.Center
            let scale = CGAffineTransformMakeScale(0.5, 0.5)
            label.transform = scale
            
            let gest = UITapGestureRecognizer(target: self, action: #selector(self.selectSpecialAttack))
            view.addGestureRecognizer(gest)
            
            var top = NSLayoutConstraint()
            
            if specialAttackButtons.isEmpty {
                top = NSLayoutConstraint(item: view, attribute: .Top, relatedBy: .Equal, toItem: specialAttackContainerView, attribute: .Top, multiplier: 1, constant: 8)
            }
            else {
                top = NSLayoutConstraint(item: view, attribute: .Top, relatedBy: .Equal, toItem: specialAttackButtons[index - 1], attribute: .Bottom, multiplier: 1, constant: 8)
            }
            let centerX = NSLayoutConstraint(item: view, attribute: .CenterX, relatedBy: .Equal, toItem: specialAttackContainerView, attribute: .CenterX, multiplier: 1, constant: 0)
            
            let labLeft = NSLayoutConstraint(item: label, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1, constant: 8)
            let labTop = NSLayoutConstraint(item: label, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1, constant: 0)
            let labRight = NSLayoutConstraint(item: view, attribute: .Trailing, relatedBy: .Equal, toItem: label, attribute: .Trailing, multiplier: 1, constant: 8)
            let labBottom = NSLayoutConstraint(item: view, attribute: .Bottom, relatedBy: .Equal, toItem: label, attribute: .Bottom, multiplier: 1, constant: 0)
            let labCenterX = NSLayoutConstraint(item: label, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0)
            
            specialAttackContainerView.addConstraints([top, centerX])
            view.addConstraints([labLeft, labTop, labRight, labBottom, labCenterX])
            
            specialAttackButtons.append(view)
            specialAttackLabels.append(label)
            
            specialAttackButtonTopConstraint.append(top)
            specialAttackButtonCenterXConstraint.append(centerX)
            specialAttackButtonWidthConstraint.append(nil)
            
            specialAttackLabelTopConstraint.append(labTop)
            specialAttackLabelLeftConstraint.append(labLeft)
            specialAttackLabelRigthConstraint.append(labRight)
            specialAttackLabelBottomConstraint.append(labBottom)
            specialAttackLabelCenterXConstriant.append(labCenterX)
            
        }
        
        let bottom = NSLayoutConstraint(item: specialAttackContainerView, attribute: .Bottom, relatedBy: .Equal, toItem: specialAttackButtons.last!, attribute: .Bottom, multiplier: 1, constant: 8)
        specialAttackContainerView.addConstraint(bottom)
    }
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func selectFastAttack(sender: UITapGestureRecognizer) {
        
        if selectedFastAttack == nil {
            
            selectedFastAttack = sender.view!.tag
    
            fastAttackButtons[selectedFastAttack].layoutIfNeeded()
            
            let width = fastAttackButtons[selectedFastAttack].frame.width
            let totalWidth = fastAttacksContainerView.frame.width
            let constWidth = (totalWidth - width)/2
            
            let left = NSLayoutConstraint(item: self.fastAttackButtons[self.selectedFastAttack], attribute: .Leading, relatedBy: .Equal, toItem: self.fastAttacksContainerView, attribute: .Leading, multiplier: 1, constant: constWidth)
            let right = NSLayoutConstraint(item: self.fastAttacksContainerView, attribute: .Trailing, relatedBy: .Equal, toItem: self.fastAttackButtons[self.selectedFastAttack], attribute: .Trailing, multiplier: 1, constant: constWidth)
            
            fastAttackButtonRigthConstraint = right
            fastAttackButtonLeftConstraint = left
            
            //let widthConst = NSLayoutConstraint(item: fastAttackButtons[selectedFastAttack], attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: width)
            
            fastAttackButtonOriginalWidth = fastAttackButtons[selectedFastAttack].frame.width
            
            fastAttackButtonCenterXConstriant[selectedFastAttack].active = false
            
            //fastAttackButtons[selectedFastAttack].addConstraint(widthConst)
            fastAttacksContainerView.addConstraints([left, right])
            //fastAttackButtonWidthConstraint[selectedFastAttack] = widthConst
        
            fastAttackLabelLeftConstraint[selectedFastAttack].active = false
            fastAttackLabelRigthConstraint[selectedFastAttack].active = false
            
            self.view.layoutIfNeeded()
            
            fastAttacksContainerView.bringSubviewToFront(fastAttackButtons[selectedFastAttack])
            
            let height = fastAttackButtons[selectedFastAttack].frame.height
            
            for index in 1 ..< fastAttackButtons.count {
                fastAttackButtonTopConstriant[index].constant = -height
            }
 
            fastAttackLabelTopConstraint[selectedFastAttack].constant = 8
            fastAttackLabelBottomConstraint[selectedFastAttack].constant = 8
            //widthConst.constant = self.fastAttacksContainerView.frame.width
            
            left.constant = 0
            right.constant = 0
            
            let scaleLabel = CGAffineTransformMakeScale(1, 1)
            
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                    self.fastAttackLabels[self.selectedFastAttack].transform = scaleLabel
                    self.fastAttackButtons[self.selectedFastAttack].backgroundColor = self.pokemon.secondaryColor
                    self.view.layoutIfNeeded()
                }, completion: {
                    void in
                    if self.selectedSpecialAttack != nil && self.selectedPokemon != nil {
                        self.setupToDPS()
                        self.calculateDPS()
                    }
            })
        }
        else {
            
            fastAttackContrainerViewTopConstraint.constant = 8
            specialAttackContainerViewTopConstraint.constant = 8
            selectOpponentButtonTopConstraint.constant = 8
            
            for index in 1 ..< fastAttackButtons.count {
                fastAttackButtonTopConstriant[index].constant = 8
            }
            let scaleLabel = CGAffineTransformMakeScale(0.5, 0.5)
            //self.fastAttackButtonWidthConstraint[selectedFastAttack].constant = fastAttackButtonOriginalWidth
            let width = (fastAttacksContainerView.frame.width - fastAttackButtonOriginalWidth)/2.0
            fastAttackLabelTopConstraint[selectedFastAttack].constant = 0
            fastAttackLabelBottomConstraint[selectedFastAttack].constant = 0
            fastAttackButtonLeftConstraint.constant = width
            fastAttackButtonRigthConstraint.constant = width
            
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                    self.fastAttackLabels[self.selectedFastAttack].transform = scaleLabel
                    self.fastAttackButtons[self.selectedFastAttack].backgroundColor = self.lightSecondaryBGColor
                    self.fastAttackButtons[self.selectedFastAttack].layer.shadowRadius = 5
                    self.view.layoutIfNeeded()
                }, completion: {
                    void in
                    self.fastAttackButtonOriginalWidth = 0
                    self.fastAttackLabelLeftConstraint[self.selectedFastAttack].active = true
                    self.fastAttackLabelRigthConstraint[self.selectedFastAttack].active = true
                    //self.fastAttackButtons[self.selectedFastAttack].removeConstraint(self.fastAttackButtonWidthConstraint[self.selectedFastAttack])
                    self.fastAttacksContainerView.removeConstraint(self.fastAttackButtonLeftConstraint)
                    self.fastAttacksContainerView.removeConstraint(self.fastAttackButtonRigthConstraint)
                    self.fastAttackButtonCenterXConstriant[self.selectedFastAttack].active = true
                    self.fastAttackButtonRigthConstraint = nil
                    self.fastAttackButtonLeftConstraint = nil
                    //self.fastAttackButtonWidthConstraint[self.selectedFastAttack] = nil
                    self.selectedFastAttack = nil
                    self.view.layoutIfNeeded()
            })
            
            
        }
        
    }
    
    func selectSpecialAttack(sender: UITapGestureRecognizer) {
        
        if selectedSpecialAttack == nil {
            
            selectedSpecialAttack = sender.view!.tag
            
            specialAttackButtons[selectedSpecialAttack].layoutIfNeeded()
            let width = specialAttackButtons[selectedSpecialAttack].frame.width
            let totalWidth = specialAttackContainerView.frame.width
            let constWidth = (totalWidth - width)/2
            
            let left = NSLayoutConstraint(item: self.specialAttackButtons[self.selectedSpecialAttack], attribute: .Leading, relatedBy: .Equal, toItem: self.specialAttackContainerView, attribute: .Leading, multiplier: 1, constant: constWidth)
            let right = NSLayoutConstraint(item: self.specialAttackContainerView, attribute: .Trailing, relatedBy: .Equal, toItem: self.specialAttackButtons[self.selectedSpecialAttack], attribute: .Trailing, multiplier: 1, constant: constWidth)
            
            specialAttackButtonLeftConstraint = left
            specialAttackButtonRightConstraint = right
            
            //let widthConst = NSLayoutConstraint(item: specialAttackButtons[selectedSpecialAttack], attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: width)
            
            specialAttackButtonOriginalWidth = specialAttackButtons[selectedSpecialAttack].frame.width
            
            specialAttackButtonCenterXConstraint[selectedSpecialAttack].active = false
            
            //specialAttackButtons[selectedSpecialAttack].addConstraint(widthConst)
            specialAttackContainerView.addConstraints([left, right])
            //specialAttackButtonWidthConstraint[selectedSpecialAttack] = widthConst
            
            specialAttackLabelLeftConstraint[selectedSpecialAttack].active = false
            specialAttackLabelRigthConstraint[selectedSpecialAttack].active = false
            
            self.view.layoutIfNeeded()
            
            specialAttackContainerView.bringSubviewToFront(specialAttackButtons[selectedSpecialAttack])
            
            let height = specialAttackButtons[selectedSpecialAttack].frame.height
            
            for index in 1 ..< specialAttackButtons.count {
                specialAttackButtonTopConstraint[index].constant = -height
            }
            
            specialAttackLabelTopConstraint[selectedSpecialAttack].constant = 8
            specialAttackLabelBottomConstraint[selectedSpecialAttack].constant = 8
            //widthConst.constant = self.specialAttackContainerView.frame.width
            
            left.constant = 0
            right.constant = 0
            
            let scaleLabel = CGAffineTransformMakeScale(1, 1)
            
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                self.specialAttackLabels[self.selectedSpecialAttack].transform = scaleLabel
                self.specialAttackButtons[self.selectedSpecialAttack].backgroundColor = self.pokemon.secondaryColor
                self.view.layoutIfNeeded()
                }, completion: {
                    void in
                    if self.selectedFastAttack != nil && self.selectedPokemon != nil {
                        self.setupToDPS()
                        self.calculateDPS()
                    }
            })
            
        }
        
        else {
            
            fastAttackContrainerViewTopConstraint.constant = 8
            specialAttackContainerViewTopConstraint.constant = 8
            selectOpponentButtonTopConstraint.constant = 8
            
            for index in 1 ..< specialAttackButtons.count {
                specialAttackButtonTopConstraint[index].constant = 8
            }
            let scaleLabel = CGAffineTransformMakeScale(0.5, 0.5)
            //self.specialAttackButtonWidthConstraint[selectedSpecialAttack].constant = specialAttackButtonOriginalWidth
            let width = (specialAttackContainerView.frame.width - specialAttackButtonOriginalWidth)/2.0
            specialAttackLabelTopConstraint[selectedSpecialAttack].constant = 0
            specialAttackLabelBottomConstraint[selectedSpecialAttack].constant = 0
            specialAttackButtonLeftConstraint.constant = width
            specialAttackButtonRightConstraint.constant = width
            
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                self.specialAttackLabels[self.selectedSpecialAttack].transform = scaleLabel
                self.specialAttackButtons[self.selectedSpecialAttack].backgroundColor = self.lightSecondaryBGColor
                self.view.layoutIfNeeded()
                }, completion: {
                    void in
                    self.specialAttackButtonOriginalWidth = 0
                    self.specialAttackLabelLeftConstraint[self.selectedSpecialAttack].active = true
                    self.specialAttackLabelRigthConstraint[self.selectedSpecialAttack].active = true
                    //self.specialAttackButtons[self.selectedSpecialAttack].removeConstraint(self.specialAttackButtonWidthConstraint[self.selectedSpecialAttack])
                    self.specialAttackContainerView.removeConstraint(self.specialAttackButtonLeftConstraint)
                    self.specialAttackContainerView.removeConstraint(self.specialAttackButtonRightConstraint)
                    self.specialAttackButtonCenterXConstraint[self.selectedSpecialAttack].active = true
                    self.specialAttackButtonRightConstraint = nil
                    self.specialAttackButtonLeftConstraint = nil
                    //self.specialAttackButtonWidthConstraint[self.selectedSpecialAttack] = nil
                    self.selectedSpecialAttack = nil
            })
        }
    }
    
    func printAll() {
        
        for selectedPokemon in pokeData.pokemon {
            
            var maxDmg: Float = 0.0
            var name: String = ""
            var attack: String = ""
            
            for pokemon in pokeData.pokemon {
           
                for fa in pokemon.attacks {
                
                    let att = pokeData.getAttack(withName: fa)!
                    let fTypeAdvantage: TypeAdvantage = pokeData.getTypeAdvantage(forType: att.type)!
                    var fastMulti: Float = 1
                    var fStab = false
            
                    for type in pokemon.type {
                        if att.type == type {
                            fStab = true
                        }
                    }
                    for type1 in selectedPokemon.type {
                        for type2 in fTypeAdvantage.advantage {
                            if type1 == type2 {
                                fastMulti *= 1.25
                            }
                        }
                        for type2 in fTypeAdvantage.disadvantage {
                            if type1 == type2 {
                                fastMulti *= 0.8
                            }
                        }
                    }
                    var dmg = att.dps * fastMulti * att.sec

                    if fStab {
                        dmg *= 1.25
                    }
                    
                    if dmg > maxDmg {
                        maxDmg = dmg
                        name = pokemon.name
                        attack = fa
                    }
                }
                
                for ca in pokemon.specialAttacks {
                    let att = pokeData.getAttack(withName: ca)!
                    print(att)
                
                    let cTypeAdvantage: TypeAdvantage = pokeData.getTypeAdvantage(forType: att.type)!
                    var chargeMulti: Float = 1
                    var cStab = false
                    
                    for type in pokemon.type {
                        if att.type == type {
                            cStab = true
                        }
                    }
                    for type1 in selectedPokemon.type {
                        for type2 in cTypeAdvantage.advantage {
                            if type1 == type2 {
                                chargeMulti *= 1.25
                            }
                        }
                        for type2 in cTypeAdvantage.disadvantage {
                            if type1 == type2 {
                                chargeMulti *= 0.8
                            }
                        }
                    }
                    var dmg = att.dps * chargeMulti * att.sec
                    if cStab {
                        dmg *= 1.25
                    }
        
                    if dmg > maxDmg {
                        maxDmg = dmg
                        name = pokemon.name
                        attack = ca
                    }
                    
                }
            }
            print("def pokemon\(selectedPokemon.name)--------------")
            print("attack pokemon\(name)--------------")
            print("------------\(attack)------------")
            print(maxDmg)
        }
    }
    
}
