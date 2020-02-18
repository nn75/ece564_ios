//
//  BaseSqlService.swift
//  ECE564_HOMEWORK
//
//  Created by Nan Ni on 2/10/20.
//  Copyright © 2020 ECE564. All rights reserved.
//

import Foundation
import UIKit

/**
 start sqlite and init data
 */
func initDukePersonDB() -> Bool {
    let filemgr = FileManager.default
    let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    var docsDir = NSString()
    var response = false
    docsDir = dirPaths[0] as NSString
    databasePath = docsDir.appendingPathComponent("DukePersonDBFile_nn75") as NSString
    
    if !filemgr.fileExists(atPath: databasePath as String) {
        let dukePersonDB = FMDatabase(path: databasePath as String)
        if dukePersonDB == nil {
            print("SQLError 0: \( String(describing: dukePersonDB?.lastErrorMessage()))")
            return response
        }
        /**
         create new table and init data
         */
        if (dukePersonDB?.open())! {
            let initSQL = "CREATE TABLE IF NOT EXISTS DUKEPERSON (ID INTEGER PRIMARY KEY AUTOINCREMENT, FIRSTNAME TEXT, LASTNAME TEXT, WHEREFROM TEXT, GENDER TEXT, HOBBIES TEXT, ROLE TEXT, DEGREE TEXT, LANGUAGES TEXT, PICTURE TEXT, TEAM TEXT)"
            if !(dukePersonDB?.executeStatements(initSQL))! {
                print("SQLError 1: \(String(describing: dukePersonDB?.lastErrorMessage()))")
                return response
            } else {
                let initPersons = [RicTelford, JingruGao, HaohongZhao, NanNi, NiboYing, ZihuiZheng, KaiWang]
                for person in initPersons {
                    let firstName = person.firstName
                    let lastName = person.lastName
                    let whereFrom = person.whereFrom
                    let gender = person.gender == .Male ? "Male": "Female"
                    let role = person.role.rawValue
                    let degree = person.degree
                    let languages = convertJSONStringFromArray(person.languages as NSArray)
                    let hobbies = convertJSONStringFromArray(person.hobbies as NSArray)
                    let picture = person.picture
                    let team = (person.role == .Student && person.team != nil && person.team != "") ? person.team! : ""
                    let insertSQL = "INSERT INTO DUKEPERSON (FIRSTNAME, LASTNAME, WHEREFROM, GENDER, HOBBIES, ROLE, DEGREE, LANGUAGES, PICTURE, TEAM) VALUES ('\(firstName)', '\(lastName)', '\(whereFrom)', '\(gender)', '\(hobbies)', '\(role)', '\(degree)', '\(languages)', '\(String(describing: picture)))', '\(String(describing: team))')"
                    let result = dukePersonDB?.executeUpdate(insertSQL, withArgumentsIn: nil)
                    if !result! {
                        print("SQLError 3: \(String(describing: dukePersonDB?.lastErrorMessage()))")
                        return response
                    } else {
                        print("SQLInfo: " + "\(person.firstName) \(person.lastName)" + " is inserted into db successfully!")
                    }
                }
            }
        } else {
            print("SQLError 2: \(String(describing: dukePersonDB?.lastErrorMessage()))")
            return response
        }
        print("SQLInfo: DukePersonDB init success!")
        dukePersonDB?.close()
    }
    response = true
    print("SQLInfo: DukePersonDB is running...\n")
    print("Path of DukePersonDBFile_nn75 is: \n" + (docsDir as String))
    return response
}


/**
 find all person
 */
