import UIKit
/*:
 ### ECE 564 HW1 assignment - Please see Sakai Assignment "HW1" for detailed instructions on what is expected in this Assignment.
 In this first assignment, you are going to create a base data model for storing information about the Students, TAs and Professor in ECE 564. You need to populate your data model with at least 4 records (you, the Professor, 2 TAs), but can add more.  You will also provide a search function ("find") to search an array of those objects.
 */
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
//: ### START OF HOMEWORK
//: Do not change anything above.
//: Put your code here:




/*
 - Data model for the Students, TAs and Professor in this class
 - Store information about each person
*/
class DukePerson: Person, ECE564, CustomStringConvertible {
    
    var hobbies: [String] = []
    var role: DukeRole = .Student
    var degree: String = ""
    var languages: [String] = []
    
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
         languages : [String]) {
        super.init()
        self.firstName = firstName
        self.lastName = lastName
        self.whereFrom = whereFrom
        self.gender = gender
        self.hobbies = hobbies
        self.role = role
        self.degree = degree
        self.languages = languages
    }
}

//Data model for searching
class ItemsToFind {
    var firstName: String = ""
    var lastName: String = ""
    var whereFrom: String = ""
    var degree: String = ""
}


//Create an array of DukePerson and add people to it
var dukePersons = [DukePerson]()

let Ric: DukePerson = DukePerson(firstName: "Ric", lastName: "Telford", whereFrom: "US", gender: .Male, hobbies: ["Swimming", "Biking", "Hiking"], role: .Professor, degree: "BS", languages: ["Swift", "C", "C++"])
let Nan: DukePerson = DukePerson(firstName: "Nan", lastName: "Ni", whereFrom: "CN", gender: .Female, hobbies: ["Traveling", "Playing online games", "Cardio workout"], role: .Student, degree: "MS", languages: ["C", "C++", "Swift"])
let Nan2: DukePerson = DukePerson(firstName: "Nan", lastName: "Ni", whereFrom: "CN", gender: .Female, hobbies: ["Only computer games"], role: .Student, degree: "MS", languages: ["C", "C++", "Swift"])
let Jingru: DukePerson = DukePerson(firstName: "Jingru", lastName: "Gao", whereFrom: "CN", gender: .Female, hobbies: ["Traveling", "Reading", "Movies"], role: .TA, degree: "MS", languages: ["Swift", "C++", "Python"])
let Haohong: DukePerson = DukePerson(firstName: "Haohong", lastName: "Zhao", whereFrom: "CN", gender: .Male, hobbies: ["Reading", "Jogging"], role: .TA, degree: "MS", languages: ["Swift","Python"])

dukePersons.append(Ric)
dukePersons.append(Nan)
dukePersons.append(Jingru)
dukePersons.append(Haohong)



/*
 - Functionality: search database and retrieve matching information
 - Input(String): search condition
 - Output(String): full description of the person
 - Error cases: "Bad Input Format" and "Person Not Found"
 */
func find(_ filter: String) -> String {
    let itemsToFind = ItemsToFind()
    if !parseParameters(filter, itemsToFind) {
        return "Bad Input Format, Usage:/n name /w where /d degree\n"
    }
    
    var findResults = [DukePerson]()
    var haveBeenFiltered = false
    
    if !itemsToFind.firstName.isEmpty {
        if !itemsToFind.lastName.isEmpty {
            findResults = dukePersons.filter { (p: DukePerson) -> Bool in return p.firstName == itemsToFind.firstName && p.lastName == itemsToFind.lastName }
            haveBeenFiltered = true
        } else {
            findResults = dukePersons.filter { (p: DukePerson) -> Bool in return p.firstName == itemsToFind.firstName || p.lastName == itemsToFind.firstName }
            haveBeenFiltered = true
        }
    }
    if !itemsToFind.whereFrom.isEmpty {
        let arrayForSearch = findResults.isEmpty && !haveBeenFiltered ? dukePersons : findResults
        findResults = arrayForSearch.filter { (p: DukePerson) -> Bool in return p.whereFrom == itemsToFind.whereFrom }
        haveBeenFiltered = true
    }
    if !itemsToFind.degree.isEmpty {
        let arrayForSearch = findResults.isEmpty && !haveBeenFiltered ? dukePersons : findResults
        findResults = arrayForSearch.filter { (p: DukePerson) -> Bool in return p.degree == itemsToFind.degree }
    }
    
    if findResults.isEmpty {
        return "Person Not Found. \n"
    }
    
    var resultString = ""
    for result in findResults {
        resultString += result.description
    }
    
    return resultString
}


