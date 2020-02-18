//
//  PersonTableViewController.swift
//  ECE564_HOMEWORK
//
//  Created by Nan Ni on 1/31/20.
//  Copyright © 2020 ECE564. All rights reserved.
//

import UIKit

class PersonTableViewController: UITableViewController {
    
    @IBOutlet var personTableView: UITableView!
    
    //Pass to InformationViewController as a reference
    var selectedPerson: DukePerson?
    var newPerson = DukePerson()
    
    var dukePersonsSection: [DukePersonSection] = [
        DukePersonSection(name: "Professor", dukePersons: []),
        DukePersonSection(name: "TA", dukePersons: []),
        DukePersonSection(name: "Student", dukePersons: []),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        loadDukePersonSections()
        
        personTableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        personTableView.dataSource = self
    }
    
    //
    //Add persons in flat array to section
    //
    func loadDukePersonSections() {
        for i in 0 ..< dukePersonsSection.count {
            if dukePersonsSection[i].name == "Professor" || dukePersonsSection[i].name == "TA" || dukePersonsSection[i].name == "Student" {
                dukePersonsSection[i].dukePersons.removeAll()
            } else {
                dukePersonsSection.remove(at: i)
            }
        }
        for person in dukePersonsArray {
            appendPersonToSection(person)
        }
    }
    
    func appendPersonToSection(_ person: DukePerson) {
        if person.role == .Professor {
            dukePersonsSection[0].dukePersons.append(person)
        } else if person.role == .TA {
            dukePersonsSection[1].dukePersons.append(person)
        } else if person.role == .Student {
            let teamName = person.team
            if teamName == "" {        //If the team name is empty,add to Student
                dukePersonsSection[2].dukePersons.append(person)
            } else {
                var teamExist = false
                for i in 0 ..< dukePersonsSection.count {
                    if dukePersonsSection[i].name == teamName {
                        dukePersonsSection[i].dukePersons.append(person)
                        teamExist = true
                    }
                }
                if teamExist == false {
                    dukePersonsSection.append(DukePersonSection(name: teamName!, dukePersons: [person]))
                }
            }
        }
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case K.editSegue:
                let informationVC = segue.destination as! InformationViewController
                informationVC.mode = .Displaying
                informationVC.person = selectedPerson!
                if selectedPerson?.role == .Professor || selectedPerson?.role == .TA {
                    informationVC.teamHide = true
                }
            case K.addSegue:
                let informationVC = segue.destination as! InformationViewController
                informationVC.mode = .Adding
                newPerson = DukePerson() //Important! Create a new person
                informationVC.person = newPerson
                informationVC.teamHide = true
            default:
                print("Error: prepare segue")
            }
        }
    }
    
    @IBAction func returnFromInformationView(segue: UIStoryboardSegue) {
        let source: InformationViewController = segue.source as! InformationViewController
        if source.mode == .Adding {
            if source.cancelButtonPressed {
                loadDukePersonSections()
            } else {
                dukePersonsArray.append(newPerson)
                appendPersonToSection(newPerson)
            }
        } else if source.mode == .Displaying {
            loadDukePersonSections()
        }
        self.tableView.reloadData()
    }
}


// MARK: - Table view data source

extension PersonTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return dukePersonsSection.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dukePersonsSection[section].collapsed {
            return dukePersonsSection[section].dukePersons.count == 0 ? 0 : 1
        } else {
            return dukePersonsSection[section].dukePersons.count
        }
    }
    
    //For cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if dukePersonsSection[indexPath.section].collapsed || dukePersonsSection[indexPath.section].dukePersons.count == 0 {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! PersonTableViewCell
        
        cell.personInCell = dukePersonsSection[indexPath.section].dukePersons[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPerson = dukePersonsSection[indexPath.section].dukePersons[indexPath.row]
        performSegue(withIdentifier: K.editSegue, sender: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if dukePersonsSection[indexPath.section].collapsed || dukePersonsSection[indexPath.section].dukePersons.count == 0 {
            return 0.0
        }
        return UITableView.automaticDimension
    }

    
    //For header
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: K.headerIdentifier) as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: K.headerIdentifier)
        
        header.titleLabel.text = dukePersonsSection[section].name
        header.arrowLabel.text = ">"
        header.setCollapsed(dukePersonsSection[section].collapsed)
        
        header.section = section
        header.delegate = self
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35.0
    }
    
    //For swipe
    override func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let modifyAction = UIContextualAction(style: .normal, title:  "Edit", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            self.selectedPerson = self.dukePersonsSection[indexPath.section].dukePersons[indexPath.row]
            self.performSegue(withIdentifier: K.editSegue, sender: indexPath)
            success(true)
        })
        modifyAction.backgroundColor = UIColor(named: K.BrandColors.gray)
        modifyAction.image = UIImage(named: "Edit")

        let deleteAction = UIContextualAction(style: .normal, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            let personToDelete = self.dukePersonsSection[indexPath.section].dukePersons[indexPath.row]
            self.dukePersonsSection[indexPath.section].dukePersons.remove(at: indexPath.row)
            dukePersonsArray.removeAll{ $0.firstName == personToDelete.firstName && $0.lastName == personToDelete.lastName}
            tableView.deleteRows(at: [indexPath], with: .automatic)
            success(true)
        })
        deleteAction.backgroundColor = UIColor.red
        deleteAction.image = UIImage(named: "Delete")

        return UISwipeActionsConfiguration(actions: [deleteAction, modifyAction])
    }


}


// MARK: - Section Header Delegate

extension PersonTableViewController: CollapsibleTableViewHeaderDelegate {
    
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
        let collapsed = !dukePersonsSection[section].collapsed
        
        // Toggle collapse
        dukePersonsSection[section].collapsed = collapsed
        header.setCollapsed(collapsed)
        
        tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
    }
    
}

