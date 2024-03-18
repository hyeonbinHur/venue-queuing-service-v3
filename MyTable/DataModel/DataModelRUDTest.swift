//
//  DataModelRUDTest.swift
//  MyTable
//
//  Created by snlcom on 26/9/2023.
//

import SwiftUI

struct DataModelRUDTest: View {
    let persistenceController = PersistenceController.shared
    
    @FetchRequest(sortDescriptors: []) var customers: FetchedResults<Customer>
    @FetchRequest(sortDescriptors: []) var restaurants: FetchedResults<Restaurant>
    @FetchRequest(sortDescriptors: []) var reservations: FetchedResults<Reservation>
    
    var body: some View {
        VStack{
            Section{
                Text("Customer")
                List{
                    ForEach(customers){
                        customer in
                        if let data = customer.avatar, let uiImage = UIImage(data: data) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(5)
                                .frame(width: 100, height: 100)
                                .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 0)
                        }
                        Text(customer.firstname )
                            .swipeActions(allowsFullSwipe: true){
                                Button("Delete"){
                                    do{
                                        try delete(customer)
                                    }catch{
                                        print(error)
                                    }
                                }
                            }
                    }
                }
            }
            
            Section{
                Text("Reservation")
                List(reservations){ reservation in
                    Text(reservation.name )
                    
                }
            }
            Section{
                Text("Restaurant")
                List(restaurants){ restaurant in
                    Text(restaurant.name )
                        .swipeActions(allowsFullSwipe: true){
                            Button("Delete"){
                                do{
                                    try delete2(restaurant)
                                }catch{
                                    print(error)
                                }
                            }
                        }  
                }
            }
            
        }
    }
}

private extension DataModelRUDTest{
    func delete(_ contact: Customer) throws {
        let context = persistenceController.container.viewContext
        let exisitingItem = try context.existingObject(with: contact.objectID)
        context.delete(exisitingItem)
    }
    
    func delete2(_ contact: Restaurant) throws {
        let context = persistenceController.container.viewContext
        let exisitingItem = try context.existingObject(with: contact.objectID)
        context.delete(exisitingItem)
    }
}

struct DataModelRUDTest_Previews: PreviewProvider {
    static var previews: some View {
        DataModelRUDTest()
    }
}
