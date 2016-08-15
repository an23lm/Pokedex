//
//  AttackStatsViewController.swift
//  Pokédex
//
//  Created by Ansèlm Joseph on 13/08/16.
//  Copyright © 2016 an23lm. All rights reserved.
//

import UIKit

class AttackStatsViewController: UIViewController {

    @IBOutlet weak var titleBar: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var selectFastAttackLabel: UILabel!
    @IBOutlet weak var fastAttacksContainerView: UIView!
    @IBOutlet weak var fastAttackContainerViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var selectSpecialAttackLabel: UILabel!
    @IBOutlet weak var specialAttackContainerView: UIView!
    @IBOutlet weak var specialAttackContainerViewHeightConstraint: NSLayoutConstraint!
    
    var selectedFastAttack: Int! = nil
    var selectedSpecialAttack: Int! = nil
    
    var pokeData: PokeData! = nil
    var pokemon: Pokemon! = nil
    
    var fastAttackButtons: [UIView] = []
    var fastAttackLabels: [UILabel] = []
    
    var specialAttackButtons: [UIView] = []
    var specialAttackLabels: [UILabel] = []
    
    var lightSecondaryColor = UIColor()
    
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
        lightSecondaryColor = UIColor(red: r, green: g, blue: b, alpha: 0.3)
        
        titleLabel.textColor = pokemon.tertiaryColor
        backButton.setTitleColor(pokemon.tertiaryColor, forState: .Normal)
        
        selectFastAttackLabel.textColor = lightTextColor
        selectSpecialAttackLabel.textColor = lightTextColor
        
        fastAttacksContainerView.layer.cornerRadius = 5
        specialAttackContainerView.layer.cornerRadius = 5
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setFastAttacks()
        setSpecialAttacks()
    }
    
    func setFastAttacks() {
        
        //fastAttacksContainerView.backgroundColor = UIColor.whiteColor()
        fastAttackContainerViewHeightConstraint.active = false
        
        fastAttackButtons.removeAll()
        
        for (index, fa) in pokemon.attacks.enumerate() {
            
            let view = UIView()
            view.layer.cornerRadius = 5
            view.backgroundColor = lightSecondaryColor
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
            
            let labLeft = NSLayoutConstraint(item: label, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1, constant: 8)
            let labTop = NSLayoutConstraint(item: label, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1, constant: 8)
            let labRight = NSLayoutConstraint(item: view, attribute: .Trailing, relatedBy: .Equal, toItem: label, attribute: .Trailing, multiplier: 1, constant: 8)
            let labBottom = NSLayoutConstraint(item: view, attribute: .Bottom, relatedBy: .Equal, toItem: label, attribute: .Bottom, multiplier: 1, constant: 8)
            fastAttacksContainerView.addConstraints([top, centerX])
            view.addConstraints([labLeft, labTop, labRight, labBottom])
            
            fastAttackButtons.append(view)
            fastAttackLabels.append(label)
        }

        let bottom = NSLayoutConstraint(item: fastAttacksContainerView, attribute: .Bottom, relatedBy: .Equal, toItem: fastAttackButtons.last!, attribute: .Bottom, multiplier: 1, constant: 8)
        fastAttacksContainerView.addConstraint(bottom)
        
    }
    
    func setSpecialAttacks() {
        
        //specialAttackContainerView.backgroundColor = UIColor.whiteColor()
        specialAttackContainerViewHeightConstraint.active = false
        
        print(pokemon.specialAttacks)
        
        specialAttackButtons.removeAll()
        
        for (index, fa) in pokemon.specialAttacks.enumerate() {
            let view = UIView()
            view.layer.cornerRadius = 5
            view.backgroundColor = lightSecondaryColor
            view.tag = index
            view.layer.shadowColor = UIColor.blackColor().CGColor
            view.layer.shadowOffset = CGSize(width: 0, height: 1)
            view.layer.shadowRadius = 5
            view.layer.shadowOpacity = 0.5
            
            let label = UILabel()
            label.textColor = pokemon.tertiaryColor
            
            specialAttackContainerView.addSubview(view)
            view.addSubview(label)
            
            view.translatesAutoresizingMaskIntoConstraints = false
            label.translatesAutoresizingMaskIntoConstraints = false
            
            label.text = fa
            
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
            let labTop = NSLayoutConstraint(item: label, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1, constant: 8)
            let labRight = NSLayoutConstraint(item: view, attribute: .Trailing, relatedBy: .Equal, toItem: label, attribute: .Trailing, multiplier: 1, constant: 8)
            let labBottom = NSLayoutConstraint(item: view, attribute: .Bottom, relatedBy: .Equal, toItem: label, attribute: .Bottom, multiplier: 1, constant: 8)
            
            specialAttackContainerView.addConstraints([top, centerX])
            view.addConstraints([labLeft, labTop, labRight, labBottom])
            
            specialAttackButtons.append(view)
            specialAttackLabels.append(label)
        }
        
        let bottom = NSLayoutConstraint(item: specialAttackContainerView, attribute: .Bottom, relatedBy: .Equal, toItem: specialAttackButtons.last!, attribute: .Bottom, multiplier: 1, constant: 8)
        specialAttackContainerView.addConstraint(bottom)
    }
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func selectFastAttack(sender: UITapGestureRecognizer) {
        
        if selectedFastAttack != nil {
            UIView.animateWithDuration(0.1, animations: {
                self.fastAttackButtons[self.selectedFastAttack].backgroundColor = self.lightSecondaryColor
                self.fastAttackButtons[self.selectedFastAttack].layer.shadowOpacity = 0.5
            })
            if selectedFastAttack == sender.view!.tag {
                selectedFastAttack = nil
                return
            }
            selectedFastAttack = nil
        }
        selectedFastAttack = sender.view!.tag
        UIView.animateWithDuration(0.1, animations: {
            sender.view?.backgroundColor = self.pokemon.secondaryColor
            sender.view?.layer.shadowOpacity = 1
        })
    }
    
    func selectSpecialAttack(sender: UITapGestureRecognizer) {
        if selectedSpecialAttack != nil {
            UIView.animateWithDuration(0.1, animations: {
                self.specialAttackButtons[self.selectedSpecialAttack].backgroundColor = self.lightSecondaryColor
                self.specialAttackButtons[self.selectedSpecialAttack].layer.shadowOpacity = 0.5
            })
            if selectedSpecialAttack == sender.view!.tag {
                selectedSpecialAttack = nil
                return
            }
            selectedSpecialAttack = nil
        }
        selectedSpecialAttack = sender.view!.tag
        UIView.animateWithDuration(0.1, animations: {
            sender.view?.backgroundColor = self.pokemon.secondaryColor
            sender.view?.layer.shadowOpacity = 1
        })
    }
    
}
