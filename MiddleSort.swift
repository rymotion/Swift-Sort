 //
//  MiddleSort.swift
//  
//
//  Created by Ryan Paglinawan on 3/30/17.
//
//

import Foundation
import Dispatch

class MiddleSort {
//: Button hits this function and causes it to do replace sorting and the additional middle-out sorting
//:(showing off a custom sorting algorithm that does not use the `.sorted` or the `.sort` methods)
    
//: - IMPORTANT:
//: This has not been fully tested would not reccommend for commercial use just yet.
//:  This was just for fun, and to flex with Swift
    func startSort() -> () {
        start.isUserInteractionEnabled = false
        start.backgroundColor = .gray
        if intArr.isEmpty{/*Do Nothing*/} else {
            clone = intArr.sorted{(Int1, Int2) -> Bool in return (Int1 < Int2)}
            
            DispatchQueue.global(qos: DispatchQoS.background.qosClass).async{
                self.start.setTitle("Sorting...", for: UIControlState.disabled)
                DispatchQueue.main.async {
                    self.middleOutSort(_a: &self.intArr)
                }
            }
        }
        print("Cloned array:\n\(clone)")
        
        label.text = "Array in memory:\n\(clone)"
        
        start.isUserInteractionEnabled = true
        start.backgroundColor = .green
    }
    
    func middleOutSort<T: Comparable> (_a: inout [T]) -> (){
        title = "Sorting"
        var v1:T
        var v2:T
        var v3:T
        
        var _b:[T] = []
        
        //:  size of array
        let size:Int = Int(_a.count)
        
        //:  Initial Iterator
        var itr:Int = Int(size/2)
        print("half array \(itr)")
        
        //:  Upper and lower bownds
        var cloneItr_U:Int
        var cloneItr_L:Int
        
        if size % 2 != 0 {
            //: This will create three iterators one is constant
            itr += 1
            //: This would take the next index so if this were 4.5 now we are only looking at 5 not 4
            cloneItr_U = itr + 1
            cloneItr_L = itr - 1
            print("If statement")
            print("\(itr), \(cloneItr_U), \(cloneItr_L)")
            // the lower bound iter will be 4
            
        } else {
            //: This will create two iterators
            cloneItr_U = itr
            cloneItr_L = itr + 1
            print("else statement")
            print("\(itr), \(cloneItr_U), \(cloneItr_L)")
        }
        
        v1 = _a[cloneItr_L]
        v2 = _a[itr]
        v3 = _a[cloneItr_U]
        
        for i in 1..<_a.count  {
            
            v1 = _a[cloneItr_L]
            v3 = _a[cloneItr_U]
            
            //: compare the values at locations in the array where itrs are
            //
            //            temp = (v1 < v2 || v1 < v3) ? v1 : (v3 < v2 || v3 < v1) ? v3 : v2
            //            temp2 = (v3 != v2 || v3 < v1) ? v3 : v2
            switch (v1, v2, v3) {
            case (let v1, let v2, let v3) where (v1 < v2 || v1 < v3):
                print("case: \(v1)")
                _b.insert(v1, at: i)
            case (let v1, let v2, let v3) where (v3 < v2 || v3 < v1):
                print("case 2: \(v3)")
                _b.insert(v3, at: i)
            case (let v1, let v2, let v3) where (v3 != v2 || v3 < v1):
                print("case 3:\(v3)")
                _b.insert(v3, at: i)
            default:
                print("default: \(v2)")
                _b.insert(v2, at: i)
            }
            
            if cloneItr_L == 0 {
                // stop program
            } else {cloneItr_L -= 1}
            if cloneItr_U == _a.count - 1 {
                // stop
            } else {cloneItr_U += 1}
        }
        _b.append(v2)
        print(_b)
        printSort(_a: &_b)
    }
    func printSort<T>(_a: inout[T]){
        // This will output the arrays
        let size:Int = Int(_a.count)
        for i in stride(from: 0, to: size, by: 1){
            // print out to UI
            print("%d",_a[i])
        }
        start.isUserInteractionEnabled = true
        print(_a)
        label.text = "sorted array:\n\(_a)"
    }
    func clearArr() -> (){
        // clears array
        intArr = []
        clone = []
        printSort(_a: &intArr)
        printSort(_a: &clone)
        label.text = "Array in memory:\n\(clone)"
    }

}
