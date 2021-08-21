//
//  AddViewController.swift
//  Step2
//
//  Created by Sergey on 17.08.2021.
//

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    
    @IBOutlet var targetLabel: UITextField!
    @IBOutlet var titleTextlabel: UITextView!
    @IBOutlet var datePicker: UIDatePicker!
    
    
    public var completion: ((String, String, Date) -> Void)?
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        
        
        
        targetLabel.delegate = self
        titleTextlabel.delegate = self

        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "✔️", style: .done, target: self, action: #selector(didTapSaveButton))
       
    }
    
    @objc func didTapSaveButton() {
        if let titleText = targetLabel.text, !titleText.isEmpty,
           let bodyText = titleTextlabel.text, !bodyText.isEmpty {
           let targetDates = datePicker.date
            
            completion?(titleText, bodyText, targetDates)
            
        }
        
        
    }
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        
        
        return true
    }
   
    func textViewShouldReturn(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        
        return true
    }
}
