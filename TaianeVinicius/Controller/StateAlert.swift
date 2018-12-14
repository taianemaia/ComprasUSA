//
//  StateAlert.swift
//  TaianeVinicius
//
//  Created by DTI-DEV on 09/11/2018.
//  Copyright © 2018 TaianeVinicius. All rights reserved.
//

import UIKit

class StateAlert {
    
    static func showAlert(view: UIViewController, with state: State?, onCompletion: @escaping (_ state: State) -> Void )  {
        let title = state == nil ? "Adicionar Estado" : "Editar Estado"
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        let addAction = UIAlertAction(title: title, style: .default, handler: { (action) in
            let state = state ?? State(context: view.context)
            state.name = alert.textFields?.first?.text
            
            if let txTax = alert.textFields?.last?.text {
                state.tax = Double(txTax)!
            }
            
            do {
                try view.context.save()
                onCompletion(state)
                
            } catch {
                print(error.localizedDescription)
            }
        })
        
        addAction.isEnabled = false
        alert.addAction(addAction)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        
        alert.addTextField { (textField) in
            textField.placeholder = "Nome do estado"
            
            NotificationCenter.default.addObserver(forName: .UITextFieldTextDidChange, object: textField, queue: OperationQueue.main, using:
                {_ in
                    
                    let enabled = alert.textFields![0].text!.trimmingCharacters(in: .whitespacesAndNewlines).count > 0
                        && alert.textFields![1].text!.trimmingCharacters(in: .whitespacesAndNewlines).count > 0
                    
                    addAction.isEnabled = enabled
                    
            })
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Imposto"
            textField.keyboardType = .decimalPad
            
            NotificationCenter.default.addObserver(forName: .UITextFieldTextDidChange, object: textField, queue: OperationQueue.main, using:
                {_ in
                    let textCount = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0
                    addAction.isEnabled = textCount > 0
                    
            })
        }
        
        view.present(alert, animated: true, completion: nil)
    }
    
    func validateState(state: State, view: UIViewController) {
        var title = " erro"
        
        if state.name == nil {
            title = " erro"
        }
        
        let alert = UIAlertController(title: title, message: "Preencha o nome do estado", preferredStyle: .alert);
        view.present(alert, animated: true, completion: nil)
        
    }
}
