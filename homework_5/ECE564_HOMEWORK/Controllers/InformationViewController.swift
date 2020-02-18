//
//  InformationViewController.swift
//  ECE564_HOMEWORK
//
//  Created by Nan Ni on 1/31/20.
//  Copyright © 2020 ECE564. All rights reserved.
//

import UIKit
import MobileCoreServices

/**
 The mode of information view
 */
enum Mode {
    case Adding     //Add new person
    case Updating   //Edit person
    case Displaying //Display information, cannot edit
}

class InformationViewController: UIViewController, UINavigationBarDelegate {
    var mode: Mode = .Displaying
    var person = DukePerson()
    var teamHide = false
    
    var backButtonPressed = false
    var cancelButtonPressed = false
    var addOrUpdateSuccess = false
    let genders = ["Male", "Female"]
    let roles = ["Professor", "TA", "Student"]
    let degrees = ["MS", "BS", "MENG", "PHD", "NA", "Other"]
    
    var genderPickerView: UIPickerView!
    var rolePickerView: UIPickerView!
    var degreePickerView: UIPickerView!
    var imagePickerController : UIImagePickerController!
    
    @IBOutlet weak var saveButtonView: UIView!    
    @IBOutlet weak var editAndCancelButton: UIBarButtonItem!
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var roleTextField: UITextField!
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var degreeTextField: UITextField!
    @IBOutlet weak var hobbiesTextField: UITextField!
    @IBOutlet weak var languagesTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var teamTextField: UITextField!
    
    
    override func viewWillAppear(_ animated: Bool) {
        teamLabel.isHidden = teamHide
        teamTextField.isHidden = teamHide
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        addPickersToView()
        addImagePickerToView()
        
        roleTextField.addTarget(self, action: #selector(textFieldEditingDidChange(_:)), for: UIControl.Event.editingDidEnd)
        
        // Load information view according to add or edit mode.
        if mode == .Displaying {
            resetPersonInformation()
            isUserInteractive(false)
            editAndCancelButton.title = "Edit"
            saveButtonView.isHidden = true
            mode = .Updating
        } else if mode == .Adding {
            editAndCancelButton.title = "Cancel"
            saveButtonView.isHidden = false
        }
        
        hideKeyboardWhenTappedAround()
    }
    
    
    func addPickersToView() {
        genderPickerView = UIPickerView()
        genderPickerView.tag = 1
        genderPickerView.delegate = self
        genderPickerView.dataSource = self
        genderTextField.inputView = genderPickerView
        genderTextField.delegate = self
        
        rolePickerView = UIPickerView()
        rolePickerView.tag = 2
        rolePickerView.delegate = self
        rolePickerView.dataSource = self
        roleTextField.inputView = rolePickerView
        roleTextField.delegate = self
        
        degreePickerView = UIPickerView()
        degreePickerView.tag = 3
        degreePickerView.delegate = self
        degreePickerView.dataSource = self
        degreeTextField.inputView = degreePickerView
        degreeTextField.delegate = self
    }
    
    func addImagePickerToView() {
        photoImageView.layer.masksToBounds = true
        photoImageView.layer.cornerRadius = photoImageView.bounds.width / 2
        
        let photoTapActionGR = UITapGestureRecognizer()
        photoTapActionGR.addTarget(self, action: Selector(("selectPhoto")))
        photoImageView.addGestureRecognizer(photoTapActionGR)
        photoImageView.isUserInteractionEnabled = true
    }
    
    @IBAction func textFieldEditingDidChange(_ sender: Any) {
        if roleTextField.text == "Student" {
            teamLabel.isHidden = false
            teamTextField.isHidden = false
        } else {
            teamLabel.isHidden = true
            teamTextField.isHidden = true
            teamTextField.text = ""
        }
    }
    
    
    // MARK: - Navigation
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if addOrUpdateSuccess {
            return true
        }
        return false
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        addOrUpdateSuccess = addOrUpdatePerson()
        if addOrUpdateSuccess {
            performSegue(withIdentifier: K.saveBackSegue, sender: self)
        } else {
            return
        }
    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        backButtonPressed = true
        performSegue(withIdentifier: K.saveBackSegue, sender: self)
    }
    
