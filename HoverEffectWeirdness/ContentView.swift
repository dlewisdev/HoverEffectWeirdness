//
//  ContentView.swift
//  HoverEffectWeirdness
//
//  Created by Danielle Lewis on 3/29/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

extension View {
    /// Modify a view when possible.
    /// - Parameter transform: This is designed to contain an enclosing `if` statement,
    /// like for instance `if #available`.
    /// `ViewBuilder`s return `nil` when `if` conditions are `false`.
    @ViewBuilder func or(
      @ViewBuilder _ transform: (Self) -> (some View)?
    ) -> some View {
      if let transformed = transform(self) { transformed } else { self }
    }
}

private struct BareBonesDisclosureGroupStyle: DisclosureGroupStyle {
    @State private var parentHoverEffectEnabled = true

    func makeBody(configuration: Configuration) -> some View {
        Button { configuration.isExpanded.toggle() } label: {
            HStack {
                configuration.label
                VStack {
                    let text = if parentHoverEffectEnabled {
                        ("Disable", "")
                    } else {
                        ("Enable", "n't")
                    }
                    Button("\(text.0) parent hover effect") {
                        parentHoverEffectEnabled.toggle()
                    }
                    Text("The hover effect is\(text.1) present here.")
                        .padding(.top)
                }
            }.or {
                if !parentHoverEffectEnabled {
                    $0.hoverEffect()
                }
            }
        }
        .buttonStyle(.plain)
        if configuration.isExpanded { configuration.content }
    }
}

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
            .disclosureGroupStyle(BareBonesDisclosureGroupStyle())
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
