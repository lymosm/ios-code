//
//  Order.swift
//  CupcakeCorner
//
//  Created by lymos on 2023/1/21.
//
import SwiftUI

class Order: ObservableObject, Codable{
    static let types = ["Vanilla", "strawberry", "bbbbb", "aaaaa", "cccc"]
    
    @Published var type = 0
    @Published var quantity = 3
    
    @Published var specialRequestEnabled = false{
        didSet{
            if specialRequestEnabled{
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
    @Published var name = ""
    @Published var address = ""
    @Published var city = ""
    @Published var zip = ""
    
    var hasValidAddress: Bool{
        if name.isEmpty || address.isEmpty || city.isEmpty || zip.isEmpty{
            return false
        }
        return true
    }
    
    var cost: Double{
        var _cost = Double(quantity) * 2
        _cost += Double(type) / 2
        if extraFrosting{
            _cost += Double(quantity)
        }
        if addSprinkles{
            _cost += Double(quantity) / 2
        }
        return _cost
    }
    
    enum encodingKeys: CodingKey{
        case type, quantity, extraFrosting, addSprinkles, name, address, city, zip
    }
    
    func encode(to encoder: Encoder) throws{
        var cer = encoder.container(keyedBy: encodingKeys.self)
        try cer.encode(type, forKey: .type)
        try cer.encode(quantity, forKey: .quantity)
        try cer.encode(extraFrosting, forKey: .extraFrosting)
        try cer.encode(addSprinkles, forKey: .addSprinkles)
        try cer.encode(name, forKey: .name)
        try cer.encode(address, forKey: .address)
        try cer.encode(city, forKey: .city)
        try cer.encode(zip, forKey: .zip)
    }
    
    required init(from decoder: Decoder) throws{
        let cer = try decoder.container(keyedBy: encodingKeys.self)
        type = try cer.decode(Int.self, forKey: .type)
        quantity = try cer.decode(Int.self, forKey: .quantity)
        
        extraFrosting = try cer.decode(Bool.self, forKey: .extraFrosting)
        addSprinkles = try cer.decode(Bool.self, forKey: .addSprinkles)
        
        name = try cer.decode(String.self, forKey: .name)
        address = try cer.decode(String.self, forKey: .address)
        city = try cer.decode(String.self, forKey: .city)
        zip = try cer.decode(String.self, forKey: .zip)
        
    }
    init(){}
}
