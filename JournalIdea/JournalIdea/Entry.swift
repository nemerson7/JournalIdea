//
//  RecordModel.swift
//  JournalIdea
//
//  Created by Nick Emerson on 6/7/21.
//
//  Team: Team07
//  Members: Aagam Shah (as19@iu.edu) and Nick Emerson (nemerso@iu.edu)
//  Project Name: JournalIdea
//  Submission Date: June 17, 2021



import Foundation

class Entry: NSObject, Codable {
    
    var title: String
    var content: String
    var selectedImageData: Data?
    
    
    init(_ inputTitle: String, _ inputContent: String) {
        self.title = inputTitle
        self.content = inputContent
    }
    
}
