# ECE564 HW4 DukePerson App Test Document

## **Basic Functions**

### **1. Add Page View**
- Step1: Press cell of "Nan Ni", navigate to **Information View**.
- Step2: Swipe left to flip the **Animation View**.
- Step3: Swip right to flip back to **Information View**.
- Detail1: You can always return back to Table View by dragging down the **Information View**.

<div align=center><img src="Sources/page_view.gif" width="20%" height="20%"></div>


### **2. Enable and disable flipping according to hobby -- Traveling**
- Introduction: Detect if the current Person has a hobby called **"Traveling"** or not, and disable "flipping" if there is no associated Drawing.
- Step1: Press cell of "Jingru Gao", the page view can be flipped because she likes **"Traveling"**.
- Step2: Press **"Back"** button to return to **Table View**, press cell of "Haohong Zhao", the page view **cannot** be flipped because he does not like **"Traveling"**.


### **3. Add Animation**
- Animation1: Draw sun and add curve movement to represent sunrise and sunset (**Explicit Animations, Vector graphic**).
- Animation2: Change the sky color with the orientation of the sun.
- Animation3: Draw clouds and add horizontal movement with different speed (**Implicit Animations**).
- Animation4: Draw Prairie with an Antelope whose tail is in rotation (**CALayer**).
- Animation5: Press "Airplane" button to trigger animation of airplane and "Welcome to Africa!" (**Attributed Text**). 

<div align=center><img src="Sources/animation_view.gif" width="20%" height="20%"></div>




## **Additional Functions**


### **1. Design interesting and elegant animation**
- The Animation View is well designed and works normally under repeated flips.

### **2. Complex vector graphics**
- Example1: Drawing sun

### **3. Implicit/Explicit layer animation**
- Example1: Drawing Prairie: I use CAGradientLayer, CAShapeLayer, CATextLayer and CALayer.

### **4. Add media**
- Media1: Add an African style song, it plays when **Animation View** loads and stops when **Animation View** disappears.
- Media2: Attributed text, for example, "Welcome to Africa!"

### **5. Add interactive animation**
- Example1: Press "Airplane" button to trigger animation of airplane and "Welcome to Africa!"

### **6. Add other cute animations**
- Add animations to display person's full name on **Information View**.

<div align=center><img src="Sources/name_animation.gif" width="20%" height="20%"></div>



