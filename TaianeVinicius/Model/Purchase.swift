//
//  Purchase.swift
//  TaianeVinicius
//
//  Created by user912249 on 10/15/18.
//  Copyright © 2018 TaianeVinicius. All rights reserved.
//

import Foundation

class Purchase {
    
    var productName: String
    var value: Double
    var image: String
    
    public init(productName: String, value: Double, image: String) {
        self.productName = productName
        self.value = value
        self.image = image
    }
}
