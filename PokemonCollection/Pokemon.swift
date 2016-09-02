//
//  Pokemon.swift
//  PokemonCollection
//
//  Created by Khoa on 8/31/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon{
    
    
    private var _id : Int!
    private var _name : String!
    private var _desciption : String!
    private var _type : String!
    private var _defense : String!
    private var _height : String!
    private var _weight : String!
    private var _baseAttack : String!
    private var _revolution : String!
    private var _pokemonURL : String!
    var revolution : String{
        return _revolution
    }
    var baseAttack : String{
        return _baseAttack
    }
    var weight : String{
        return _weight
    }
    var height : String{
        return _height
    }
    var defense : String{
        if _defense == nil{
            _defense = ""
        }
        return _defense
    }
    var description : String{
        return _desciption
    }
    var type : String{
        return _type
    }
    var id : Int{
        return _id
    }
    var name : String{
        return _name
    }
    init(id : Int, name : String) {
        _id = id
        _name = name
        _pokemonURL = "\(BASE_URL)\(self.id)"
        print("***************************")
        print(_pokemonURL)
    }
    
    func downloadData(complete : DownloadComplete){
      
       Alamofire.request(_pokemonURL, withMethod: .get).responseJSON { (response) in
       // print(response.result.value)
        if let dict = response.result.value as? Dictionary<String,AnyObject>{
            if let attack = dict["attack"] as? Int{
                self._baseAttack = "\(attack)"
            }
            if let height = dict["height"] as? String{
                self._height = height
            }
            if let weight = dict["weight"] as? String{
                self._weight = weight
            }
            if let defense = dict["defense"] as? Int{
                self._defense = "\(defense)"
            }
            if let name = dict["name"] as? String{
                self._name = name
            }
            if let types = dict["types"] as? [Dictionary<String,AnyObject>]{
                if let name = types[0]["name"] as? String{
                    self._type = name
                }
            }
            print("***************************")
            print(self.name)
            print(self.height)
            print(self.weight)
            print(self.defense)
        }
        
        complete()
    }
        
    }
}










