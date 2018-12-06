//
//  StateManager.swift
//  TaianeVinicius
//
//  Created by DTI-DEV on 09/11/2018.
//  Copyright © 2018 TaianeVinicius. All rights reserved.
//

import CoreData

class StatesManager {
    
    static let shared = StatesManager()
    var states: [State] = []
    
    func loadStates(with context: NSManagedObjectContext) {
        let fetchRequest : NSFetchRequest<State> = State.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            states = try context.fetch(fetchRequest)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteState(index: Int, context: NSManagedObjectContext) {
        context.delete(states[index])
        
        do  {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    /*
    func addState(state: State) {
        let alert = UIAlertController(title: "Adicionar Estado", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Nome do estado"
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Imposto"
        }
        
        alert.addAction((UIAlertAction(title: title, style: .default, handler: { (action) in
           //s let state = state ?? State(context: context)
        })))
    }*/
}
