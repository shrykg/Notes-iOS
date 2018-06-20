//
//  Coredata.swift
//  MakeSchoolNotes
//
//  Created by Shreyak Godala on 20/06/18.
//  Copyright © 2018 MakeSchool. All rights reserved.
//

import Foundation
import UIKit
import CoreData

struct CoreDataHelper{
    
    static let context: NSManagedObjectContext =  {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        
        let persistentContainer = delegate.persistentContainer
        let context = persistentContainer.viewContext
        
        return context
    }()
    
    static func newNote() -> Note {
        let note = NSEntityDescription.insertNewObject(forEntityName: "Note", into: context) as! Note
        return note
    }
    
    static func saveNote() {
        
        do {
            try context.save()
        } catch let error {
            print("Could not be saved as \(error.localizedDescription)")
        }
    }
    
    static func deleteNote(note: Note){
        context.delete(note)
        saveNote()
    }
    
    static func retrieveNotes() -> [Note] {
        
        
        do {
            let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
            let notes = try context.fetch(fetchRequest)
            
            return notes
            
        } catch let error {
            print("Could not be retrieved as \(error.localizedDescription)")
        }
        
        return []
    }
    
}
