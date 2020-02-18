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
### HW4 - 
### HW5 -
