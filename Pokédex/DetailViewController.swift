//
//  DetailViewController.swift
//  Pokédex
//
//  Created by Ansèlm Joseph on 21/7/16.
//  Copyright © 2016 an23lm. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleBarView: UIView!
    
    @IBOutlet weak var pokeScrollView: UIScrollView!
    @IBOutlet weak var pokeContentView: UIView!
    
    @IBOutlet weak var pokeName: UILabel!
    @IBOutlet weak var pokeID: UILabel!
    @IBOutlet weak var pokeClassification: UILabel!
    @IBOutlet weak var pokeTypeView: UIView!
    @IBOutlet weak var pokeImageView: FLAnimatedImageView!
    @IBOutlet weak var pokeWeeknessView: UIView!
    @IBOutlet weak var pokeFastAttackLabel1View: UIView!
    @IBOutlet weak var pokeFastAttacksView: UIView!
    @IBOutlet weak var pokeFastAttackLable1: UILabel!
    @IBOutlet weak var pokeFastAttackLabel2View: UIView!
    @IBOutlet weak var pokeFastAttackLabel2: UILabel!
    @IBOutlet weak var pokeCaptureChanceView: UIView!
    @IBOutlet weak var pokeFleeChanceView: UIView!
    @IBOutlet weak var pokeButtonsView: UIView!
    @IBOutlet weak var pokePowerUpButton: UIButton!
    @IBOutlet weak var pokeEvolMultiButton: UIButton!
    
    @IBOutlet weak var pokeEvolutionView: UIView!

    @IBOutlet weak var typeView: UIView!
    @IBOutlet weak var typeViewConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var weeknessView: UIView!
    @IBOutlet weak var weeknessViewConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var evolutionView: UIView!
    @IBOutlet weak var evolutionViewConstraint: NSLayoutConstraint!
    
    var pokeNumber = 1
    var pokemon = Pokemon()
    var pokeData: PokeData? = nil
    var selectedEvol: [Int] = []
    var evolutionPokemon: Pokemon? = nil
    
    var capBars: [UIView] = []
    var fleeBars: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if pokeData != nil {
            pokemon = (pokeData?.getPokemon(withID: pokeNumber))!
        }
        self.view.clipsToBounds = true
        self.titleBarView.clipsToBounds = true
        self.pokeScrollView.clipsToBounds = true
        self.view.layer.cornerRadius = 5
        self.view.layer.masksToBounds = true
        
        if pokemon.nextEvolution.isEmpty {
            pokeEvolMultiButton.hidden = true
        }
        
    }

    @IBAction func backButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        /*
        print("Number: \(pokeNumber)")
        let pokeNumberGIFName = "\(pokeNumber)gif"
        let path = Bundle.main().pathForResource(pokeNumberGIFName, ofType: "gif")
        do {
            let url = URL(fileURLWithPath: path!)
            let det = try Data(contentsOf: url)
            let img = FLAnimatedImage(animatedGIFData: det)
            pokeImageView.animatedImage = img
        }
        catch{
            print(error)
        }
         */
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.rotate), name: UIDeviceOrientationDidChangeNotification, object: nil)
        
        pokeCaptureChanceView.alpha = 0
        pokeFleeChanceView.alpha = 0
        
        pokeName.text = pokemon.name.uppercaseString
        pokeID.text = "#\(pokemon.id)"
        pokeClassification.text = pokemon.classification
        let pokeImage = UIImage(named: "\(pokeNumber)")
        pokeImageView.image = pokeImage
        setType()
        setWeekness()
        setFastAttacks()
        setEvolution()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        setCaptureChance()
        setFleeChance()
        UIView.animateWithDuration(0.2, animations: {
            self.pokeCaptureChanceView.alpha = 1
            self.pokeFleeChanceView.alpha = 1
        })
    }
    
    func rotate() {
        setCaptureChance()
        setFleeChance()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        if segue.identifier == "showPowerUpSegue" {
            let destvc = segue.destinationViewController as? PowerUpViewController
            destvc?.pokeData = pokeData
            destvc?.pokemon = pokemon
        }
        if segue.identifier == "showEvolMultiSegue" {
            let destvc = segue.destinationViewController as? EvolutionMultViewController
            destvc?.pokemon = pokemon
            destvc?.pokeData = pokeData
            if evolutionPokemon != nil {
                destvc?.evolutionPokemon = evolutionPokemon
            }
        }
    }
    
    func setType() {
        
        view.layoutIfNeeded()
        pokeTypeView.layoutIfNeeded()
        typeView.layoutIfNeeded()
        
        if pokemon.type.count == 1 {
            let width = pokeTypeView.frame.height * 1.6
            typeViewConstraint.constant = width
            print(width)
            
            let typeImageView1: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: pokeTypeView.frame.height * 1.6, height: pokeTypeView.frame.height))
            let typeArray: [Type] = pokemon.type
            typeImageView1.image = selectImage(typeArray.first!)
            
            typeView.addSubview(typeImageView1)
        }
        else {
            let width = pokeTypeView.frame.height * 1.6 * 2 + 10
            typeViewConstraint.constant = width
            
            let typeImageView1: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: pokeTypeView.frame.height * 1.6, height: pokeTypeView.frame.height))
   
            let typeArray: [Type] = pokemon.type
            typeImageView1.image = selectImage(typeArray.first!)
            
            let typeImageView2: UIImageView = UIImageView(frame: CGRect(x: (pokeTypeView.frame.height * 1.6) + 10, y: 0, width: pokeTypeView.frame.height * 1.6, height: pokeTypeView.frame.height))

            typeImageView2.image = selectImage(typeArray[1])
            
            typeView.addSubview(typeImageView1)
            typeView.addSubview(typeImageView2)
        }
    }
    
    func setWeekness() {
        view.layoutIfNeeded()
        pokeWeeknessView.layoutIfNeeded()
        weeknessView.layoutIfNeeded()
        
        let count = pokemon.weekness.count
        var height = pokeWeeknessView.frame.height
        var width = height * 1.6
        var totalWidth = (width * CGFloat(count)) + CGFloat((count - 1) * 10)
        
        if totalWidth > pokeWeeknessView.frame.width {
            let overBy = totalWidth - pokeWeeknessView.frame.width
            let changeInWidth = (overBy + 10.0) / CGFloat(count)
            width = width - CGFloat(changeInWidth)
            height = width / 1.6
            totalWidth = (width * CGFloat(count)) + CGFloat((count - 1) * 10)
        }
        
        weeknessViewConstraint.constant = totalWidth
        
        var originX: CGFloat = 0
        
        for week in pokemon.weekness {
            let imageView = UIImageView(frame: CGRect(x: originX, y: 0, width: width, height: height))
            imageView.image = selectImage(week)
            weeknessView.addSubview(imageView)
            originX += width + 10
        }
    }
    
    func setCaptureChance() {
        view.layoutIfNeeded()
        pokeCaptureChanceView.layoutIfNeeded()
        
        var width = pokeCaptureChanceView.frame.width
        let height = pokeCaptureChanceView.frame.height
        width = (width/12) - (5)
        var originX: CGFloat = 0
        
        func reset() {
            for bar in capBars {
                bar.removeFromSuperview()
            }
            capBars.removeAll()
        }
        
        reset()
        
        for _ in 0...11 {
            let view = UIView(frame: CGRect(x: originX, y: 0, width: width, height: height))
            view.backgroundColor = UIColor.redColor()
            view.layer.cornerRadius = 2
            self.pokeCaptureChanceView.addSubview(view)
            originX += width + 5
            capBars.append(view)
        }
        var highlight = 0;
        var color = UIColor.redColor()
    
        if pokemon.baseCaptureRate <= 0.02 {
            highlight = 1
            color = UIColor.redColor()
        }
        else if pokemon.baseCaptureRate <= 0.04 {
            highlight = 2
            color = UIColor.redColor()
        }
        else if pokemon.baseCaptureRate <= 0.08 {
            highlight = 3
            color = UIColor.redColor()
        }
        else if pokemon.baseCaptureRate <= 0.11 {
            highlight = 4
            color = UIColor.redColor()
        }
        else if pokemon.baseCaptureRate <= 0.12 {
            highlight = 5
            color = UIColor.orangeColor()
        }
        else if pokemon.baseCaptureRate <= 0.16 {
            highlight = 6
            color = UIColor.orangeColor()
        }
        else if pokemon.baseCaptureRate <= 0.21 {
            highlight = 7
            color = UIColor.orangeColor()
        }
        else if pokemon.baseCaptureRate <= 0.24 {
            highlight = 8
            color = UIColor.orangeColor()
        }
        else if pokemon.baseCaptureRate <= 0.32 {
            highlight = 9
            color = UIColor.greenColor()
        }
        else if pokemon.baseCaptureRate <= 0.41 {
            highlight = 10
            color = UIColor.greenColor()
        }
        else if pokemon.baseCaptureRate <= 0.48 {
            highlight = 11
            color = UIColor.greenColor()
        }
        else {
            highlight = 12
            color = UIColor.greenColor()
        }
        
        for (index, view) in capBars.enumerate() {
            if index + 1 <= highlight {
                view.backgroundColor = color
            }
            else {
                view.backgroundColor = UIColor.clearColor()
            }
        }
    }
    
    func setFleeChance() {
        view.layoutIfNeeded()
        pokeFleeChanceView.layoutIfNeeded()
        
        var width = pokeFleeChanceView.frame.width
        let height = pokeFleeChanceView.frame.height
        width = (width/6) - (5)
        var originX: CGFloat = 0
        
        func reset() {
            for bar in fleeBars {
                bar.removeFromSuperview()
            }
            fleeBars.removeAll()
        }
        
        reset()
        
        for _ in 0...5 {
            let view = UIView(frame: CGRect(x: originX, y: 0, width: width, height: height))
            view.backgroundColor = UIColor.redColor()
            view.layer.cornerRadius = 2
            self.pokeFleeChanceView.addSubview(view)
            originX += width + 5
            fleeBars.append(view)
        }
        var highlight = 0;
        var color = UIColor.redColor()
    
        if pokemon.baseFleeRate > 0.98 {
            highlight = 6
            color = UIColor.redColor()
        }
        else if pokemon.baseFleeRate > 0.19 {
            highlight = 5
            color = UIColor.redColor()
        }
        else if pokemon.baseFleeRate > 0.14 {
            highlight = 4
            color = UIColor.orangeColor()
        }
        else if pokemon.baseFleeRate > 0.091 {
            highlight = 3
            color = UIColor.orangeColor()
        }
        else if pokemon.baseFleeRate > 0.08 {
            highlight = 2
            color = UIColor.greenColor()
        }
        else {
            highlight = 1
            color = UIColor.greenColor()
        }
        
        for (index, view) in fleeBars.enumerate() {
            if index + 1 <= highlight {
                view.backgroundColor = color
            }
            else {
                view.backgroundColor = UIColor.clearColor()
            }
        }
    }
    
    func setFastAttacks() {
        let fastAttacks = pokemon.attacks
        pokeFastAttackLable1.text = fastAttacks.first!
        if fastAttacks.count == 2 {
            if fastAttacks[1] == "" {
                pokeFastAttackLabel2View.layer.opacity = 0
            }
            pokeFastAttackLabel2.text = fastAttacks[1]
        }
        else {
            pokeFastAttackLabel2View.layer.opacity = 0
        }
        pokeFastAttacksView.layoutSubviews()
    }
    
    func setEvolution() {
        view.layoutIfNeeded()
        pokeEvolutionView.layoutIfNeeded()
        evolutionView.layoutIfNeeded()
        
        var evol: [Pokemon] = pokemon.previousEvolution
        evol.append(pokemon)
        evol.appendContentsOf(pokemon.nextEvolution)
        let count = evol.count
        var height = pokeEvolutionView.frame.height - 20
        var width = height
        var totalWidth = (width * CGFloat(count)) + CGFloat(20 * (count - 1))
        
        if totalWidth > pokeEvolutionView.frame.width {
            let overBy = totalWidth - pokeEvolutionView.frame.width
            let changeInWidth = (overBy + 10.0) / CGFloat(count)
            width = width - CGFloat(changeInWidth)
            height = width
            totalWidth = (width * CGFloat(count)) + CGFloat((count - 1) * 20)
        }
        
        evolutionViewConstraint.constant = totalWidth
        
        var originX: CGFloat = 0
        
        for poke in evol {
            if poke.id == pokemon.id {
                let holderView = UIView(frame: CGRect(x: originX - 10, y: 0, width: width + 20, height: height + 20))
                holderView.backgroundColor = self.titleBarView.backgroundColor
                holderView.layer.cornerRadius = 5
                let button = UIButton(frame: CGRect(x: 10, y: 10, width: width, height: height))
                button.setImage(UIImage(named: "\(poke.id)"), forState: [])
                button.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
                holderView.addSubview(button)
                evolutionView.addSubview(holderView)
                if !selectedEvol.contains(poke.id) {
                    selectedEvol.append(poke.id)
                }
            }
            else {
                let button = UIButton(frame: CGRect(x: originX, y: 10, width: width, height: height))
                button.setImage(UIImage(named: "\(poke.id)"), forState: [])
                button.tag = poke.id
                button.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
                evolutionView.addSubview(button)
                button.addTarget(self, action: #selector(self.selectEvolution), forControlEvents: .TouchUpInside)
                if selectedEvol.contains(poke.id) {
                    button.enabled = false
                }
            }
            originX += width + 20
        }
    }
    
    func selectEvolution (sender: UIButton) {
        let sb = self.storyboard
        let vc = sb?.instantiateViewControllerWithIdentifier("DVC") as? DetailViewController
        vc!.pokeNumber = sender.tag
        vc!.pokeData = pokeData
        vc!.selectedEvol = selectedEvol
        self.presentViewController(vc!, animated: true, completion: nil)
    }
    @IBAction func edgeSwipeDismiss(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func evolButtonPress(sender: AnyObject) {
        if pokeNumber == 133 {
            let optionMenu = UIAlertController(title: "Choose Evolution", message: nil, preferredStyle: .ActionSheet)
            
            let vap = UIAlertAction(title: "Vaporeon", style: .Default, handler: {
                (alert: UIAlertAction!) -> Void in
                self.evolutionPokemon = self.pokemon.nextEvolution[0]
                self.performSegueWithIdentifier("showEvolMultiSegue", sender: nil)
                print("Vap")
            })
            let jolt = UIAlertAction(title: "Jolteon", style: .Default, handler: {
                (alert: UIAlertAction!) -> Void in
                self.evolutionPokemon = self.pokemon.nextEvolution[1]
                self.performSegueWithIdentifier("showEvolMultiSegue", sender: nil)
                print("Jolt")
            })
            let fla = UIAlertAction(title: "Flareon", style: .Default, handler: {
                (alert: UIAlertAction!) -> Void in
                self.evolutionPokemon = self.pokemon.nextEvolution[2]
                self.performSegueWithIdentifier("showEvolMultiSegue", sender: nil)
                print("Flare")
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
                (alert: UIAlertAction!) -> Void in
                print("Cancelled")
            })
            
            optionMenu.addAction(vap)
            optionMenu.addAction(jolt)
            optionMenu.addAction(fla)
            optionMenu.addAction(cancelAction)
            optionMenu.modalInPopover = true
            
            let popup = optionMenu.popoverPresentationController
            popup?.sourceRect = pokeEvolMultiButton.bounds
            popup?.sourceView = pokeEvolMultiButton
            self.presentViewController(optionMenu, animated: true, completion: nil)
        }
        else {
            self.performSegueWithIdentifier("showEvolMultiSegue", sender: nil)
        }
    }
    
    
}
