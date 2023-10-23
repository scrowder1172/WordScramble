//
//  FileResources.swift
//  WordScramble
//
//  Created by SCOTT CROWDER on 10/23/23.
//

import SwiftUI

struct FileResources: View {
    @State private var fileData: String = ""
    
    var body: some View {
        VStack {
            Button {
                readFile("some-file")
            } label: {
                Text("Click me to load data")
            }
            
            List {
                Section("File Data:") {
                    Text(fileData)
                }
            }
        }
    }
    
    func readFile(_ fileName: String) {
        
        if let fileURL = Bundle.main.url(forResource: fileName, withExtension: "txt") {
            // we found the file!
            if let fileContents = try? String(contentsOf: fileURL) {
                // load file data
                fileData = fileContents
            }
            
            fileData = "No data found"
        }
        
        fileData =  "No file found"
    }
}

#Preview {
    FileResources()
}
