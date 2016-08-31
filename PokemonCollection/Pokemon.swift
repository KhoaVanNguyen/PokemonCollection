//
//  Pokemon.swift
//  PokemonCollection
//
//  Created by Khoa on 8/31/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import Foundation


class Pokemon{
    private var _id : Int!
    private var _name : String!
    
    var id : Int{
        return _id
    }
    var name : String{
        return _name
    }
    init(id : Int, name : String) {
        _id = id
        _name = name
    }
}
