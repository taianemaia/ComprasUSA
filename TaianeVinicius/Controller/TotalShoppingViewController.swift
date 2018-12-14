//
//  TotalShoppingViewController.swift
//  TaianeVinicius
//
//  Created by user912249 on 10/12/18.
//  Copyright © 2018 TaianeVinicius. All rights reserved.
//

import UIKit
import CoreData

class TotalShoppingViewController: UIViewController {

    @IBOutlet weak var lbTotalUS: UILabel!
    @IBOutlet weak var lbTotalRS: UILabel!
    
    let settings = Settings.shared
    var products: [Product] = []
    var totalUS: Double = 0
    var totalRS: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadProducts()
        calculateTotals()
    }
    
    func calculateTotals() {
        totalUS = 0
        totalRS = 0
        var iof: Double
        var tax: Double
        
        for product in products {
            totalUS += product.price
            
            tax = (product.state?.tax)! / 100 + 1
            
            if product.onCard {
                iof = settings.iof / 100 + 1
            } else {
                iof = 1
            }
            totalRS += product.price *  tax * settings.dolarRate * iof
        }
        lbTotalUS.text = String(format: "%.2f", totalUS)
        lbTotalRS.text = String(format: "%.2f", totalRS)
        
    }
    
    func loadProducts() {
        let fetchRequest : NSFetchRequest<Product> = Product.fetchRequest()
        
        do {
            products = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
    }

}


