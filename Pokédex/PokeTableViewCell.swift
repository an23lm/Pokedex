//
//  PokeTableViewCell.swift
//  Pokédex
//
//  Created by Ansèlm Joseph on 19/08/16.
//  Copyright © 2016 an23lm. All rights reserved.
//

import UIKit

class PokeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var pokeImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
