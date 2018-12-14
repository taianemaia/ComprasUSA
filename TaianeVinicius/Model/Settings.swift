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
            if defaults.double(forKey: "iof") > 0 {
                return defaults.double(forKey: "iof")
            } else {
                return 6.38
            }
        }
        set {
            defaults.set(newValue, forKey: "iof")
        }
    }
    
    var dolarRate: Double {
        get {
            if defaults.double(forKey: "dolarRate") > 0 {
                return defaults.double(forKey: "dolarRate")
            } else {
                return 3.9
            }
        }
        set {
            defaults.set(newValue, forKey: "dolarRate")
        }
    }
}
