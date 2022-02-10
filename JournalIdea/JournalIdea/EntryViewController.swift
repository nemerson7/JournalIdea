//
//  EntryViewController.swift
//  JournalIdea
//
//  Created by Nick Emerson on 6/11/21.
//
//  Team: Team07
//  Members: Aagam Shah (as19@iu.edu) and Nick Emerson (nemerso@iu.edu)
//  Project Name: JournalIdea
//  Submission Date: June 17, 2021



import UIKit
import PhotosUI

class EntryViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, PHPickerViewControllerDelegate {
    
    var myAppDelegate: AppDelegate?
    var myEntry: Entry?
    
    @IBOutlet weak var selectedImageView: UIImageView!
    
    @IBAction func addImageButtonAction(_ sender: Any) {
        var config = PHPickerConfiguration()
        config.filter = PHPickerFilter.any(of: [PHPickerFilter.images])
        config.selectionLimit = 1
        let pickerViewController = PHPickerViewController(configuration: config)
        pickerViewController.delegate = self
        self.present(pickerViewController, animated: true)
    }
    
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        
        for currResult in results {
            print("First print")
            currResult.itemProvider.loadObject(ofClass: UIImage.self) { selection, error in
                print("Second print")
                if let unwrappedSelection = selection as? UIImage {
                    DispatchQueue.main.async {
                        self.myEntry?.selectedImageData = unwrappedSelection.pngData()
                        self.selectedImageView.image = unwrappedSelection
                        self.myAppDelegate?.myModel.saveState()
                    }
                }
            }
        }
        
    }
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    
    @IBAction func hideKeyboardButtonAction(_ sender: Any) {
        self.titleTextField.resignFirstResponder()
        self.contentTextView.resignFirstResponder()
        if let modifiedTitle = self.titleTextField.text {
            self.myEntry?.title = modifiedTitle
        }
        if let modifiedContent = self.contentTextView.text {
            self.myEntry?.content = modifiedContent
        }
        self.myAppDelegate?.myModel.saveState()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myAppDelegate = UIApplication.shared.delegate as? AppDelegate
        self.titleTextField.text = self.myEntry?.title
        self.contentTextView.text = self.myEntry?.content
        if let unwrappedImageData = self.myEntry?.selectedImageData {
            self.selectedImageView.image = UIImage(data: unwrappedImageData)
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let modifiedTitle = self.titleTextField.text {
            self.myEntry?.title = modifiedTitle
        }
        self.myAppDelegate?.myModel.saveState()
        return true
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
