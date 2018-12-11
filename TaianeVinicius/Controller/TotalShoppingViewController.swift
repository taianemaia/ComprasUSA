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
    
    var products: [Product] = []
    var totalUS: Double = 0
    var totalRS: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadProducts()
        print(products)
        calculateTotals()
    }
    
    func calculateTotals() {
        totalUS = 0
        totalRS = 0
        
        for product in products {
            totalUS += product.price
            totalRS += product.price
        }
        
        lbTotalUS.text = "\(totalUS)"
        lbTotalRS.text = "\(totalRS)"
        
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


