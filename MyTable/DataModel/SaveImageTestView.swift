//
//  SaveImageTestView.swift
//  MyTable
//
//  Created by snlcom on 3/10/2023.
//

import SwiftUI

struct SaveImageTestView: View {
    var body: some View {
        VStack(){
            
                Text("Customer: "+"hhb")
                    .padding(.top,10)
                    .padding(.bottom, 5)
                Text("Team number: "+"3")
            
            Divider()
                .padding(.leading,20)
                .padding(.trailing,20)
            
            HStack{
                Button("Arrived"){
                   
                }
                .foregroundColor(.black)
                .frame(width: 120,height: 30)
                .background(Color("ColorGrey1"))
                .border(Color("ColorYellow1"),width: 1)
                
                Button("Kick"){
                    
                }
                .foregroundColor(.black)
                .frame(width: 120,height: 30)
                .background(Color("ColorGrey1"))
                .border(Color("ColorYellow1"),width: 1)
                
                
            }
            .padding(10)
        }
        .frame(
            maxWidth: 300,
            minHeight: 100,
            maxHeight: 150,
            alignment: .top
        )
        .background(Color("ColorYellow1"))
        .cornerRadius(10)
    }
}

struct SaveImageTestView_Previews: PreviewProvider {
    static var previews: some View {
        SaveImageTestView()
    }
}
