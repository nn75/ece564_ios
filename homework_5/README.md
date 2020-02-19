#  ECE564_HOMEWORK
This is your README file - you need to add any info for each homework that you want to make sure we grade for extra function points.  
### HW1 -
#### 1. The required functionalities are all completed:
    (1) Pass it one string that starts with “/n” (for “name”) and is followed by either 1 or 2 words. 
        If there are 2 words after the “/n”, assume they are “firstName” followed by “lastName”.  
        If there is only 1 word after the “/n”, assume it is either “firstName” or “lastName”. 
        For example, find(“/n Ric Telford”) or find(“/n Telford”) or find(“/n Ric”). 
        Once a match is found, return the full description of the person formatted as shown in the playground file.
    (2) Handle all error cases.


#### 2. Functionalities for bonus points:
    The guide for how to test those funtionalities are in the HW1.playground.
    (1) Compact code, well-structured.
    (2) Interesting and/or broad use of Swift capabilities: eg. use filter function to search and find person.
    (3) Support for other search parameters in the string: /w for “whereFrom” and /d for “degree.
    (4) Support for multiple search parameters in the same string, such as “/n Telford /w NC”.
    (5) Returning all matches to the search parameters, not just the first one found.
    (6) The order of the search parameters can be arbitrary: eg. the results of “/n Telford /w NC” and “/w NC /n Telford” are the same.
    (7) Handle all error cases of bad input format.



### HW2 - 
#### 1. The required functionalities are all completed:
    (1) Add/Update – Save all the information entered in the screen.  Do some basic error checking.  If there is an exact match of the First Name / Last Name combination, then Update the information in the Data Model.  If there is no exact match, then Add the information to your Data Model.
    (2) Find - Work the same way as the find function in HW1.  Whatever is typed here would be treated as the String after the “/n” from your find function. The person's information will be displayed.
    (3) Put in a UIImageView rectangle as a placeholder for a picture. 
    (4) Do not use a Storyboard or. xib files and all done in code.

#### 2. Functionalities for bonus points
##### Important: The guide for how to test those funtionalities are in the Test Documentation, please click [here!!!](https://gitlab.oit.duke.edu/nn75/ece564_homework/blob/master/Test_Document/test_document.md).
    
    
    (1) Implement elegant picker control for Gender, Role and Degree. Use controls other than Text Field and Label.
    (2) Take photo or choose photo from album and save it with person.
    (3) Use UIScrollView and constraints to make layout fit every orientation of iPhone perfectly.
    (4) Use of elegant and fancy color, style.
    (5) Tigher code: DukePerson App can have a lot of repetitive code but I make it more concise..
    (6) Extensive Error Checking: There are 8 kinds of error checking and handling in App, which is listed in Test Documentation.
    


### HW3 - 
#### 1. The required functionalities are all completed:
    (1) Add person - Click on "+" button, present Information view to add a new “Person” to the class.
    (2) Create cell - Design my cell type for displaying the “Person” information.
    (3) Edit person - Click on cell, present Information view with person's information, click "Edit" to change, "Cancel" to cancel and "Save" to save.
    
#### 2. Functionalities for bonus points    
##### Important: The guide for how to test those funtionalities are in the Test Documentation, please click [here!!!](https://gitlab.oit.duke.edu/nn75/ece564_homework/blob/master/Test_Document/test_document.md).
    (1) Add Team Function - Add or move students to new team, delete students from the team, display team section on Table view.
    (2) Design clever code to implement collapsable section - The sections in Table view are collapsable, which makes it easier to find a person.
    (3) Add Swipe Actions To Table Cell - Swipe cell left to edit or delete person.
    (4) Add Camera / Photo Roll support - Take photo or choose photo from album and save it with person.
    (5) Creativeness in the design Table View and Cells - Design my cell in .xib file and register it to Table View
    (6) Advanced Picker control - If the text field is blank (when adding a new person), make the first option in the selection wheel as the default input. If the text field has an option (when editing a person already exists), make the selection wheel row to the same option.
    (7) Dismissable keyboard
    (8) Nicer looking layout: Use UIScrollView and constraints to make layout fit every orientation of iPhone perfectly. Use of elegant and fancy color, style.
    (6) Extensive Error Checking: The 8 kinds of error handling of previous assignments has been retained.


### HW4 - 
#### 1. The required functionalities are all completed:
    (1) Add page view, which can be flipped forward and back.
    (2) Enable and disable flipping according to hobby -- **Traveling**.
    (3) Add complex animation: complex vector graphic, CALayers, implicit animations, explicit animations, attributed text...
    
#### 2. Functionalities for bonus points
##### Important: The guide for how to test those funtionalities are in the Test Documentation, please click [here!!!](https://gitlab.oit.duke.edu/nn75/ece564_homework/blob/master/Test_Document/test_document.md).
    (1) Design interesting and elegant animation - The Animation View is well designed and works normally under repeated flips.
    (2) Complex vector graphics - Drawing sun
    (3) Implicit/Explicit layer animation - Drawing Prairie (CAGradientLayer, CAShapeLayer, CATextLayer and CALayer).
    (4) Add media - Add an African style song, it plays when Animation View loads and stops when Animation View disappears.
    (5) Add interactive animation - Press "Airplane" button to trigger animation of airplane and "Welcome to Africa!"
    (6) Add other cute animations - Add animations to display person's full name on Information View.
    
    

### **HW5 - **
#### 1. The required functionalities are all completed:
    (1) JSONEncoder/JSONDecoder support: Save and load the array of DukePerson to make it persists from session to session.
    (2) Team support:  In the Edit mode of the Information View, be able to prompt for Team name for the Person (which is an optional field). If a student does not have a team, leave it in the "Student" section. Add my teammates of "HFTP" team to default set of table entries that appear when user first bring up the app. On the Table View, sort students under Team Name cell, which is a separator cell that is called "HFTP".
    (3) Search support: Use both search bar text field and scope button to search all fields of person.
    (4) EditingStyle support: Swipe left to delete or edit person.
    (5) Picture support: Add an Image view to Table Cell to show pictures in the Table View. Add an Image view on the Information view for Nan Ni, my teammates, the TAs and the Professor. Add support for picking a picture from the camera roll to the Add view and the Edit view. Add support for the picture property (which is a string) in the ECE564 protocol to DukePerson.  Encode picture from UIImage to base64 string before JSON encoding and decode base64 string to UIImage for displaying after JSON decoding. Make sure the picture is not too big – keep it at 100 dpi and no bigger than 2x2 inches.
    
#### 2. Functionalities for bonus points
##### Important: The guide for how to test those funtionalities are in the Test Documentation, please click [here!!!](https://gitlab.oit.duke.edu/nn75/ece564_homework/blob/master/Test_Document/test_document.md).
    (1) More complex search: Use both search bar text field and scope button to search all fields of person.
    (3) More options on the “Swipe Left” or “Swipe Right” of a table entry.
    (4) Implement a different way to save/retrieve in addition to supporting JSONEncoder: SQL
    (6) Camera support to take pictures from the Add or Edit view: Use the right APIs to shrink the picture down to 100 dpi and 2x2 inches or less so they are not too big for JSONEncoder.

