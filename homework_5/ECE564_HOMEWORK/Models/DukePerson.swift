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
    case TA = "TA"
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

var databasePath = NSString()
var dukePersonsArray = [DukePerson]()

class DukePerson: Person, ECE564, CustomStringConvertible {
    
    var hobbies: [String] = []
    var role: DukeRole = .Student
    var degree: String = ""
    var languages: [String] = []
    var team: String?
    var picture: String = ""
    
    override init() {
        super.init()
    }
    
    init(firstName: String,
         lastName: String,
         whereFrom: String,
         gender: Gender,
         hobbies : [String],
         role : DukeRole,
         degree : String,
         languages : [String],
         team: String,
         picture: String) {
        super.init()
        self.firstName = firstName
        self.lastName = lastName
        self.whereFrom = whereFrom
        self.gender = gender
        self.hobbies = hobbies
        self.role = role
        self.degree = degree
        self.languages = languages
        self.picture = picture
        self.team = team
    }
    
    var description: String {
        let firstSentence = firstName + " " + lastName + " is from " + whereFrom + " and is a " + role.rawValue.lowercased() + ". "
        let secondSentence = (gender == Gender.Male ? "He" : "She") + " is proficient in " + languages.joined(separator: ", ") + ". "
        let thirdSentence = "When not in class, " + firstName + " enjoys " + hobbies.joined(separator: ", ") + ". \n"
        
        var outputString = firstSentence
        if languages[0] != "" {
            outputString += secondSentence
        }
        if hobbies[0] != "" {
            outputString += thirdSentence
        }
        return outputString
    }
}

/**
 To display in sections
 */
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

let RicTelford: DukePerson = DukePerson(firstName: "Ric",
                                 lastName: "Telford",
                                 whereFrom: "US",
                                 gender: .Male,
                                 hobbies: ["Swimming", "Biking", "Hiking"],
                                 role: .Professor,
                                 degree: "BS",
                                 languages: ["Swift", "C", "C++"],
                                 team: "",
                                 picture: UIImage(named: "Ric Telford")?.resizeImage(resize: K.photoSize).scaleImage(scaleSize: K.scaleSize).base64ToString() ?? "")

let JingruGao: DukePerson = DukePerson(firstName: "Jingru",
                                    lastName: "Gao",
                                    whereFrom: "CN",
                                    gender: .Female,
                                    hobbies: ["Traveling", "Reading", "Movies"],
                                    role: .TA,
                                    degree: "MS",
                                    languages: ["Swift", "C++", "Python"],
                                    team: "",
                                    picture: UIImage(named: "Jingru Gao")?.resizeImage(resize: K.photoSize).scaleImage(scaleSize: K.scaleSize).base64ToString() ?? "")

let HaohongZhao: DukePerson = DukePerson(firstName: "Haohong",
                                     lastName: "Zhao",
                                     whereFrom: "CN",
                                     gender: .Male,
                                     hobbies: ["Reading", "Jogging"],
                                     role: .TA,
                                     degree: "MS",
                                     languages: ["Swift","Python"],
                                     team: "",
                                     picture: UIImage(named: "Haohong Zhao")?.resizeImage(resize: K.photoSize).scaleImage(scaleSize: K.scaleSize).base64ToString() ?? "")

let NanNi: DukePerson = DukePerson(firstName: "Nan",
                                 lastName: "Ni",
                                 whereFrom: "CN",
                                 gender: .Female,
                                 hobbies: ["Traveling", "Playing online games", "Cardio workout"],
                                 role: .Student,
                                 degree: "MS",
                                 languages: ["C", "C++", "Swift"],
                                 team: "HFTP",
                                 picture: UIImage(named: "Nan Ni")?.resizeImage(resize: K.photoSize).scaleImage(scaleSize: K.scaleSize).base64ToString() ?? "")

let NiboYing: DukePerson = DukePerson(firstName: "Nibo",
                                      lastName: "Ying",
                                      whereFrom: "CN",
                                      gender: .Male,
                                      hobbies: ["Basketball"],
                                      role: .Student,
                                      degree: "MS",
                                      languages: ["C++", "Swift"],
                                      team: "HFTP",
                                      picture: UIImage(named: "Nibo Ying")?.resizeImage(resize: K.photoSize).scaleImage(scaleSize: K.scaleSize).base64ToString() ?? "")

let ZihuiZheng: DukePerson = DukePerson(firstName: "Zihui",
                                        lastName: "Zheng",
                                        whereFrom: "CN",
                                        gender: .Male,
                                        hobbies: ["Video games", "Workout", "Basketball"],
                                        role: .Student,
                                        degree: "MS",
                                        languages: ["C++", "Scala", "Swift"],
                                        team: "HFTP",
                                        picture: UIImage(named: "Zihui Zheng")?.resizeImage(resize: K.photoSize).scaleImage(scaleSize: K.scaleSize).base64ToString() ?? "")

let KaiWang: DukePerson = DukePerson(firstName: "Kai",
                                     lastName: "Wang",
                                     whereFrom: "CN",
                                     gender: .Male,
                                     hobbies: ["Traveling", "Playing online games", "Cardio workout"],
                                     role: .Student,
                                     degree: "MS",
                                     languages: ["C++", "Swift"],
                                     team: "HFTP",
                                     picture: UIImage(named: "Kai Wang")?.resizeImage(resize: K.photoSize).scaleImage(scaleSize: K.scaleSize).base64ToString() ?? "")

//MARK: - Tool For Json [String]
func convertJSONStringFromArray(_ arr: NSArray) -> String {
    
    if (!JSONSerialization.isValidJSONObject(arr)) {
        print("Cannot convert array into string!")
        return ""
    }
    let data : NSData! = try? JSONSerialization.data(withJSONObject: arr, options: []) as NSData?
    let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
    return JSONString! as String
}

//MARK: - Tool For [String] Json
func convertArrayFromJSONString(_ jsonStr: String) -> NSArray {
    let jsonData:Data = jsonStr.data(using: .utf8)!
    let arr = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
    if arr != nil {
        return arr as! NSArray
    }
    return arr as! NSArray
}
