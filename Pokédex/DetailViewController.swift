//
//  DetailViewController.swift
//  Pokédex
//
//  Created by Ansèlm Joseph on 21/7/16.
//  Copyright © 2016 an23lm. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var pokeNameTitle: UILabel!
    @IBOutlet weak var pokeImageView: FLAnimatedImageView!
    var pokeNumber = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
    }
    
}
