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
    
    var pokeNumber = 1
    var pokemon = Pokemon()
    var pokeData: PokeData? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if pokeData != nil {
            pokemon = (pokeData?.getPokemon(withID: pokeNumber))!
            pokeName.text = pokemon.name.uppercased()
            pokeID.text = "#\(pokemon.id)"
            pokeClassification.text = pokemon.classification
        }
        self.view.clipsToBounds = true
        self.titleBarView.clipsToBounds = true
        self.pokeScrollView.clipsToBounds = true
        self.view.layer.cornerRadius = 5
        self.view.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
        let pokeImage = UIImage(named: "\(pokeNumber)")
        pokeImageView.image = pokeImage
        setType()
        setWeekness()
        setCaptureChance()
        setFleeChance()
        setFastAttacks()
        setEvolution()
    }
    
    func setType() {
        view.layoutIfNeeded()
        pokeTypeView.layoutIfNeeded()
        if pokemon.type.count == 1 {
            let typeImageView1: UIImageView = UIImageView(frame: CGRect(x: pokeTypeView.frame.width/2, y: 0, width: pokeTypeView.frame.height * 1.6, height: pokeTypeView.frame.height))
            typeImageView1.frame.origin.x -=  typeImageView1.frame.width/2
            let typeArray: [Type] = pokemon.type
            typeImageView1.image = selectImage(type: typeArray.first!)
            pokeTypeView.addSubview(typeImageView1)
        }
        else {
            let typeImageView1: UIImageView = UIImageView(frame: CGRect(x: pokeTypeView.frame.width/2, y: 0, width: pokeTypeView.frame.height * 1.6, height: pokeTypeView.frame.height))
            typeImageView1.frame.origin.x -=  typeImageView1.frame.width + 10
            let typeArray: [Type] = pokemon.type
            typeImageView1.image = selectImage(type: typeArray.first!)
            
            let typeImageView2: UIImageView = UIImageView(frame: CGRect(x: pokeTypeView.frame.width/2, y: 0, width: pokeTypeView.frame.height * 1.6, height: pokeTypeView.frame.height))
            typeImageView2.frame.origin.x +=  10
            typeImageView2.image = selectImage(type: typeArray[1])
            pokeTypeView.addSubview(typeImageView1)
            pokeTypeView.addSubview(typeImageView2)
        }
    }
    
    func setWeekness() {
        view.layoutIfNeeded()
        pokeWeeknessView.layoutIfNeeded()
        
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
        var originX = pokeWeeknessView.frame.width/2 - totalWidth/2
        for week in pokemon.weekness {
            let imageView = UIImageView(frame: CGRect(x: originX, y: 0, width: width, height: height))
            imageView.image = selectImage(type: week)
            pokeWeeknessView.addSubview(imageView)
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
        var bars: [UIView] = []
        for i in 0...11 {
            let view = UIView(frame: CGRect(x: originX, y: 0, width: width, height: height))
            view.backgroundColor = UIColor.red()
            view.layer.cornerRadius = 2
            self.pokeCaptureChanceView.addSubview(view)
            originX += width + 5
            bars.append(view)
        }
        var highlight = 0;
        var color = UIColor.red()
    
        if pokemon.baseCaptureRate <= 0.02 {
            highlight = 1
            color = UIColor.red()
        }
        else if pokemon.baseCaptureRate <= 0.04 {
            highlight = 2
            color = UIColor.red()
        }
        else if pokemon.baseCaptureRate <= 0.08 {
            highlight = 3
            color = UIColor.red()
        }
        else if pokemon.baseCaptureRate <= 0.11 {
            highlight = 4
            color = UIColor.red()
        }
        else if pokemon.baseCaptureRate <= 0.12 {
            highlight = 5
            color = UIColor.orange()
        }
        else if pokemon.baseCaptureRate <= 0.16 {
            highlight = 6
            color = UIColor.orange()
        }
        else if pokemon.baseCaptureRate <= 0.21 {
            highlight = 7
            color = UIColor.orange()
        }
        else if pokemon.baseCaptureRate <= 0.24 {
            highlight = 8
            color = UIColor.orange()
        }
        else if pokemon.baseCaptureRate <= 0.32 {
            highlight = 9
            color = UIColor.green()
        }
        else if pokemon.baseCaptureRate <= 0.41 {
            highlight = 10
            color = UIColor.green()
        }
        else if pokemon.baseCaptureRate <= 0.48 {
            highlight = 11
            color = UIColor.green()
        }
        else {
            highlight = 12
            color = UIColor.green()
        }
        
        for (index, view) in bars.enumerated() {
            if index + 1 <= highlight {
                view.backgroundColor = color
            }
            else {
                view.backgroundColor = UIColor.clear()
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
        var bars: [UIView] = []
        for i in 0...5 {
            let view = UIView(frame: CGRect(x: originX, y: 0, width: width, height: height))
            view.backgroundColor = UIColor.red()
            view.layer.cornerRadius = 2
            self.pokeFleeChanceView.addSubview(view)
            originX += width + 5
            bars.append(view)
        }
        var highlight = 0;
        var color = UIColor.red()
    
        if pokemon.baseFleeRate > 0.98 {
            highlight = 6
            color = UIColor.red()
        }
        else if pokemon.baseFleeRate > 0.19 {
            highlight = 5
            color = UIColor.red()
        }
        else if pokemon.baseFleeRate > 0.14 {
            highlight = 4
            color = UIColor.orange()
        }
        else if pokemon.baseFleeRate > 0.091 {
            highlight = 3
            color = UIColor.orange()
        }
        else if pokemon.baseFleeRate > 0.08 {
            highlight = 2
            color = UIColor.green()
        }
        else {
            highlight = 1
            color = UIColor.green()
        }
        
        for (index, view) in bars.enumerated() {
            if index + 1 <= highlight {
                view.backgroundColor = color
            }
            else {
                view.backgroundColor = UIColor.clear()
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
        
        var evol: [Pokemon] = pokemon.previousEvolution
        evol.append(pokemon)
        evol.append(contentsOf: pokemon.nextEvolution)
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
        
        var originX = pokeEvolutionView.frame.width/2 - totalWidth/2
        
        for poke in evol {
            if poke.id == pokemon.id {
                let holderView = UIView(frame: CGRect(x: originX - 10, y: 0, width: width + 20, height: height + 20))
                holderView.backgroundColor = self.titleBarView.backgroundColor
                holderView.layer.cornerRadius = 5
                let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: width, height: height))
                imageView.image = UIImage(named: "\(poke.id)")
                imageView.contentMode = UIViewContentMode.scaleAspectFit
                holderView.addSubview(imageView)
                pokeEvolutionView.addSubview(holderView)
            }
            else {
                let imageView = UIImageView(frame: CGRect(x: originX, y: 10, width: width, height: height))
                imageView.image = UIImage(named: "\(poke.id)")
                imageView.contentMode = UIViewContentMode.scaleAspectFit
                pokeEvolutionView.addSubview(imageView)
            }
            originX += width + 20
        }
    }
    
}
