//
//  CoreDataStackForTesting.swift
//  MyTableTests
//
//  Created by Pascal Couturier on 14/10/2023.
//

import CoreData

// Attained from: https://medium.com/tiendeo-tech/ios-how-to-unit-test-core-data-eb4a754f2603

class CoreDataStackForTesting: NSObject {
    
    private let dataModelName: String
    
    init(dataModelName: String = "MyTableData") {
        self.dataModelName = dataModelName
    }
    lazy var persistentContainer: NSPersistentContainer = {
        let description = NSPersistentStoreDescription()
        description.url = URL(fileURLWithPath: "/dev/null")
        let container = NSPersistentContainer(name: dataModelName)
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
}
