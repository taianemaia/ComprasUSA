//
//  Settings.swift
//  TaianeVinicius
//
//  Created by user912249 on 10/15/18.
//  Copyright © 2018 TaianeVinicius. All rights reserved.
//

import Foundation

class Settings {
    
    let defaults = UserDefaults.standard
    
    private init() {}
    
    static var shared: Settings = Settings()
    
    var iof: Double {
        get {
            return defaults.double(forKey: "iof")
        }
        set {
            defaults.set(newValue, forKey: "iof")
        }
    }
    
    var dolarRate: Double {
        get {
            return defaults.double(forKey: "dolarRate")
        }
        set {
            defaults.set(newValue, forKey: "dolarRate")
        }
    }
}
