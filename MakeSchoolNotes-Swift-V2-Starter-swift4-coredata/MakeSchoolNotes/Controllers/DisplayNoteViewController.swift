//
//  DisplayNoteViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit

class DisplayNoteViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var contextTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleTextField.text = ""
        contextTextView.text = ""
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        
        switch identifier {
        case "save":
            
            let note = Note()
            note.title = titleTextField.text ?? ""
            note.content = contextTextView.text ?? ""
            note.modificationTime = Date()
            
            let destination = segue.destination as! ListNotesTableViewController
            destination.notes.append(note)
        case "cancel":
            print("transition to list via cancel")
        default:
            print("no segue found")
        }
    }
    
    
    
}