    @IBAction func editPressed(_ sender: UIBarButtonItem) {
        if mode == .Adding { //Button is "Cancel"
            cancelButtonPressed = true
            performSegue(withIdentifier: K.saveBackSegue, sender: self)
        } else if mode == .Displaying {
            isUserInteractive(false)
            editAndCancelButton.title = "Edit"
            saveButtonView.isHidden = true
            mode = .Updating
            resetPersonInformation()
        } else if mode == .Updating {
            print("you can edit now") //For easy debug
            isUserInteractive(true)
            editAndCancelButton.title = "Cancel"
            saveButtonView.isHidden = false
            mode = .Displaying
        }
    }
    
    /**
     Fill in person's information
     */
    func resetPersonInformation() {
        photoImageView.image = person.picture.base64ToImage()
        fullNameLabel.text = ""
        displayFullNameAnimation()
        firstNameTextField.text = person.firstName
        lastNameTextField.text = person.lastName
        genderTextField.text = person.gender == .Male ? "Male" : "Female"
        switch person.role {
        case .Professor:
            self.roleTextField.text = "Professor"
        case .TA:
            self.roleTextField.text = "TA"
        case .Student:
            self.roleTextField.text = "Student"
        }
        fromTextField.text = person.whereFrom
        degreeTextField.text = person.degree
        hobbiesTextField.text = person.hobbies.joined(separator: ",")
        languagesTextField.text = person.languages.joined(separator: ",")
        teamTextField.text = person.team
    }
    
