//
//  DukePerson.swift
//  ECE564_HOMEWORK
//
//  Created by Nan Ni on 1/25/20.
//  Copyright © 2020 ECE564. All rights reserved.
//

import Foundation
import UIKit

enum Gender {
    case Male
    case Female
}

class Person {
    var firstName = "First"
    var lastName = "Last"
    var whereFrom = "Anywhere"  // this is just a free String - can be city, state, both, etc.
    var gender : Gender = .Male
}

enum DukeRole : String {
    case Student = "Student"
    case Professor = "Professor"
    case TA = "Teaching Assistant"
}

protocol ECE564 {
    var hobbies : [String] { get }
    var role : DukeRole { get }
    var degree : String { get }
    var languages : [String] {get}
    var picture: String? {get}  // we will use in future HW
    var team: String? {get} // we will use in future HW
    var netid: String? {get} // we will use in future HW
    var email: String? {get} // we will use in future HW
    var department: String? {get} // we will use in future HW
    var id: String? {get} // we will use in future HW
}

extension ECE564 {
    var picture: String? {return nil}
    var team: String? {return nil}
    var netid: String? {return nil}
    var email: String? {return nil}
    var department: String? {return nil}
    var id: String? {return nil}
}

class DukePerson: Person, ECE564, CustomStringConvertible {

    var hobbies: [String] = []
    var role: DukeRole = .Student
    var degree: String = ""
    var languages: [String] = []
    var photo: UIImage!
    
    //Override team property
    var t: String = ""
    var team: String? {
        get {
            return t
        }
        set {
            self.t = newValue!
        }
    }

    var description: String {
        let firstSentence = firstName + " " + lastName + " is from " + whereFrom + " and is a " + role.rawValue.lowercased() + ". "
        let secondSentence = (gender == Gender.Male ? "He" : "She") + " is proficient in " + languages.joined(separator: ", ") + ". "
        let thirdSentence = "When not in class, " + firstName + " enjoys " + hobbies.joined(separator: ", ") + ". \n"

        let outputString = firstSentence + secondSentence + thirdSentence

        return outputString
    }

    init(firstName: String,
         lastName: String,
         whereFrom: String,
         gender: Gender,
         hobbies : [String],
         role : DukeRole,
         degree : String,
         languages : [String],
         photo: UIImage) {
        super.init()
        self.firstName = firstName
        self.lastName = lastName
        self.whereFrom = whereFrom
        self.gender = gender
        self.hobbies = hobbies
        self.role = role
        self.degree = degree
        self.languages = languages
        self.photo = photo
    }
    
    override init() {
        super.init()
    }
}

struct DukePersonSection {
    var name: String
    var dukePersons: [DukePerson]
    var collapsed: Bool
    
    public init(name: String, dukePersons: [DukePerson], collapsed: Bool = false) {
        self.name = name
        self.dukePersons = dukePersons
        self.collapsed = collapsed
    }
}


let Ric: DukePerson = DukePerson(firstName: "Ric",
                                 lastName: "Telford",
                                 whereFrom: "US",
                                 gender: .Male,
                                 hobbies: ["Swimming", "Biking", "Hiking"],
                                 role: .Professor, degree: "BS",
                                 languages: ["Swift", "C", "C++"],
                                 photo: UIImage(named: "Ric Telford") ?? UIImage())
let Jingru: DukePerson = DukePerson(firstName: "Jingru",
                                    lastName: "Gao",
                                    whereFrom: "CN",
                                    gender: .Female,
                                    hobbies: ["Traveling", "Reading", "Movies"],
                                    role: .TA, degree: "MS",
                                    languages: ["Swift", "C++", "Python"],
                                    photo: UIImage(named: "Jingru Gao") ?? UIImage())
let Haohong: DukePerson = DukePerson(firstName: "Haohong",
                                     lastName: "Zhao",
                                     whereFrom: "CN",
                                     gender: .Male,
                                     hobbies: ["Reading", "Jogging"],
                                     role: .TA, degree: "MS",
                                     languages: ["Swift","Python"],
                                     photo: UIImage(named: "Haohong Zhao") ?? UIImage())
let Nan: DukePerson = DukePerson(firstName: "Nan",
                                 lastName: "Ni",
                                 whereFrom: "CN",
                                 gender: .Female,
                                 hobbies: ["Traveling", "Playing online games", "Cardio workout"],
                                 role: .Student, degree: "MS",
                                 languages: ["C", "C++", "Swift"],
                                 photo: UIImage(named: "Nan Ni") ?? UIImage())

var dukePersonsArray = [Ric, Jingru, Haohong, Nan]

//
// priority level: photo in object > stored photo
//
func getPhoto(_ person: DukePerson) -> UIImage {
    if person.photo != nil {
        return (person.photo)!
    } else if let image = UIImage(named: person.firstName + " " + person.lastName) {
        return image
    } else {
        return UIImage()
    }
}


