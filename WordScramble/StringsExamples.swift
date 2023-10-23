//
//  StringsExamples.swift
//  WordScramble
//
//  Created by SCOTT CROWDER on 10/23/23.
//

import SwiftUI

struct StringsExamples: View {
    var body: some View {
        VStack {
            Button {
                splitStrings()
            } label: {
                Text("Split strings")
                    .frame(width: 200, height: 100)
                    .background(.green)
                    .clipShape(.capsule)
            }
            
            Button {
                printRandomString()
            } label: {
                Text("Print Random String")
                    .frame(width: 200, height: 100)
                    .background(.green)
                    .clipShape(.capsule)
            }
            
            Button {
                removeWhiteSpace()
            } label: {
                Text("Print String Wihout Whitespace")
                    .frame(width: 200, height: 100)
                    .background(.green)
                    .clipShape(.capsule)
            }
            
            Button {
                spellChecker("swift")
            } label: {
                Text("Spell check")
                    .frame(width: 200, height: 100)
                    .background(.green)
                    .clipShape(.capsule)
            }
        }
    }
    
    func splitStrings() {
        let input = "a b c"
        let letters: [String] = input.components(separatedBy: " ")
        for letter in letters {
            print(letter)
        }
        
    }
    
    func printRandomString() {
        let input = """
        a
        b
        c
        """
        let letters = input.components(separatedBy: "\n")
        let randomElement = letters.randomElement() ?? ""
        print(randomElement)
    }
    
    func removeWhiteSpace() {
        let sampleString: String = " \nthis is some text \n\n\n\n"
        
        print("Unformatted:\(sampleString)")
        print("Formatted: \(sampleString.trimmingCharacters(in: .whitespacesAndNewlines))")
    }
    
    func spellChecker(_ word: String) {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspellRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        if misspellRange.location == NSNotFound {
            print("\(word) was spelled correctly!")
        } else {
            print("\(word) is misspelled")
        }
    }
}

#Preview {
    StringsExamples()
}
