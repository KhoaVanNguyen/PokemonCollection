//
//  PokeCell.swift
//  PokemonCollection
//
//  Created by Khoa on 8/31/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
 
    @IBOutlet weak var thumbImg : UIImageView!
    @IBOutlet weak var pokeName : UILabel!
    override func awakeFromNib() {
        layer.cornerRadius = 5.0
    }
    func configureCell(poke : Pokemon){
        thumbImg.image = UIImage(named: String(poke.id))
        pokeName.text = poke.name
    }
    
}
