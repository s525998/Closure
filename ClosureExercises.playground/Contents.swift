import UIKit

// Answer each question in the space that follows it. Most of these questions involve closures, a few are just to test verify your knowledge of other subjects.


// 0. Write a Void function, fillIt(n:min:max:data:) with 4 parameters, n, min, max and data. The first 3 will be Ints, the 4th an [Int]. It will cause the 4th parameter to be filled with n Ints, between min and max inclusive, generated at random. Hint: For a parameter to changer its value, as data does, it must include a keyword that we talked about in the first 2 weeks or so of class.

func fillIt(n:Int, min:Int, max: Int, data: inout [Int]){
    var values: [Int] = []
    for _ in 0...n-1{
        values.append(Int.random(in: min...max))
    }
    data = values
}


// 1. Invoke fillIt() with values 15, 5, 10 -- and pass in data as well
var Datas: [Int] = []
fillIt(n:15, min:5, max:10, data:&Datas)


// 2. Create a struct, Mouse, with stored properties for x, y, and batteryLife, all Doubles. x and y can have any value, batteryLife should print a warning message if the value being assigned is outside the range 0.0-5.0 inclusive (hint: look at at the Restaurant class covered in class on 26 Feb). Mouse should adhere to the Equatable and CustomStringConvertible protocols. Two Mice are equal if they have the same property values. Implement CustomStringConvertible so it prints out a String that looks like the following (replace numbers with actual values, to 1 decimal, and use "Good" if battery life is at least 2.5, "Poor" otherwise:
//
//  Position: (5.0, 3.0), Battery Life: Good

struct Mouse: Equatable, CustomStringConvertible {
    var x : Double
    var y: Double
    var batteryLife: Double {
        willSet{
            if (newValue >= 0.0 && newValue <= 5.0){
                print("The battery lifes need to be between 0.0-5.0 inclusive")
            }
        
        }
    }
    //Two mice are equal and share same properties
    static func == (lhs: Mouse, rhs: Mouse) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.batteryLife == rhs.batteryLife
    }
    
    var description: String{
        var message:String = ""
        if (self.x.isNaN || self.y.isNaN || self.batteryLife.isNaN){
            message = "replace with actual values to 1 decimal"
            
        }
        else{return " "}
        return message
    }
}









// 3. Store three Mice in an array, cage (sorry, Mice). Make the first and third elements equal, with a batteryLife == 5.0, the middle one with a value 2.0


var mice1 = Mouse(x:15.6, y:-12.8, batteryLife: 5.0)
var mice2 = Mouse(x:-19.2, y: 13.1, batteryLife: 2.0)
var mice3 = Mouse(x:76.1, y: 42.8, batteryLife:5.0)

var cage:[Mouse] = [mice1, mice2, mice3]


// 4. See if cage contains a Mouse with the same values as cage[1] -- print out true if it does, false otherwise. Hint: Remember that arrays define the contains() method ... it's that easy!

for i in 0...cage.count-1{
    if (cage[i] == cage[1]){
        print("true")
    }
    else{
        print("False")
    }
}



// 5. Write a function, quadrant(mouse:) to return a String "NE", "NW", "SE", "SW" or "ON AXIS" depending on where a Mouse is positioned relative to the origin. (e.g., if it is in the top-right quadrant, return "NE"; top-left quadrant, "NW"; bottom-left quadrant, "SW"; bottom-right quadrant, "SE". [You have already done a question like this.]

func quadrant(_ mice:Mouse) -> String{
    if (mice.x == 0 && mice.y == 0){
        return "On AXIS"
    }
    else if(mice.x > 0 && mice.y > 0){
        return "NE"
    }
    else if (mice.x < 0 && mice.y > 0){
        return "NW"
    }
    else if (mice.x < 0 && mice.y < 0){
        return "SW"
    }
    else{
        return "SE"
    }
}

// 6. Assign new values to cage so its first Mouse is in NE, second in NW, third in SW, fourth in SE and 5th on an axis

var mouse4 = Mouse(x:23.1, y:5.4, batteryLife:3.2)
var mouse5 = Mouse(x: -90.0, y: 78.2, batteryLife: 2.9)
var mouse6 = Mouse(x: -45.6, y: -12.6, batteryLife: 1.8)
var mouse7 = Mouse(x: 38.5, y: -3.1, batteryLife: 2.6)
var mouse8 = Mouse(x: 0, y: 0, batteryLife: 2.1)

cage += [mouse4,mouse5, mouse6, mouse7, mouse8]



// 7. Map cage using quadrant, and print out the resulting array. [Hint: look at the map() function examples that you did in class on 28 Feb]

var quad:[String] = []
quad = cage.map({ (mice:Mouse) -> String in return quadrant(mice)})

print(quad)


// 8. Sort the elements of cage in increasing order of batteryLife, and print out the result. [Hint: See the sort(by:) example done in class on 28 Feb]

cage.sort(by: {$0.batteryLife > $1.batteryLife})
for mouse in cage {
    print(mouse.batteryLife, terminator:", ")
}
print()
// 9. Write a method, splitter(data:classifier:) that will take an array of Ints, data, and a closure, classifier, that accepts an Int and returns a Bool. It will return a new array in whch all the elements for which the closure returned false will precede those elements for which the closure returned true.

func splitter(data:[Int] , classifier: (Int) -> Bool) -> [Int]{
    
    var trueValue : [Int] = []
    var falseValue : [Int] = []
    
    for i in 0..<data.count{
    if (classifier (data[i]) ){
        trueValue.append(data[i])
    }
    else{
        falseValue.append(data[i])
        }
}
    return falseValue + trueValue
    
}

// For example, if data were [10, 15, 20, 23], and classifier returned true if an element were *even*, then splitter() would return (15, 23, 10, 20)

// Only use basic Swift programming constructs. Do not use any other function calls other than classsifier() and append()

var classifier: (Int) -> Bool = {x in return (x%2 == 0)}





// 10. Invoke splitter(), using data = [10, 15, 20, 23] and a classifier that returns true if an element is even. Print out the returned result.
var data = [10,15,20,23]

var result = splitter(data: data, classifier: classifier)

for re in result{
    print(re, terminator: " ")
}
print()



// 11. Write a function, palindromic(num:) that will return true if its parameter, an Int, is palindromic (it reads the same backwards as forwards). For example "1221" is palindromic, whereas "1223" is not. [Hint: Convert an Int into a String. Then reverse it, and see if the two are equal.]

func palindromic(num:Int) -> Bool {
    var num1 = num
    var reverseNum:Int = 0
    while (num1 > 0){
        let remiander = num1 % 10
        reverseNum = reverseNum * 10 + remiander
        num1 = num1 / 10
        
    }
    if (num == reverseNum){
        return true
    }
    else{
        return false
    }
}


// 12. Fill an array, aThou, with the numbers 1 ... 500 inclusive
var aThou : [Int] = []
for i in 1...500{
    aThou.append(i)
}



// 13. Use filter to return those values that are palindromic

let palindrome = aThou.filter{palindromic(num: $0 )}
print(palindrome)

print()
