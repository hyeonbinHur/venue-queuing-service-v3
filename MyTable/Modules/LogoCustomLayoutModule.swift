//
//  LogoCustomLayout.swift
//  MyTable
//
//  Created by Pascal Couturier on 26/8/2023.
//

import SwiftUI

// A custom layout for the logo positioning and placement
/// Custom layout logo that is displayed on the initial login screen for the user
struct LogoCustomLayoutModule: View {
    
    var body: some View {
        ZStack {
            SeatPositionLayout {
                BarStool()
                BarStool()
                
            }
            TablePositionLayout {
                
                    BarTable()
            }
        }
    }
}

// Bar stool
struct BarStool: View {
    var body: some View {
        ZStack {
            // Seat Top
            Rectangle()
                .frame(width: 20, height: 5)
                .cornerRadius(15)
                .padding(.bottom, 35)
            
            // Legs
            HStack(spacing: 12) {
                Rectangle()
                    .frame(width: 2, height: 40)
                    .rotationEffect(.degrees(10))
                
                Rectangle()
                    .frame(width: 2, height: 40)
                    .rotationEffect(.degrees(-10))
                
            }
            
            // Seat Slats
            Rectangle()
                .frame(width: 10, height: 2)
                .cornerRadius(15)
                .padding(.bottom, 10)
            
            // Seat Slats
            Rectangle()
                .frame(width: 20, height: 2)
                .cornerRadius(15)
                .padding(.top, 20)
        }
    }
}

// Table
struct BarTable: View {
    var body: some View {
        ZStack {
            // Table Top
            Rectangle()
                .frame(width: 50, height: 7)
                .cornerRadius(15)
                .padding(.top, -20)
            
            // Table Stand
            Rectangle()
                .frame(width: 5, height: 50)
                .cornerRadius(15)
                .padding(.top, 10)
            
            Circle()
                .trim(from: 0, to: 0.5)
                .rotationEffect(.degrees(180))
                .frame(width: 20)
                .padding(.top, 70)
        }
    }
}

struct LogoCustomLayoutModule_Previews: PreviewProvider {
    static var previews: some View {
        LogoCustomLayoutModule()
    }
}

// Set the position of the bar stools on the page
// this allows for both stools to be moved around where required and their matching alignment to each other
struct SeatPositionLayout: Layout {
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        proposal.replacingUnspecifiedDimensions()
    }
    
    //custom layout
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        // Set x and y mins
        var x = 160
        var y = 210
        
        for (index, subview) in subviews.enumerated() {
            // Position
            
            subview.place(at: CGPoint(x: x, y: y), proposal: .unspecified)
            
            // Update x position for second seat
            x += 50
        }
    }
}

// positioning for the table in the logo
struct TablePositionLayout: Layout {
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        proposal.replacingUnspecifiedDimensions()
    }
    
    //custom layout
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        // Set x and y mins
        var x = 170
        var y = 170
        
        for (index, subview) in subviews.enumerated() {
            // Position
            subview.place(at: CGPoint(x: x, y: y), proposal: .unspecified)
        }
    }
}