/*
- Functionality: parse search condition
- Input(String, ItemsToFind): search condition, data model of search
- Output(Output): whether the input is valid
- Error cases: Listed in the section below -- "Testcases_3 For Function: parseParameters"
*/
func parseParameters(_ filter: String, _ itemsToFind: ItemsToFind) -> Bool {
    let filters = filter.components(separatedBy: " ")
    
    var left = 0
    var right = 0
    while left < filters.count {
        right += 1
        if right == filters.count || filters[right] == "/n" || filters[right] == "/w" || filters[right] == "/d" {
            if filters[left] == "/n" {
                if right - left == 3 {
                    itemsToFind.firstName = filters[left + 1]
                    itemsToFind.lastName = filters[left + 2]
                } else if right - left == 2 {
                    itemsToFind.firstName = filters[left + 1]
                } else {
                    return false
                }
            } else if filters[left] == "/w" {
                if right - left == 2 {
                    itemsToFind.whereFrom = filters[left + 1]
                } else {
                    return false
                }
            } else if filters[left] == "/d" {
                if right - left == 2 {
                    itemsToFind.degree = filters[left + 1]
                } else {
                    return false
                }
            } else {
                return false
            }
            left = right
        }
    }
    return true
}





//: ### END OF HOMEWORK
/*:
 The **signature** for the `find` function should be defined as
    
 `func find(_ parmString: String) -> String {   }`
 
 Below is an example of what the string output from `find` should look like:
 
 `(firstName lastName) is from (whereFrom) and is a (role). (correct gender) is proficient in (languages). When not in class, (firstName) enjoys (hobbies).`
 */
//: Uncomment the line below to test your homework.
//print(find("/n Jingru Gao"))



//MARK: - Testcases_1 For Basic Function: Search by firstname or fullname
print(find("/n Ric"))
/* Result:
 Ric Telford is from US and is a professor. He is proficient in Swift, C, C++. When not in class, Ric enjoys Swimming, Biking, Hiking.
 */


print(find("/n Telford"))
/* Result:
 Ric Telford is from US and is a professor. He is proficient in Swift, C, C++. When not in class, Ric enjoys Swimming, Biking, Hiking.
 */


print(find("/n Ric Telford"))
/* Result:
 Ric Telford is from US and is a professor. He is proficient in Swift, C, C++. When not in class, Ric enjoys Swimming, Biking, Hiking.
 */

print(find("/n Rich"))
/* Result:
 Person Not Found.
*/



//MARK: - Testcases_2 For Advanced Function: Search by different items
print(find("/n Nan"))
/* Result:
 Nan Ni is from CN and is a student. She is proficient in C, C++, Swift. When not in class, Nan enjoys Traveling, Playing online games, Cardio workout.
 */


print(find("/w CN"))
/* Result:
 Nan Ni is from CN and is a student. She is proficient in C, C++, Swift. When not in class, Nan enjoys Traveling, Playing online games, Cardio workout.
 Jingru Gao is from CN and is a teaching assistant. She is proficient in Swift, C++, Python. When not in class, Jingru enjoys Traveling, Reading, Movies.
 Haohong Zhao is from CN and is a teaching assistant. He is proficient in Swift, Python. When not in class, Haohong enjoys Reading, Jogging.
 */


print(find("/d BS"))
/* Result:
 Ric Telford is from US and is a professor. He is proficient in Swift, C, C++. When not in class, Ric enjoys Swimming, Biking, Hiking.
 */


print(find("/w CN /d MS"))
/* Result:
Nan Ni is from CN and is a student. She is proficient in C, C++, Swift. When not in class, Nan enjoys Traveling, Playing online games, Cardio workout.
Jingru Gao is from CN and is a teaching assistant. She is proficient in Swift, C++, Python. When not in class, Jingru enjoys Traveling, Reading, Movies.
Haohong Zhao is from CN and is a teaching assistant. He is proficient in Swift, Python. When not in class, Haohong enjoys Reading, Jogging.
*/

print(find("/w CN /d MS /n Nan Ni"))
/* Result:
 Nan Ni is from CN and is a student. She is proficient in C, C++, Swift. When not in class, Nan enjoys Traveling, Playing online games, Cardio workout.
*/


print(find("/n Nan /w CN /d MS"))
/* Result:
 Nan Ni is from CN and is a student. She is proficient in C, C++, Swift. When not in class, Nan enjoys Traveling, Playing online games, Cardio workout.
*/


print(find("/w US /n Nan"))
/* Result:
 Person Not Found.
 */


print(find("/n Ric /w CN"))
/* Result:
 Person Not Found.
*/


print(find("/n Nan /w CN /d PHD"))
/* Result:
 Person Not Found.
*/


print(find("/n No /w CN"))
/* Result:
 Person Not Found.
*/


print(find("/w No /n Nan"))
/* Result:
 Person Not Found.
*/


dukePersons.append(Nan2)
print(find("/n Nan"))
/* Result:
 Nan Ni is from CN and is a student. She is proficient in C, C++, Swift. When not in class, Nan enjoys Traveling, Playing online games, Cardio workout.
 Nan Ni is from CN and is a student. She is proficient in C, C++, Swift. When not in class, Nan enjoys Only computer games.
 */



//MARK: - Testcases_3 For Function: parseParameters
print(find(""))
print(find("/n"))
print(find("/wNi"))
print(find("Nan Ni "))
print(find("Nan Ni /d MS"))
print(find("/n Nan /d"))
print(find("/n Nan /d MS "))
print(find("/n Nan  /d MS "))
/* Result of all testcases above:
 Bad Input Format, Usage:/n name /w where /d degree
 */
