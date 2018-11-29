//
//  StateAlert.swift
//  TaianeVinicius
//
//  Created by DTI-DEV on 09/11/2018.
//  Copyright © 2018 TaianeVinicius. All rights reserved.
//

import UIKit

class StateAlert {
    
    static func showAlert(view: UIViewController, with state: State?)  {
        let title = state == nil ? "Adicionar Estado" : "Editar Estado"
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Nome do estado"
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "IOF"
            textField.keyboardType = .decimalPad
        }
        
        alert.addAction(UIAlertAction(title: title, style: .default, handler: { (action) in
            let state = state ?? State(context: view.context)
            state.name = alert.textFields?.first?.text
            
            if let txTax = alert.textFields?.last?.text {
                state.tax = Double(txTax)!
            }
            
            do {
                try view.context.save()
               // return state
            } catch {
                print(error.localizedDescription)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        view.present(alert, animated: true, completion: nil)
    }
}
