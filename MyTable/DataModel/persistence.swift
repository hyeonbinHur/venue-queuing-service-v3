//
//  persistence.swift
//  MyTable
//
//  Created by snlcom on 26/9/2023.
//

import Foundation
import CoreData

/// The persistance to maintain and store data locally
struct PersistenceController {
    static let shared = PersistenceController()
  
    let container: NSPersistentContainer
   
    init(inMemory: Bool = false) {
        print(URL(fileURLWithPath: "/dev/null"))
       
        container = NSPersistentContainer(name: "MyTableData")
        print(container)
        if inMemory {
           
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
            print(container)
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
                
            }
        })
    }

}

