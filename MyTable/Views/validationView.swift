//
//  validationView.swift
//  MyTable
//
//  Created by snlcom on 9/10/2023.
//

import SwiftUI

struct validationView: View {
    //https://www.youtube.com/watch?v=LZRxEdJqXJg
    
    @EnvironmentObject var restaurantProfileModel: RestaurantProfileModel
    
    @Environment(\.managedObjectContext) var moc
    let numberOfFields: Int
    @State private var ValidationCode: String = ""
    @State var EnteredCode: [String]
    @State private var oldValue = ""
    @FocusState private var fieldFocus: Int?
    @Binding var isEditing: Bool
    
    init(numberOfFields: Int, isEditing: Binding<Bool>) {
        self.numberOfFields = numberOfFields
        self.EnteredCode = Array(repeating: "", count: numberOfFields)
        self._isEditing = isEditing
    }
    var body: some View {
        VStack(spacing: 10){
            VStack(alignment: .leading){
                HStack{
                    Button{isEditing = false}
                label:{
                    Image(systemName: "chevron.backward")
                    Text("Back")
                    
                }
                .padding(.leading,20)
                    
                    Spacer()
                }
            }
            .padding(.bottom,10)
            
            Text("Your current Code is "+restaurantProfileModel.validationCode)
            Text("Change Todays's Validation Code!")
                .padding(.vertical, 20)
           
            Text("Validation Code")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.callout)
                .fontWeight(.bold)
                .padding(.leading, 30)
                .padding(.bottom, 10)
                .padding(.top, 100)
            
            HStack{
                ForEach (0..<numberOfFields, id: \.self){index in TextField("",text: $EnteredCode[index],onEditingChanged: { editting in
                    
                    if editting {
                        oldValue = EnteredCode[index]
                    }
                })
                        .frame(width: 60, height: 60)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(5)
                        .multilineTextAlignment(.center)
                        .focused($fieldFocus,equals: index)
                        .tag(index)
                        .onChange(of: EnteredCode[index]){
                            newvalue in
                            if EnteredCode[index].count > 1 {
                                
                                let currentValue = Array(EnteredCode[index])
                                
                                if currentValue[0] == Character(oldValue){
                                    
                                    EnteredCode[index] = String(EnteredCode[index].suffix(1))
                                }else{
                                    EnteredCode[index] = String(EnteredCode[index].prefix(1))
                                }
                                
                                EnteredCode[index] = String(EnteredCode[index].suffix(1))
                                
                                
                            }
                            if !newvalue.isEmpty{
                                if index == numberOfFields - 1{
                                    fieldFocus = nil
                                } else{
                                    fieldFocus = (fieldFocus ?? 0) + 1
                                }
                            }
                        }
                }
            }
            Button("Confirm"){
                ChangeValidationCode()
            }
            .font(.headline)
            .foregroundColor(Color.black)
            .frame(width: 330, height: 40)
            .background(
                Color("ColorYellow1")
            )
            .padding(.top, 300)
            Spacer()
        }
    }
    
    /// this function allows restaurant change their validation code
    func ChangeValidationCode(){
        if EnteredCode.joined().count == 5{
            ValidationCode = EnteredCode.joined()
            restaurantProfileModel.validationCode = ValidationCode
            RestaurantProfileDataMapperHelper(context: moc).updateRestaurantByVenueId(restaurantProfileModel: restaurantProfileModel)
            isEditing = false
            print(ValidationCode)
        }else{
            print("alert")
        }
        
    }
    
}

struct validationView_Previews: PreviewProvider {
    static var previews: some View {
        
        var profileModel = ProfileModel()
        profileModel.loadDummyCustomerProfileData()
        profileModel.isLoggedIn = true
        
        
        return validationView(numberOfFields:5, isEditing: .constant(true)).environmentObject(profileModel)
            .environmentObject(RestaurantProfileModel())
    }
    
}