    func displayFullNameAnimation() {
        var charIndex = 0.0
        for letter in "\(person.firstName) \(person.lastName)" {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
                self.fullNameLabel.text?.append(letter)
            }
            charIndex += 1
        }
    }
    

    /**
     Save person's information
     */
    func addOrUpdatePerson() -> Bool {
        //Invalid case 1: Empty fields
        if  ((firstNameTextField.text?.isEmpty)!
            || (lastNameTextField.text?.isEmpty)!
            || (genderTextField.text?.isEmpty)!
            || (roleTextField.text?.isEmpty)!
            || (fromTextField.text?.isEmpty)!
            || (degreeTextField.text?.isEmpty)!) {
            self.showAlert(title: "Save failed", message: "All fields with * are required!")
            return false
        }
        
        //Invalid case 2: Person already exists
        let fullNameResult = dukePersonsArray.filter { $0.firstName == firstNameTextField.text! && $0.lastName == lastNameTextField.text! }
        if mode == .Adding && !fullNameResult.isEmpty {
            self.showAlert(title: "Save failed", message: "\(firstNameTextField.text!) \(lastNameTextField.text!) already exists in database!")
            return false
        }
        
        //Invalid case 3: More than 3 hobbies or languages
        let hobbies: [String] = hobbiesTextField.text!.components(separatedBy: ",")
        if hobbies.count > 3 {
            self.showAlert(title: "Save failed", message: "Hobbies: Up to 3 hobbies!")
            return false
        }
        
        let languages: [String] = languagesTextField.text!.components(separatedBy: ",")
        if languages.count > 3 {
            self.showAlert(title: "Save failed", message: "Hobbies: Up to 3 languages!")
            return false
        }
        
        
        // All inputs are valid
        let genderText = genderTextField.text!
        if genderText == "Female" {
            person.gender = .Female
        } else {
            person.gender = .Male
        }
        
        let roleText = roleTextField.text!
        if roleText == "Student" {
            person.role = .Student
        } else if roleText == "TA" {
            person.role = .TA
        } else if roleText == "Professor" {
            person.role = .Professor
        }
        person.picture = photoImageView.image!.resizeImage(resize: K.photoSize).scaleImage(scaleSize: K.scaleSize).base64ToString()
        person.firstName = firstNameTextField.text!
        person.lastName = lastNameTextField.text!
        person.whereFrom = fromTextField.text!
        person.degree = degreeTextField.text!
        person.team = teamTextField.text!
        person.hobbies = hobbies
        person.languages = languages
        var updateSuccess = true
        if mode == .Displaying {
            let p = findOneFromDB(person.firstName, person.lastName)
            if p.firstName == "First" && p.lastName == "Last" {
                updateSuccess = insertDB(self.person)
            } else {
                updateSuccess = updateDB(self.person)
            }
        }
        return true && updateSuccess
    }
    
    
    @objc func selectPhoto() {
        let choosePhotoAlert = UIAlertController(title: "Please Choose", message: "", preferredStyle: UIAlertController.Style.actionSheet)
        
        let chooseFromPhotoAlbum = UIAlertAction(title: "From Album", style: UIAlertAction.Style.default, handler: funcChooseFromPhotoAlbum)
        choosePhotoAlert.addAction(chooseFromPhotoAlbum)
        
        let chooseFromCamera = UIAlertAction(title: "Take Photo", style: UIAlertAction.Style.default, handler: funcChooseFromCamera)
        choosePhotoAlert.addAction(chooseFromCamera)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel,handler: nil)
        choosePhotoAlert.addAction(cancelAction)
        present(choosePhotoAlert, animated: true, completion: nil)
    }
    
    @IBAction func funcChooseFromPhotoAlbum(_ sender: Any){
        let lib = UIImagePickerController.SourceType.photoLibrary
        let ok = UIImagePickerController.isSourceTypeAvailable(lib)
        if (!ok) {
            print("error")
            return
        }
        let desiredType = kUTTypeImage as NSString as String
        let arr = UIImagePickerController.availableMediaTypes(for: lib)
        print(arr!)
        if arr?.firstIndex(of: desiredType) == nil {
            print("error")
            return
        }
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func funcChooseFromCamera(_ sender: Any) {
        let cam = UIImagePickerController.SourceType.camera
        let ok = UIImagePickerController.isSourceTypeAvailable(cam)
        if (!ok) {
            print("No camera!")
            return
        }
        let desiredType = kUTTypeImage as NSString as String
        let arr = UIImagePickerController.availableMediaTypes(for: cam)
        print(arr!)
        if arr?.firstIndex(of: desiredType) == nil {
            print("No capture!")
            return
        }
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    func isUserInteractive(_ state: Bool) {
        photoImageView.isUserInteractionEnabled = state
        firstNameTextField.isDisabled(false)
        lastNameTextField.isDisabled(false)
        genderTextField.isDisabled(state)
        roleTextField.isDisabled(state)
        fromTextField.isDisabled(state)
        degreeTextField.isDisabled(state)
        hobbiesTextField.isDisabled(state)
        languagesTextField.isDisabled(state)
        teamTextField.isDisabled(state)
    }
}



//MARK: - UIPickerView delegate calls
extension InformationViewController: UIPickerViewDelegate, UIPickerViewDataSource {    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return genders.count
        } else if pickerView.tag == 2 {
            return roles.count
        } else if pickerView.tag == 3 {
            return degrees.count
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return "\(genders[row])"
        } else if pickerView.tag == 2 {
            return "\(roles[row])"
        } else if pickerView.tag == 3 {
            return "\(degrees[row])"
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            genderTextField.text = genders[row]
        } else if pickerView.tag == 2 {
            roleTextField.text = roles[row]
        } else if pickerView.tag == 3 {
            degreeTextField.text = degrees[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = (view as? UILabel) ?? UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        
        if pickerView.tag == 1 {
            label.text = genders[row]
        } else if pickerView.tag == 2 {
            label.text = roles[row]
        } else if pickerView.tag == 3 {
            label.text = degrees[row]
        }
        
        return label
    }
}

//MARK: - imagePicker delegate calls
extension InformationViewController:  UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePickerController.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        photoImageView.image = image
    }
}


//MARK: -Textfield
extension InformationViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let text = textField.text!
        if textField == genderTextField {
            if text.isEmpty {
                textField.text = genders[0]
            } else {
                genderPickerView.selectRow(genders.firstIndex(of: text)!, inComponent: 0, animated: true)
            }
        }
        if textField == roleTextField {
            if text.isEmpty {
                textField.text = roles[0]
            } else {
                rolePickerView.selectRow(roles.firstIndex(of: text)!, inComponent: 0, animated: true)
            }
        }
        if textField == degreeTextField {
            if text.isEmpty {
                textField.text = degrees[0]
            } else {
                degreePickerView.selectRow(degrees.firstIndex(of: text)!, inComponent: 0, animated: true)
            }
        }
    }
}
