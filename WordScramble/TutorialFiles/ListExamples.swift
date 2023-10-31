//
//  ListExamples.swift
//  WordScramble
//
//  Created by SCOTT CROWDER on 10/23/23.
//

import SwiftUI

struct ListExamples: View {
    
    let people = ["Finn", "Leia", "Luke", "Rey"]
    var body: some View {
        VStack {
            List {
                Section ("Static Data") {
                    Text("Hello World")
                    Text("Hello World")
                    Text("Hello World")
                }
                
                Section("Dynamic Data") {
                    ForEach(0..<5) {
                        Text("Dynamic Row \($0)")
                    }
                }
            }
            .listStyle(.grouped)
            
            List(0..<5) {
                Text("Dynamic row \($0)")
            }
            
            List {
                Section ("More data") {
                    Text("more...")
                    Text("more...")
                    Text("more...")
                    Text("more...")
                }
                
                Section ("More dynamic") {
                    ForEach(people, id: \.self) {
                        Text($0)
                    }
                }
                
                Section ("More static") {
                    Text("haha")
                    Text("haha")
                    Text("haha")
                    Text("haha")
                }
            }
        }
    }
}

#Preview {
    ListExamples()
}
