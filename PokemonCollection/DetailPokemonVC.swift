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
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokemonIdLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var baseAttackLbl: UILabel!
    @IBOutlet weak var revolutionLbl: UILabel!
    @IBOutlet weak var currentImage: UIImageView!
    @IBOutlet weak var evolutionImage: UIImageView!
    @IBOutlet weak var pokeTitleLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainImage.image = UIImage(named: "\(pokemon.id)")
        currentImage.image = UIImage(named: "\(pokemon.id)")
        pokemon.downloadData {
            self.updateUI()
            print("I'm here")
        }
    }
    func updateUI(){
        pokeTitleLbl.text = pokemon.name
        defenseLbl.text = String(pokemon.defense)
        baseAttackLbl.text = String(pokemon.baseAttack)
        typeLbl.text = pokemon.type.capitalized
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        
    }
    
    @IBAction func backBtnPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
}








