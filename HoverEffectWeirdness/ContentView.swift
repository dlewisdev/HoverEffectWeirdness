//
//  ContentView.swift
//  HoverEffectWeirdness
//
//  Created by Danielle Lewis on 3/29/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    var body: some View {
        ScrollView {
            DisclosureGroup {
                VStack(alignment: .listRowSeparatorLeading) {
                    ForEach(0..<5) { _ in
                        childView
                    }
                }
                
            } label: {
                parentView
                    .padding(10)
                    .contentShape(.hoverEffect, .rect)
                    .hoverEffect()
            }
        }
        .padding()
    }
    
    var childView: some View {
        ScrollView {
            HStack {
                Button {
                    // does nothing
                } label: {
                    HStack {
                        Image(systemName: "person.fill.turn.left")
                            .resizable()
                            .frame(width: 75, height: 50)
                        
                        Spacer()
                        
                        Text("There is no capsule here")
                    }
                    .padding()
                    .contentShape(.hoverEffect, .rect)
                    .hoverEffect()
                }
                .buttonStyle(.plain)
                .padding()
                
            }
            .padding()
        }
    }
    
    var parentView: some View {
        HStack(alignment: .lastTextBaseline) {
            Image(systemName: "person.fill.questionmark")
                .resizable()
                .frame(width: 125, height: 100)
            Spacer()
            
            VStack(alignment: .trailing) {
                Text("There's a capsule hoverEffect")
                Text("On the outer edges")
                Text("Of this parent view")
            }
            .font(.title)
            
        }
        .padding()
    }
    
    
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
