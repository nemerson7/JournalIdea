//
//  JournalIdeaModel.swift
//  JournalIdea
//
//  Created by Nick Emerson on 6/7/21.
//
//  Team: Team07
//  Members: Aagam Shah (as19@iu.edu) and Nick Emerson (nemerso@iu.edu)
//  Project Name: JournalIdea
//  Submission Date: June 17, 2021



import Foundation
import PhotosUI

class JournalIdeaModel: NSObject, Codable {
    
    var entries: [Entry] = []
    
    var titlesArray: [String] { self.entries.map { $0.title } }
    
    func addEntry(title: String, content: String) { self.entries.append(Entry(title, content)) }
    
    override var description: String {
        self.entries.map { "# Title: " + $0.title + "\n" + $0.content}.joined(separator: "\n\n")
    }
    
    func saveState() -> () {
        do {
            let fm = FileManager.default
            let docsurl = try fm.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let myData = try PropertyListEncoder().encode(self)
            let myFile = docsurl.appendingPathComponent("appData.plist")
            try myData.write(to: myFile, options: .atomic)
            print("Data saved to appData.plist")
        } catch { print(error) }
    }
    
    
}
