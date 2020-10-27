//
//  Product.swift
//  Product
//
//  Created by Yeni Kullanıcı on 17.10.2020.
//  Copyright © 2020 Busra Nur OK. All rights reserved.
//

import UIKit

class GetProductsResponseMesssage : Codable {
    
    let productList : [Product]
    let errorMessage : String
    let result : String
    
    init(productList : [Product], errorMessage : String, result : String) {
        
        self.productList = productList
        self.errorMessage = errorMessage
        self.result = result
        
    }
    
}


class PostProductResponseMessage : Codable {
    
    let result : String
    let errorMessage : String
    
    init(errorMessage : String, result : String) {
        
        self.errorMessage = errorMessage
        self.result = result
        
    }
    
}

class PostProductRequestMessage : Codable {
    
    let name : String
    let amount : Int
    let price : Float
    
    init(name: String, amount: Int, price: Float) {
        self.name = name
        self.amount = amount
        self.price = price
    }
    
}

class Product: Codable {
    
    let ProductId : Int
    let Name: String
    let CreatedDate : String
    let Price : Float
    
    init(ProductId : Int, Name: String, CreatedDate : String , Price: Float) {
        self.ProductId = ProductId
        self.Name = Name
        self.CreatedDate = CreatedDate
        self.Price = Price
    }
    
}
