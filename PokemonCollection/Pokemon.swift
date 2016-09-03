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
    private var _pokeDesciption : String!
    private var _type : String!
    private var _defense : String!
    private var _height : String!
    private var _weight : String!
    private var _baseAttack : String!
    private var _revolution : String!
    private var _pokemonURL : String!
    private var _nextEvelutionID : String!
    private var _nextEvelutionString : String!
    
    var nextEvelutionString : String{
        if _nextEvelutionString == nil{
            _nextEvelutionString = ""
        }
        return _nextEvelutionString
    }
    var nextEvelutionID : String{
        if _nextEvelutionID == nil{
            _nextEvelutionID = ""
        }
        return _nextEvelutionID
    }
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
    var pokeDescription : String{
        if _pokeDesciption == nil {
            return ""
        }
        return _pokeDesciption
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
            if let types = dict["types"] as? [Dictionary<String,AnyObject>], types.count > 0  {
                if let name = types[0]["name"] as? String{
                    self._type = name.capitalized
                }
                if types.count > 1{
                    for x in 1..<types.count{
                       if let currentType = types[x]["name"] as? String {
                            self._type! += "/\(currentType.capitalized)"
                        }
                    }
                }
            }
            else {
                self._type = "NOT FOUND"
            }
            if let des = dict["descriptions"] as? [Dictionary<String, AnyObject>] {
                if let resourceUrl = des[0]["resource_uri"] as? String{
                    let url = "\(PokeURL)\(resourceUrl)"
                    Alamofire.request(url, withMethod: .get).responseJSON(completionHandler: { (response) in
                        if let desDict = response.result.value as? Dictionary<String,AnyObject> {
                            if let descriptions = desDict["description"] as? String{
                                self._pokeDesciption = descriptions
                            }
                        }
                        else{
                            self._pokeDesciption = "NOT FOUND"
                        }
                    complete()
                    })
                }
            }
            if let evelution = dict["evolutions"] as? [Dictionary<String, AnyObject>], evelution.count > 0{
                var nextLevel : String = "15"
                var nextMethod : String = ""
                var nextPoke : String = ""
               if let nextEvo = evelution[0]["to"] as? String{
                    // coz there is no mega pokemon type in csv file
                    if nextEvo.range(of: "mega") == nil{
                        nextPoke = nextEvo
                        if let resourceUrl = evelution[0]["resource_uri"] as? String{
                                let index = resourceUrl.index(resourceUrl.endIndex, offsetBy: -2)
                             let nextId = resourceUrl[index]
                             self._nextEvelutionID  =  String(nextId)
                        }
                        if let level = evelution[0]["level"] as? Int{
                            nextLevel = String(level)
                        }
                        else{
                            nextLevel = ""
                        }
                        if let method = evelution[0]["method"] as? String{
                            nextMethod = method.capitalized
                        }
                        self._nextEvelutionString = "Next Evelution: \(nextPoke) -\(nextMethod) - \(nextLevel)"
                        print(self.nextEvelutionID)
                        print(self._nextEvelutionString)
                    }
                }
            }
            
            
    }
        
        complete()
    }
    }
}

