//
//  ViewController.swift
//  PokemonCollection
//
//  Created by Khoa on 8/31/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate{

    @IBOutlet weak var searchBar: UISearchBar!
    var pokemons = [Pokemon]()
    var filterPokemons = [Pokemon]()
    var musicPlayer : AVAudioPlayer!
    var isInSearchMode = false
    @IBOutlet weak var collectionView : UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        searchBar.delegate = self
        searchBar.returnKeyType = .done
        // Do any additional setup after loading the view, typically from a nib.
        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        parseCSV()
        initAudio()
    }
    func initAudio(){
      
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
            }catch{
            print("error")
        }
    }
    func parseCSV(){
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            for row in rows {
                let id = Int(row["id"]!)!
                let name = row["identifier"]
                let poke = Pokemon(id: id, name: name!)
                pokemons.append(poke)
            }
        }catch{
            print("Error")
        }
            }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !isInSearchMode{
            return pokemons.count
        }else{
            return filterPokemons.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell{
            let poke : Pokemon
            if !isInSearchMode{
                poke = pokemons[indexPath.row]
                cell.configureCell(poke: poke)
            }else{
                poke = filterPokemons[indexPath.row]
                cell.configureCell(poke: poke)
            }
            return cell
        }
        else{
            return UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let poke : Pokemon
        if isInSearchMode{
            poke = filterPokemons[indexPath.row]
        }else{
            poke = pokemons[indexPath.row]
        }
        performSegue(withIdentifier: "DetailPokemonVC", sender: poke)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width =  collectionView.frame.width / 3.3
        return CGSize(width: width, height: 105)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == ""{
            isInSearchMode = false
            collectionView.reloadData()
            view.endEditing(true)
        }else{
            isInSearchMode = true
            let lowerText = searchBar.text?.lowercased()
            filterPokemons = pokemons.filter({
            poke in
                return poke.name.range(of: lowerText!) != nil
            })
            collectionView.reloadData()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailPokemonVC"{
            if let detailVC = segue.destination as? DetailPokemonVC {
                if let poke = sender as? Pokemon{
                    detailVC.pokemon = poke
                }
            }
        }
    }
    @IBAction func musicBtnPressed(_ sender: AnyObject) {
        if musicPlayer.isPlaying{
            musicPlayer.pause()
            //sender.alpha = 0.2
        }else{
            musicPlayer.play()
            //sender.alpha = 1.0
        }
    }
}

