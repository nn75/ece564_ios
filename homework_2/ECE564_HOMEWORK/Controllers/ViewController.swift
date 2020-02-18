//
//  ViewController.swift
//  ECE564_HOMEWORK
//
//  Created by Richard Telford on 1/11/20.
//  Copyright © 2020 ECE564. All rights reserved.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController {

    let labelNameArray = ["First:", "Last:", "Gender:", "Role:", "From:", "Degree:", "Hobbies:", "Languages:"]
    let textPlaceHolderArray = ["First Name",
                                "Last Name",
                                "Male or Female",
                                "Student, TA or Professor",
                                "Any string or location info",
                                "MS, BS, MENG, PHD, NA, Other",
                                "Up to 3 hobbies, comma delimited",
                                "Up to 3 programming lang, comma delimited"]
    let buttonNameArray = ["Add/Update", "Find"]
    
    let genders = ["Male", "Female"]
    let roles = ["Student", "TA", "Professor"]
    let degrees = ["MS", "BS", "MENG", "PHD", "NA", "Other"]
    
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.backgroundColor = UIColor(named: K.BrandColors.lightBlue)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    let mainStackView : UIStackView = {
        let v = UIStackView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    let listStackView : UIStackView = {
        let v = UIStackView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    var labelStackView: UIStackView!
    var textStackView: UIStackView!
    var buttonStackView: UIStackView!

    let boardView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(named: K.BrandColors.milkyWhite)
        v.layer.cornerRadius = 10
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor(named: K.BrandColors.blue)?.cgColor
        NSLayoutConstraint.activate([
            v.widthAnchor.constraint(equalToConstant: 335),
            v.heightAnchor.constraint(equalToConstant: 100),
        ])
        return v
    }()

    let resultLabelView: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = ""
        v.font = UIFont(name: "ArialHebrew", size: 17)
        v.lineBreakMode = .byWordWrapping
        v.numberOfLines = 0
        NSLayoutConstraint.activate([
            v.widthAnchor.constraint(equalToConstant: 300),
            v.heightAnchor.constraint(equalToConstant: 100),
        ])
        return v
    }()

    var labelArray: [UILabel]!
    var textArray: [UITextField]!
    var buttonArray: [UIButton]!
    
    var firstNameTextView: UITextField!
    var lastNameTextView: UITextField!
    var genderTextView: UITextField!
    var roleTextView: UITextField!
    var fromTextView: UITextField!
    var degreeTextView: UITextField!
    var hobbiesTextView: UITextField!
    var languagesTextView: UITextField!
    
    var genderPickerView: UIPickerView!
    var rolePickerView: UIPickerView!
    var degreePickerView: UIPickerView!
    
    var addUpdateButton: UIButton!
    var findButton: UIButton!
    
    @IBOutlet var photoView: UIImageView!
    var imagePickerController : UIImagePickerController!
    
    var photoIsDisplayed = false
    var photoHaveBeenUpdated = false

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create UIViews we need
        labelArray = createLabelArray(named: labelNameArray)
        textArray = createTextArray(named: textPlaceHolderArray)
        buttonArray = createButtonArray(named: buttonNameArray)
        
        // Load the screen
        addScrollView()
        addListViews()
        addPhotoView()
        addResultView()
        addButtonViews()
        
        firstNameTextView = textArray[0]
        lastNameTextView = textArray[1]
        genderTextView = textArray[2]
        roleTextView = textArray[3]
        fromTextView = textArray[4]
        degreeTextView = textArray[5]
        hobbiesTextView = textArray[6]
        languagesTextView = textArray[7]
        
        addPickersToView()
        
        addUpdateButton = buttonArray[0]
        findButton = buttonArray[1]
        addUpdateButton.addTarget(self, action: #selector(ViewController.addUpdateButtonPressed(_:)), for: .touchUpInside)
        findButton.addTarget(self, action: #selector(ViewController.findButtonPressed(_:)), for: .touchUpInside)
        
        let photoTapActionGR = UITapGestureRecognizer()
        photoTapActionGR.addTarget(self, action: Selector(("selectPhoto")))
        photoView.isUserInteractionEnabled = true
        photoView.addGestureRecognizer(photoTapActionGR)
        
        hideKeyboardWhenTappedAround()
    }

    func addScrollView() {
        // add the scroll view to self.view
        self.view.addSubview(scrollView)
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        // add the main stack view to the scroll view
        scrollView.addSubview(mainStackView)
        mainStackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        mainStackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        mainStackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        mainStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
    }

    func addListViews() {
        //add the list stack view to the main stack view
        mainStackView.addSubview(listStackView)
        listStackView.leftAnchor.constraint(equalTo: mainStackView.leftAnchor, constant: 10).isActive = true
        listStackView.topAnchor.constraint(equalTo: mainStackView.topAnchor, constant: 15).isActive = true
        listStackView.rightAnchor.constraint(equalTo: mainStackView.rightAnchor, constant: -10).isActive = true
        
        //add the label stack view to the list stack view
        labelStackView = UIStackView(arrangedSubviews: labelArray)
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        labelStackView.axis = .vertical
        labelStackView.distribution = .equalSpacing
        labelStackView.spacing = 12
        NSLayoutConstraint.activate([
             labelStackView.widthAnchor.constraint(equalToConstant: 95),
         ])
        listStackView.addSubview(labelStackView)
        labelStackView.leftAnchor.constraint(equalTo: listStackView.leftAnchor, constant: 3).isActive = true
        labelStackView.topAnchor.constraint(equalTo: listStackView.topAnchor, constant: 20).isActive = true
        labelStackView.bottomAnchor.constraint(equalTo: listStackView.bottomAnchor).isActive = true
        
        //add the text stack view to the list stack view
        textStackView = UIStackView(arrangedSubviews: textArray)
        textStackView.translatesAutoresizingMaskIntoConstraints = false
        textStackView.axis = .vertical
        textStackView.distribution = .equalSpacing
        textStackView.spacing = 12
        listStackView.addSubview(textStackView)
        textStackView.leftAnchor.constraint(equalTo: labelStackView.rightAnchor).isActive = true
        textStackView.topAnchor.constraint(equalTo: listStackView.topAnchor, constant: 20).isActive = true
        textStackView.rightAnchor.constraint(equalTo: listStackView.rightAnchor, constant: -3).isActive = true
        textStackView.bottomAnchor.constraint(equalTo: listStackView.bottomAnchor).isActive = true
    }

    func addPhotoView() {
        //add photo to the photo board button stack view
        photoView = UIImageView()
        photoView.translatesAutoresizingMaskIntoConstraints = false
        photoView.image = UIImage(named: "No photo")
        photoView.contentMode = .scaleAspectFit
        photoView.layer.masksToBounds = true
        photoView.layer.borderWidth = 5
        photoView.layer.borderColor = UIColor(named: K.BrandColors.milkyWhite)?.cgColor
        photoView.layer.cornerRadius = 85
        NSLayoutConstraint.activate([
            photoView.widthAnchor.constraint(equalToConstant: 170),
            photoView.heightAnchor.constraint(equalToConstant: 170),
        ])
        mainStackView.addSubview(photoView)
        photoView.centerXAnchor.constraint(equalTo: mainStackView.centerXAnchor).isActive = true
        photoView.topAnchor.constraint(equalTo: listStackView.bottomAnchor, constant: 15).isActive = true
    }
    
    func addResultView() {
        //add board to the photo board button stack view
        mainStackView.addSubview(boardView)
        boardView.centerXAnchor.constraint(equalTo: mainStackView.centerXAnchor).isActive = true
        boardView.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: 10).isActive = true
        
        //add board text to the board view
        boardView.addSubview(resultLabelView)
        resultLabelView.centerXAnchor.constraint(equalTo: boardView.centerXAnchor).isActive = true
        resultLabelView.topAnchor.constraint(equalTo: boardView.topAnchor, constant: 5).isActive = true
    }
    
    func addButtonViews() {
        //add button stack view to the photo board button stack view
        buttonStackView = UIStackView(arrangedSubviews: buttonArray)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 15.0
        NSLayoutConstraint.activate([
            buttonStackView.widthAnchor.constraint(equalToConstant: 335),
            buttonStackView.heightAnchor.constraint(equalToConstant: 40),
        ])
        mainStackView.addSubview(buttonStackView)
        buttonStackView.centerXAnchor.constraint(equalTo: mainStackView.centerXAnchor).isActive = true
        buttonStackView.topAnchor.constraint(equalTo: boardView.bottomAnchor, constant: 12.0).isActive = true
        buttonStackView.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: -12.0).isActive = true
        
    }
    
    func addPickersToView() {
        genderPickerView = UIPickerView()
        genderPickerView.tag = 1
        genderPickerView.delegate = self
        genderPickerView.dataSource = self
        genderTextView.inputView = genderPickerView
        
        rolePickerView = UIPickerView()
        rolePickerView.tag = 2
        rolePickerView.delegate = self
        rolePickerView.dataSource = self
        roleTextView.inputView = rolePickerView
        
        degreePickerView = UIPickerView()
        degreePickerView.tag = 3
        degreePickerView.delegate = self
        degreePickerView.dataSource = self
        degreeTextView.inputView = degreePickerView
    }
    

    func createLabelArray(named: [String]) -> [UILabel] {
        return named.map {name in
            let label  = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "\(name)"
            label.font = UIFont(name: "ArialHebrew", size: 17)
            label.textAlignment = .left
            return label
        }
    }

    func createTextArray(named: [String]) -> [UITextField] {
        return named.map {name in
            let text  = UITextField()
            text.translatesAutoresizingMaskIntoConstraints = false
            text.font = UIFont(name: "ArialHebrew", size: 18)
            text.backgroundColor = UIColor(named: K.BrandColors.milkyWhite)
            text.layer.cornerRadius = 8
            text.layer.borderWidth = 1
            text.layer.borderColor = UIColor(named: K.BrandColors.blue)?.cgColor
            text.attributedPlaceholder = NSAttributedString(string: "\(name)", attributes: [
                .foregroundColor: UIColor.lightGray,
                .font: UIFont.systemFont(ofSize: 11)
                ])
            text.setLeftPaddingPoints(5)
            return text
        }
    }

    func createButtonArray(named: [String]) -> [UIButton] {
        return named.map {name in
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = UIColor(named: K.BrandColors.blue)
            button.setTitle("\(name)", for: .normal)
            button.titleLabel?.font = UIFont(name: "BalooBhaina-Regular", size: 24)
            button.layer.cornerRadius = 5
            return button
        }
    }
    
    // Get photo by choosing from album or taking photo by camera
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
        photoHaveBeenUpdated = true
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
        photoHaveBeenUpdated = true
    }
    
    //When "Add/Update" button is pressed
    @objc func addUpdateButtonPressed(_ sender: UIButton!) {
        //Check first name and handle error
        let firstName = firstNameTextView.text!
        if (firstName == "") {
            resultLabelView.text = "Please fill in \"First:\" before add/update."
            return
        }
        
        //Check last name and handle error
        let lastName = lastNameTextView.text!
        if (lastName == "") {
            resultLabelView.text = "Please fill in \"Last:\"  before add/update."
            return
        }
        
        //Check gender and handle error
        let genderText = genderTextView.text
        if (genderText == "") {
            resultLabelView.text = "Please choose \"Gender:\" before add/update."
            return
        }
        var gender: Gender = .Male
        var photo: UIImage
        if genderText == "Female" {
            gender = .Female
            photo = UIImage(named: "Female")!
        } else {
            gender = .Male
            photo = UIImage(named: "Male")!
        }
        
        //Check role and handle error
        let roleText = roleTextView.text
        var role: DukeRole = .Student
        if (roleText == "") {
             resultLabelView.text = "Please choose \"Role:\" before add/update."
             return
        }
        if roleText == "TA" {
            role = .TA
        } else if roleText == "Professor" {
            role = .Professor
        } else {
            role = .Student
        }
        
        //Check where from and handle error
        let whereFrom = fromTextView.text!
        if (whereFrom == "") {
            resultLabelView.text = "Please fill in \"From:\" before add/update."
            return
        }
        
        //Check degree and handle error
        let degree = degreeTextView.text!
        if (degree == "") {
            resultLabelView.text = "Please choose \"Degree:\" before add/update."
            return
        }
        
        //Check hobbies and handle error
        let hobbiesText = hobbiesTextView.text!
        if (hobbiesText == "") {
            resultLabelView.text = "Please fill in \"Hobbies:\" before add/update."
            return
        }
        let hobbies: [String] = hobbiesText.components(separatedBy: ",")
        if hobbies.count > 3 {
            resultLabelView.text = "Hobbies: Up to 3 hobbies."
            return
        }
        
        //Check languages and handle error
        let languagesText = languagesTextView.text!
        if (languagesText == "") {
            resultLabelView.text = "Please fill in \"Languages:\" before add/update."
            return
        }
        let languages: [String] = languagesText.components(separatedBy: ",")
        if languages.count > 3 {
            resultLabelView.text = "Languages: Up to 3 languages."
            return
        }
        
        let newDukePerson = DukePerson(firstName: firstName,
                                       lastName: lastName,
                                       whereFrom: whereFrom,
                                       gender: gender,
                                       hobbies: hobbies,
                                       role: role,
                                       degree: degree,
                                       languages: languages,
                                       photo: photo
                                       )
        //If the person is already in the database, update
        for i in 0 ..< dukePersons.count {
            if checkPersonEqual(dukePersons[i], newDukePerson) {
                resultLabelView.text = "\(firstName) \(lastName) already exists in the database, nothing changed."
                resetForm()
                return
            }
            
            if dukePersons[i].firstName == firstName && dukePersons[i].lastName == lastName {
                if photoHaveBeenUpdated {
                    newDukePerson.photo = photoView.image
                }
                dukePersons[i] = newDukePerson
                resultLabelView.text = "\(firstName) \(lastName) has been Updated in the database."
                resetForm()
                return
            }
        }
        
        if photoHaveBeenUpdated {
            newDukePerson.photo = photoView.image
        }
        //If the person is not in the database, add
        dukePersons.append(newDukePerson)
        resultLabelView.text = "\(firstName) \(lastName)  has been Added to the database."
        resetForm()
    }
    
    
    func checkPersonEqual(_ objl: DukePerson, _ objr: DukePerson) -> Bool{
        if objl.firstName == objr.firstName && objl.lastName == objr.lastName
            && objl.whereFrom == objr.whereFrom && objl.gender == objr.gender
            && objl.hobbies == objr.hobbies && objl.languages == objr.languages
            && objl.degree == objr.degree && objl.role == objr.role {
            return true
        }
        return false
    }
    

    //When "Find" button is pressed
    @objc func findButtonPressed(_ sender: UIButton!) {
        let fullName = firstNameTextView.text! + " " + lastNameTextView.text!
        resultLabelView.text = find(fullName)
        resetForm()
    }
    

    func find(_ filter: String) -> String {
        if photoIsDisplayed {
            photoView.image = UIImage(named: "No photo")
            photoIsDisplayed = false
        }
        
        let filters = filter.components(separatedBy: " ")
        if filters.count != 2 {
             return "Please enter first name and last name by one word."
        }
        
        let firstName = filters[0]
        let lastName = filters[1]
        if firstName.isEmpty && lastName.isEmpty {
             return "Please enter first name and/or last name."
        }
        
        var findResults = [DukePerson]()
        if !firstName.isEmpty {
            if !lastName.isEmpty {
                findResults = dukePersons.filter { (p: DukePerson) -> Bool in return p.firstName == firstName && p.lastName == lastName }
            } else {
                findResults = dukePersons.filter { (p: DukePerson) -> Bool in return p.firstName == firstName || p.lastName == firstName }
            }
        } else {
            findResults = dukePersons.filter { (p: DukePerson) -> Bool in return p.lastName == lastName }
        }

        if findResults.isEmpty {
            return "Person Not Found."
        } else {
            var photo: UIImage
            // priority level: photo in object > stored photo > male or female photo
            if findResults[0].photo != nil {
                photo = findResults[0].photo
            } else if let image = UIImage(named: findResults[0].firstName + " " + findResults[0].lastName) {
                photo = image
            } else {
                photo = (findResults[0].gender == .Male ? UIImage(named: "Male") : UIImage(named: "Female"))!
            }
            photoView.image = photo
            photoIsDisplayed = true
        }

        var resultString = ""
        for result in findResults {
            resultString += result.description
        }

        return resultString
    }
    
    
    //Clear the form
    func resetForm() {
        firstNameTextView.text?.removeAll()
        lastNameTextView.text?.removeAll()
        genderTextView.text?.removeAll()
        roleTextView.text?.removeAll()
        fromTextView.text?.removeAll()
        degreeTextView.text?.removeAll()
        hobbiesTextView.text?.removeAll()
        languagesTextView.text?.removeAll()
        
        genderPickerView.selectRow(0, inComponent: 0, animated: true)
        rolePickerView.selectRow(0, inComponent: 0, animated: true)
        degreePickerView.selectRow(0, inComponent: 0, animated: true)
        
        if !photoIsDisplayed {
            photoView.image = UIImage(named: "No photo")
        }
        // reset image
        photoIsDisplayed = false
    }
}



//MARK: - imagePicker delegate calls
extension ViewController:  UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePickerController.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        photoView.image = image
    }
    
}


//MARK: - UIPickerView delegate calls
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
            genderTextView.text = genders[row]
        } else if pickerView.tag == 2 {
            roleTextView.text = roles[row]
        } else if pickerView.tag == 3 {
            degreeTextView.text = degrees[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = (view as? UILabel) ?? UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "ArialHebrew", size: 18)
        
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



//MARK: - Extension of UITextField
extension UITextField {
    /* Create space at the beginning of a UITextField
     Reference: https://stackoverflow.com/questions/25367502/create-space-at-the-beginning-of-a-uitextfield*/
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}



//MARK: - Dismiss keyboard
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        /* Dismiss keyboard by touching anywhere
         Reference: https://stackoverflow.com/questions/24126678/close-ios-keyboard-by-touching-anywhere-using-swift
         */
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
}