func findAllFromDB() -> [DukePerson] {
    guard let dukePersonDB = FMDatabase(path: databasePath as String) else {
        print("SQLError 4: Unable to create DB")
        return []
    }
    guard dukePersonDB.open() else {
        print("SQLError 5: Unable to open DB")
        return []
    }
    let querySQL = "SELECT * FROM DUKEPERSON"
    let resultSet: FMResultSet! = dukePersonDB.executeQuery(querySQL, withArgumentsIn: nil)
    var personsFromDB = [DukePerson]()
    if (resultSet != nil) {
        while resultSet.next() {
            let person : DukePerson = DukePerson()
            person.firstName = resultSet.string(forColumn: "firstName")
            person.lastName = resultSet.string(forColumn:"lastName")
            person.whereFrom = resultSet.string(forColumn:"whereFrom")
            person.gender = resultSet.string(forColumn:"gender") == "Male" ? .Male : .Female
            person.degree = resultSet.string(forColumn:"degree")
            if !resultSet.string(forColumn:"team").isEmpty {
                person.team = resultSet.string(forColumn:"team")
            }
            person.hobbies = convertArrayFromJSONString(resultSet.string(forColumn:"hobbies")) as! [String]
            person.languages = convertArrayFromJSONString(resultSet.string(forColumn:"languages")) as! [String]
            if resultSet.string(forColumn:"role") == "TA" {
                person.role = .TA
            } else if resultSet.string(forColumn: "role") == "Professor" {
                person.role = .Professor
            } else if resultSet.string(forColumn: "role") == "Student" {
                person.role = .Student
            }
            person.picture = resultSet.string(forColumn:"picture")
            personsFromDB.append(person)
        }
    } else {
        print("SQLInfo: Cannot find any person from DB")
    }
    dukePersonDB.close()
    return personsFromDB
}

/**
 find one by firstName and lastName
 */
func findOneFromDB(_ firstName: String, _ lastName: String) -> DukePerson {
    guard let dukePersonDB = FMDatabase(path: databasePath as String) else {
        print("SQLError 4: Unable to create DB")
        return nil!
    }
    guard dukePersonDB.open() else {
        print("SQLError 5: Unable to open DB")
        return nil!
    }
    let querySQL = "SELECT * FROM DUKEPERSON WHERE FIRSTNAME = '\(firstName)' AND LASTNAME = '\(lastName)'"
    let resultSet: FMResultSet! = dukePersonDB.executeQuery(querySQL , withArgumentsIn: nil)
    let dukePerson: DukePerson = DukePerson()
    if resultSet?.next() == true {
        dukePerson.firstName = resultSet.string(forColumn: "firstName")
        dukePerson.lastName = resultSet.string(forColumn:"lastName")
        dukePerson.whereFrom = resultSet.string(forColumn:"whereFrom")
        dukePerson.gender = resultSet.string(forColumn:"gender") == "Male" ? .Male : .Female
        dukePerson.degree = resultSet.string(forColumn:"degree")
        if !resultSet.string(forColumn:"team").isEmpty {
            dukePerson.team = resultSet.string(forColumn:"team")
        }
        dukePerson.hobbies = convertArrayFromJSONString(resultSet.string(forColumn: "hobbies")) as! [String]
        dukePerson.languages = convertArrayFromJSONString(resultSet.string(forColumn: "languages")) as! [String]
        if resultSet.string(forColumn:"role") == "TA" {
            dukePerson.role = .TA
        } else if resultSet.string(forColumn: "role") == "Professor" {
            dukePerson.role = .Professor
        } else if resultSet.string(forColumn: "role") == "Student" {
            dukePerson.role = .Student
        }
        dukePerson.picture = resultSet.string(forColumn:"picture")
    } else {
        print("SQLInfo: No found!")
    }
    dukePersonDB.close()
    return dukePerson
}

/**
 insert one
 */
