//
//  ListNotesTableViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit

class ListNotesTableViewController: UITableViewController {
    
    var notes = [Note](){
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notes = CoreDataHelper.retrieveNotes().reversed()
        
    }
    
    @IBAction func unwindForSegue(_ segue: UIStoryboardSegue){
        
        notes = CoreDataHelper.retrieveNotes().reversed()
        
    
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListNotesTableViewCell
        
        let note = notes[indexPath.row]
        
        cell.noteTitleLabel.text = note.title
        cell.lastModifiedTimeStampLabel.text = note.modificationTime?.convertToString() ?? ""
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let noteToRemove = notes[indexPath.row]
            CoreDataHelper.deleteNote(note: noteToRemove)
            
            notes = CoreDataHelper.retrieveNotes().reversed()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        
        switch identifier{
        case "displayNote":
            print("transitioning to detailvc")
            guard let indexPath = tableView.indexPathForSelectedRow else{return}
            
            let note = notes[indexPath.row]
            let destination = segue.destination as! DisplayNoteViewController
            destination.note = note
        case "addNote":
            print("add new note button pressed")
        default:
            print("no such segue")
            
            
        }
        
        
    }
    
}
