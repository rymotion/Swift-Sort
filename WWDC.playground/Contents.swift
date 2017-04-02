/*:
 #  Middle Out Sort
This algorithm allows for sorting in-between an array and it's indexes
\
 This requires user input from the `UITextField`
 */

import UIKit
import Foundation
import XCPlayground
import PlaygroundSupport
import Dispatch

//: This function generates and sends data to the `MiddleSort.swift` file attached to this PlayGround

//: The only reason why I wrote this function `testArr` to just sort without having the UI to make sure and show who ever that is looking at this, it works but the Playground for some reason is not having it. but the same breakdown of what happens here also applies to the explained code below.
var _testArr:[Int] = []
func testArr() -> (){
    print("TestArray function")
    let dispatchTest = DispatchQueue(label: "test", qos: DispatchQoS.background)
    dispatchTest.async {
        for _ in 0...12{
            let exam:UInt32 = arc4random_uniform(100)
            let someInt:Int = Int(exam)
            _testArr.append(someInt)
        }
        print(_testArr)
        middleOutSort(_a: &_testArr)
    }
}
testArr()


class SwiftSortController: UIViewController, UITextFieldDelegate {
    let queueQoS = DispatchQueue(label: "algorithm", qos: DispatchQoS.userInitiated)
    let queue = DispatchQueue(label: "In Place sort provided by Apple")
/*:
     Blank arrays are inited for the program that will then modify them.
*/
    var intArr:[Int] = []
    var clone:[Int] = []
    
//: We read from the user input ignoring white space
//: Technically I should have ignored "," characters but
//: even I was too lazy to keep typing out commas in-between characters
    
    func parseField(text: UITextField) -> [Int] {
        let temp:String = text.text!
        let elm = temp.components(separatedBy: " ").flatMap{Int($0)}
        
        for elements in elm{
            let test:Int = elements
            intArr.append(test)
        }
        return intArr
    }
//: - IMPORTANT:
//: This has not been fully tested would not reccommend for commercial use just yet.
//:  This was just for fun, and to flex with Swift
    func startSort() -> () {
        if intArr.isEmpty{/*Do Nothing*/} else {
            queue.sync {
                clone = intArr.sorted{(Int1, Int2) -> Bool in return (Int1 < Int2)}
//: I passed all the values of our `intArr` through the `.sorted` method to see the final result that is now passed into `clone` 
            }
            queueQoS.async {
                    middleOutSort(_a: &self.intArr)
//: This is then sent into the `MiddleSort.swift` and returns asyncronously to the rest of the program so that the algorithm is run on a different thread
            }
        }
        print("Cloned array:\n\(clone)")
        print("Array in Memory after MiddleSort:\n\(intArr)")
    }
//: Considering that we are manipulating at the memory address of `intArr` and `clone` we would just need to view the array by calling the array as shown above.
    func clearArr() -> (){
        // clears array
        intArr = []
        clone = []
//: This causes the code to reinit with a blank array
        printSort(_a: &intArr)
        printSort(_a: &clone)
    }
}

//:  Above line of code overrides the 30sec execution for a PlayGround

let master = UIView(frame: CGRect(x: 0, y: 0, width: 720, height: 1280))

let respondTo = SwiftSortController()

//: This boots up the first view controller with the swift sort algorithm

master.backgroundColor = UIColor.white
//  User interface
var input:UITextField!
let label:UILabel!
let start:UIButton!
let clear:UIButton!
let descripLabel:UILabel!

descripLabel = UILabel(frame: CGRect(origin: CGPoint(x:0, y: 20), size: CGSize(width: 720, height: 560)))
descripLabel.numberOfLines = 4
descripLabel.textAlignment = NSTextAlignment.center
descripLabel.text = "Example: \n 1 4 3 5 6 7 8 9 90 21 32 etc. \n NOT: \n 1, 4, 3, 5, 6, 7, 8, 9"
master.addSubview(descripLabel)

input = UITextField()
input.frame = CGRect(x: 0, y: 200, width: 720, height: 50)
input.borderStyle = .roundedRect
input.text = "Input values with a space seperating them"
input.textAlignment = NSTextAlignment.center
input.clearsOnBeginEditing = true
master.addSubview(input)

if input.resignFirstResponder() {
    respondTo.parseField(text: input)
}
//: - IMPORTANT:
//: This sets up the UI but there is responsiveness lacking I think it might have to do with the fact my UI is more involved so don't do this rather run this through an iOS simulator for more responsive UI.

start = UIButton(frame: CGRect(x:0,y:150,width:720,height:50))
start.showsTouchWhenHighlighted = true
start.setTitle("Start Sort", for: UIControlState.normal)
start.setTitleColor(UIColor.black, for: .normal)
start.addTarget(respondTo, action: #selector(SwiftSortController.startSort), for: .touchUpInside)
start.backgroundColor = UIColor.green
master.addSubview(start)

//: Setup the `UIButton` that is attached to the `clearArr` funtion

clear = UIButton(frame: CGRect(x:0,y:400,width:720,height:50))
clear.showsTouchWhenHighlighted = true
clear.setTitle("Clear", for: UIControlState.normal)
clear.setTitleColor(UIColor.black, for: .normal)
clear.addTarget(respondTo, action: #selector(SwiftSortController.clearArr), for: .touchUpInside)
clear.backgroundColor = UIColor.red
master.addSubview(clear)


label = UILabel(frame: CGRect(origin: CGPoint(x:0, y: 250), size: CGSize(width: 720, height: 560)))
//: Doing this for formatting so I can put as much information on screen
label.numberOfLines = 7
label.textAlignment = NSTextAlignment.center
label.text = "Output will be displayed here.\n Let's say the UI is still unresponsive.\n The test code that checks the middle out sort will still output\n \(_testArr) \n in terminal and here.\n terminal is more explicit"
label.font = UIFont(name: "San-Francisco-Regular", size: 10.0)
label.textColor = .black
master.addSubview(label)
SwiftSortController.initialize()

//:  Allow user for imput then take input and make into array
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = master



