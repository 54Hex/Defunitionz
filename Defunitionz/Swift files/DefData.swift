//
//  DefData.swift
//  Defunitionz
//
//  Created by Conqueriings on 22/12/21.
//
import Foundation
import SwiftUI

class defData: ObservableObject {
    @Published var definitions: [Definition] = []
    
    
    let sampleDefinitions = [Definition(name: "1. Intro", description: "Hello. Welcome to Defunitionz, an app created in a day because it was made with a random idea."),
                             Definition(name: "2. How to use", description: "Edit allows you to delete any of your definitions. Or you could just swipe right at the definition you would want to delete/remove."),
                             Definition(name: "3. What you can do", description: "Pretty sure there's nothing much you could do here except for adding definitions such as mathematical formulas so that you can memorise and apply it for your own studies, or you could use it to store english definitions that you are unsure of.")]
    
    
    func getArchiveURL() -> URL {
        let plistName = "definitions.plist"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent(plistName)
    }
    func save() {
        let archiveURL = getArchiveURL()
        let propertyListEncoder = PropertyListEncoder()
        let encodedDefinitions = try? propertyListEncoder.encode(definitions)
        try? encodedDefinitions?.write(to: archiveURL, options: .noFileProtection)
    }
    
    func load() {
        let archiveURL = getArchiveURL()
        let propertyListDecoder = PropertyListDecoder()
        
        var finalDefinitions: [Definition]!
        
        if let retrievedDefinitionsData = try? Data(contentsOf: archiveURL),
           let decodedDefinitions = try? propertyListDecoder.decode(Array<Definition>.self, from: retrievedDefinitionsData) {
            finalDefinitions = decodedDefinitions
        } else {
            finalDefinitions = sampleDefinitions
        }
        definitions = finalDefinitions
    }
}
