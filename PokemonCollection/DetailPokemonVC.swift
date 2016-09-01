//
//  DetailPokemonVC.swift
//  PokemonCollection
//
//  Created by Khoa on 9/1/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import UIKit

class DetailPokemonVC: UIViewController {
    var pokemon : Pokemon!
    @IBOutlet weak var label : UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = pokemon.name
    }

}
