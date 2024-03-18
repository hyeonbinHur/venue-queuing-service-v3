//
//  ImageViewModel.swift
//  MyTable
//
//  Created by snlcom on 3/10/2023.
//

import SwiftUI
import CoreData


/// the image will be stored into this model, after that the image will be copied into the real data table from this image model
class ImageViewModel: ObservableObject{
    
    let moc: NSManagedObjectContext = PersistenceController.shared.container.viewContext
    @Published var id: String = ""
    @Published var firstname: String = ""
    @Published var lastname: String = ""
    @Published var password: String = ""
    @Published var phone: String = ""
    @Published var userId: String = ""
    @Published var username: String = ""
    
    @Published var selectedImage: UIImage = UIImage()
    
    @Published var selectedImage1: UIImage = UIImage()
    @Published var selectedImage2: UIImage = UIImage()
    @Published var selectedImage3: UIImage = UIImage()
    @Published var selectedImage4: UIImage = UIImage()
    @Published var selectedImage5: UIImage = UIImage()
    
    func createCustomer(){
        let newUser = Customer(context: moc)
        newUser.id = UUID()
        newUser.firstname = ""
        newUser.lastname = ""
        newUser.password = ""
        newUser.phone = ""
        newUser.userId = ""
        newUser.username = ""
        
        if let photoData = selectedImage.jpegData(compressionQuality: 0.1) {
            newUser.avatar = photoData
        }
        
        saveCustomer()
    }
    
     func saveCustomer(){
         do{
             try moc.save()
         }catch {
             let error = error as NSError
             fatalError("Unresolved error: \(error)")
         }
    }
}
