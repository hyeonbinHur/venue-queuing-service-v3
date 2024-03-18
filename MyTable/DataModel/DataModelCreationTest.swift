//
//  DataModelCreationTest.swift
//  MyTable
//
//  Created by snlcom on 26/9/2023.
//

import SwiftUI

struct DataModelCreationTest: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @Binding var isPresent: Bool
    @ObservedObject var coreDataVM = ImageViewModel()
    @State var isImagePicker: Bool = false
    @FetchRequest(sortDescriptors: []) var customers: FetchedResults<Customer>
    @FetchRequest(sortDescriptors: []) var restaurants: FetchedResults<Restaurant>
    @FetchRequest(sortDescriptors: []) var reservations: FetchedResults<Reservation>
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    HStack{
                        Image(systemName: "photo.fill")
                            .renderingMode(.template)
                            .font(.system(size: 30))
                            .onTapGesture {
                                self.isImagePicker = true
                            }
                        Image(uiImage: coreDataVM.selectedImage)
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                    Button("ADD Customer"){
                        isPresent = false
                        coreDataVM.createCustomer()
                        
                    }
                    Section{
                        Text("The number of Customer in DATA : \(customers.count)")
                    }
                }
                Section{
                    Button("ADD Restaurant"){
                        let newRestaurant = Restaurant(context: moc)
                        newRestaurant.id = UUID()
                        newRestaurant.menuUrl = ""
                        newRestaurant.name = ""
                        newRestaurant.phone = ""
                        newRestaurant.rating = ""
                        newRestaurant.slug = ""
                        newRestaurant.venueId = ""
                        newRestaurant.websiteUrl = ""
                        newRestaurant.inQueue = "[]"
                        newRestaurant.numOfQueue = "0"
                        try? moc.save()
                    }
                    Section{
                        Text("The number of Customer in DATA : \(restaurants.count)")
                    }
                }
                Section{
                    Button("ADD Reservation"){
                        
                        
                        let newRestaurant = Reservation(context: moc)
                        newRestaurant.id = UUID()
                        newRestaurant.bookingTime = "bookingTime"
                        newRestaurant.cusine = "cusine"
                        newRestaurant.distance = 1
                        newRestaurant.image = "image"
                        newRestaurant.latitude = 1
                        newRestaurant.longitude = 1
                        newRestaurant.name = "name"
                        newRestaurant.rating = 1
                        newRestaurant.slug = "slug"
                        newRestaurant.userId = "userId"
                        newRestaurant.venueId = "venueId"
                        
                        
                        try? moc.save()
                        
                    }
                    Section{
                        Text("The number of Customer in DATA : \(reservations.count)")
                    }
                }
                Section{
                    Button("Close"){
                        dismiss()
                    }
                    
                }
                
            }
        }
        .padding()
        .sheet(isPresented: $isImagePicker, content: {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $coreDataVM.selectedImage)
        })
    }
    
}
struct DataModelCreationTest_Previews: PreviewProvider {
    static var previews: some View {
        DataModelCreationTest(isPresent: .constant(false))
    }
}
