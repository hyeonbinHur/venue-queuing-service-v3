//
//  SearchModule.swift
//  MyTable
//
//  Created by Pascal Couturier on 22/8/2023.
//

import Foundation
import SwiftUI

// Search module that can be placed within components
/// A reusable search component that searches for items based on a query
struct SearchModule: View {
    // Search input parameter
    @State private var venueSearchQuery: String = ""
    // TODO: Create filter of list based on toggles
    @Binding var isButtonNearestSelected: Bool
    @Binding var isButtonTopReviewsSelected: Bool
    @Binding var isButtonPopularSelected: Bool
    
    var body: some View {
        VStack {
            // Search input field
            VStack (alignment: .leading, spacing: 12) {
                HStack {
                    Text("Current Location")
                        .font(.headline)
                        .padding(EdgeInsets(top: 0, leading: 5, bottom: -5, trailing: 0))
                    Image(systemName: "mappin.and.ellipse")
                        .padding(.top, 1)
                    
                    Spacer()
                    
                    Image(systemName: "slider.vertical.3")
                        .foregroundColor(Color.blue)
                        .padding(.top, 1)
                }
//                TextField("150 Burke Street, Melbourne, 3000, VIC", text: $venueSearchQuery)
//                    .textFieldStyle(.roundedBorder)
//                    .padding(.top, 0)
                
                // Buttons Section
                // TODO: make global button toggle function helper
                HStack {
                    Button(action: {self.isButtonNearestSelected.toggle()
                        isButtonTopReviewsSelected = false
                        isButtonPopularSelected = false
                        
                    }, label: {Text("Nearest")})
                        .foregroundColor(Color.black)
                        .frame(width: 90, height: 38)
                        .background(
                            RoundedRectangle(cornerRadius: 100)
                                .fill(Color(self.isButtonNearestSelected ? "ColorYellow1" : "ColorGrey1"))
                        )
                    
                    Spacer()
                    
                    Button(action: {self.isButtonTopReviewsSelected.toggle()
                        isButtonNearestSelected = false
                        isButtonPopularSelected = false
                     
                        
                    }, label: {Text("Top Reviews")})
                        .foregroundColor(Color.black)
                        .frame(width: 132, height: 38)
                        .background(
                            RoundedRectangle(cornerRadius: 100)
                                .fill(Color(self.isButtonTopReviewsSelected ? "ColorYellow1" : "ColorGrey1"))
                        )
                    
                    Spacer()
                    
                    Button(action: {self.isButtonPopularSelected.toggle()
                        isButtonTopReviewsSelected = false
                        isButtonNearestSelected = false
                      
                    }, label: {Text("Popular")})
                        .foregroundColor(Color.black)
                        .frame(width: 93, height: 38)
                        .background(
                            RoundedRectangle(cornerRadius: 100)
                                .fill(Color(self.isButtonPopularSelected ? "ColorYellow1" : "ColorGrey1"))
                        )
                }
                
            }
            .padding()
        }
    }

}