func insertDB(_ person: DukePerson) -> Bool {
    let dukePersonDB = FMDatabase(path: databasePath as String)
    var response = false
    if (dukePersonDB?.open())! {
        let firstName = person.firstName
        let lastName = person.lastName
        let whereFrom = person.whereFrom
        let gender = person.gender == .Male ? "Male": "Female"
        let role = person.role.rawValue
        let degree = person.degree
        let languages = convertJSONStringFromArray(person.languages as NSArray)
        let hobbies = convertJSONStringFromArray(person.hobbies as NSArray)
        let picture = !person.picture.isEmpty ? person.picture : UIImage(imageLiteralResourceName: "No photo").resizeImage(resize: K.photoSize).scaleImage(scaleSize: K.scaleSize).base64ToString()
        let team = (person.role == .Student && person.team != nil && person.team != "") ? person.team! : ""
        let insertSQL = "INSERT INTO DUKEPERSON (FIRSTNAME, LASTNAME, WHEREFROM, GENDER, HOBBIES, ROLE, DEGREE, LANGUAGES, PICTURE, TEAM) VALUES ('\(firstName)', '\(lastName)', '\(whereFrom)', '\(gender)', '\(hobbies)', '\(role)', '\(degree)', '\(languages)', '\(String(describing: picture))', '\(String(describing: team))')"
        let result = dukePersonDB?.executeUpdate(insertSQL, withArgumentsIn: nil)
        if !result! {
            print("SQLError 3: \(String(describing: dukePersonDB?.lastErrorMessage()))")
        } else {
            response = true
            print("SQLInfo: " + person.firstName + " is inserted into db successfully!")
        }
    } else {
        print("SQLError 3: \(String(describing: dukePersonDB?.lastErrorMessage()))")
    }
    dukePersonDB?.close()
    return response
}

/**
 delete one by firstName and lastName
 */
func deleteDB(_ firstName: String, _ lastName: String) -> Bool {
    let dukePersonDB = FMDatabase(path: databasePath as String)
    var response = false
    if (dukePersonDB?.open())! {
        let deleteSQL = "DELETE FROM DUKEPERSON WHERE FIRSTNAME = '\(firstName)' AND LASTNAME = '\(lastName)'"
        let result = dukePersonDB?.executeUpdate(deleteSQL, withArgumentsIn: nil)
        if !result! {
            print("SQLError 3: \(String(describing: dukePersonDB?.lastErrorMessage()))")
        } else {
            response = true
            print("SQLInfo: " + firstName + " " + lastName + " is deleted successfully!")
        }
    } else {
        print("SQLError 3: \(String(describing: dukePersonDB?.lastErrorMessage()))")
    }
    dukePersonDB?.close()
    return response
}


func updateDB(_ person: DukePerson) -> Bool {
    let dukePersonDB = FMDatabase(path: databasePath as String)
    var response = false
    if (dukePersonDB?.open())! {
        let firstName = person.firstName
        let lastName = person.lastName
        let whereFrom = person.whereFrom
        let gender = person.gender == .Male ? "Male": "Female"
        let role = person.role.rawValue
        let degree = person.degree
        let languages = convertJSONStringFromArray(person.languages as NSArray)
        let hobbies = convertJSONStringFromArray(person.hobbies as NSArray)
        let picture = person.picture
        let team = (person.role == .Student && person.team != nil && person.team != "") ? person.team! : ""
        let updateSQL = "UPDATE DUKEPERSON SET FIRSTNAME = '\(firstName)', LASTNAME = '\(lastName)', WHEREFROM = '\(whereFrom)', GENDER = '\(gender)', HOBBIES = '\(hobbies)', ROLE = '\(role)', DEGREE = '\(degree)', LANGUAGES = '\(languages)', PICTURE = '\(String(describing: picture))', TEAM = '\(String(describing: team))' WHERE FIRSTNAME = '\(firstName)' AND LASTNAME = '\(lastName)'"
        let result = dukePersonDB?.executeUpdate(updateSQL, withArgumentsIn: nil)
        if !result! {
            print("SQLError 3: \(String(describing: dukePersonDB?.lastErrorMessage()))")
        } else {
            response = true
            print("SQLInfo: " + person.firstName + " " + person.lastName + " is updated successfully!")
        }
    } else {
        print("SQLError 3: \(String(describing: dukePersonDB?.lastErrorMessage()))")
    }
    dukePersonDB?.close()
    return response
}
