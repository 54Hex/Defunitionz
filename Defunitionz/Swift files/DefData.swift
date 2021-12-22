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
    
    
    let sampleDefinitions = [Definition(name: "", description: "")]
    
    
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
