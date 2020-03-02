//
//  PostMethod.swift
//  HftpHW6
//
//  Created by Zihui on 2/26/20.
//  Copyright © 2020 ECE564. All rights reserved.
//

import Foundation
import UIKit

//var session = URLSession(configuration: URLSessionConfiguration.ephemeral)
//var task : URLSessionTask!
var savePost = NSDictionary()

//MARK: REST post

/*** Input:
 *   currentPerson : the DukePerson object that has the same NetID as the authorized user
 *   vc: view controller of current page, will show error message if post fails
 *   This function upload the information of the Authorized user's entry
 ***/
func RESTPost(_ currentPerson: DukePerson, vc: UIViewController) {
    // POST body
    let postPerson = PostDukePerson(CurrentUserData!.netid!,person: currentPerson)
    //authentication information
    let username = CurrentUserData!.netid!
    let password = CurrentUserData!.password!
    let loginData = String(format: "%@:%@", username, password).data(using: String.Encoding.utf8)!
    let base64LoginData = loginData.base64EncodedString()
    
    let jsonEncoder = JSONEncoder()
    do{
        //create the request
        let postData = try jsonEncoder.encode(postPerson)
        let url = URL(string: "https://rt113-dt01.egr.duke.edu:5640/b64entries")!
        var request =  URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = postData
        // request headers
        request.setValue("Basic \(base64LoginData)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print(String(data: postData, encoding: String.Encoding.utf8)!)
        //making the request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("\(error!)")
                Alert.postFailedAlert(on: vc, message: "Cannot connect to the server")
                return
            }
            //receive response
            if let httpStatus = response as? HTTPURLResponse {
                // check status code returned by the http server
                print("status code = \(httpStatus.statusCode)")
                print(String.init(data: data, encoding: String.Encoding.utf8) as Any )
                // error status
                if httpStatus.statusCode >= 300{
                    Alert.postFailedAlert(on: vc, message: " \(String.init(data: data, encoding: String.Encoding.utf8)!)")
                }
            }
        }
        task.resume()
    }
    catch let error{
        print("error in POST: \(error)" )
    }
}

// use this class to format the JSON data to be sent to the webserver
class PostDukePerson: Codable{
    var id : String
    var netid : String
    var firstname : String
    var lastname : String
    var wherefrom : String
    var gender : String
    var role : String
    var degree : String
    var team : String
    var hobbies :[String]
    var languages : [String]
    var department : String
    var email : String
    var picture : String
    init(){
        id = ""
        netid = ""
        firstname = "first"
        lastname = "last"
        wherefrom = ""
        gender = ""
        role = ""
        degree = ""
        team = ""
        hobbies = []
        languages = []
        department = ""
        email = ""
        picture = ""
    }
    init(_ id: String, person: DukePerson){
        self.id = id
        self.netid = person.netid!
        self.firstname = person.firstName
        self.lastname = person.lastName
        self.wherefrom = person.whereFrom
        self.gender = person.gender.rawValue
        self.role = person.role.rawValue
        self.degree = person.degree
        self.team = person.team!
        self.hobbies = person.hobbies
        self.languages = person.languages
        self.department = person.department!
        self.email = person.email!
        self.picture = person.picture
    }
}
