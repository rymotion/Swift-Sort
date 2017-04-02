//
//  MiddleSort.swift
//  
//
//  Created by Ryan Paglinawan on 3/30/17.
//
//

import Foundation
import Dispatch

public var intArr:[Int] = []
public var clone:[Int] = []
//: Button hits this function and causes it to do replace sorting and the additional middle-out sorting
//:(showing off a custom sorting algorithm that does not use the `.sorted` or the `.sort` methods)

public func middleOutSort<T: Comparable> (_a: inout [T]) -> (){
    var v1:T
    var v2:T
    var v3:T
        
    var _b:[T] = []
        
//:  size of array
    let size:Int = _a.count
    let checkSize:Double = Double(size)
    
        
//:  Initial Iterator
    var itr:Int = Int(size/2)
    print("half array \(itr)")
        
//:  Upper and lower bownds
    var cloneItr_U:Int
    var cloneItr_L:Int
        
    if (checkSize.truncatingRemainder(dividingBy: 2.0) == 0.0){
//: This will create three iterators one is constant
        itr += 1
//: This would take the next index so if this were 4.5 now we are only looking at 5 not 4
        cloneItr_U = itr + 1
        cloneItr_L = itr - 1
        print("If statement - new")
        print("\(itr), \(cloneItr_U), \(cloneItr_L)")
        // the lower bound iter will be 4
    } else {
//: This will create two iterators
        cloneItr_U = itr + 1
        cloneItr_L = itr
        print("else statement - new")
        print("\(itr), \(cloneItr_U), \(cloneItr_L)")
    }
//    _b = _a.sorted{(Int1,Int2) -> Bool in return (Int1 < Int2)}
    
    v1 = _a[cloneItr_L]
    v2 = _a[itr]
    v3 = _a[cloneItr_U]
    _b = _a
        
    for _ in 0 ... Int(size)  {
            
        v1 = _a[cloneItr_L]
        v3 = _a[cloneItr_U]
            
        //: compare the values at locations in the array where itrs are
        //: I was attempting to use switch statements here but alas the logic was not flowing correctly
        if v1 < v3{
            let temp = v1
            _b.insert(temp, at: cloneItr_L + 1)
            _b.remove(at: cloneItr_L)
        }
        if v1 < v2 || v1 == v2{
            let temp = v1
            let temp2 = v2
            _b[cloneItr_L] = temp
            _b[itr] = temp2
            
            if 0 <= cloneItr_L {
                // stop program
            } else {cloneItr_L -= 1}
            if cloneItr_U <= _a.count - 1 {
                // stop
            } else {cloneItr_U += 1}
        }
        if v2 < v3 {
            let temp = v2
            let temp2 = v3
            _b[itr] = temp
            _b[cloneItr_U] = temp2
            
            if 0 <= cloneItr_L {
                // stop program
            } else {cloneItr_L -= 1}
            if cloneItr_U <= _a.count - 1 {
                // stop
            } else {cloneItr_U += 1}
        }
        if v2 < v1 {
            let temp = v2
            let temp2 = v1
            _b[cloneItr_L] = temp
            _b[itr] = temp2
            
            if 0 <= cloneItr_L {
                // stop program
            } else {cloneItr_L -= 1}
            if cloneItr_U <= _a.count - 1 {
                // stop
            } else {cloneItr_U += 1}
        }
        if v3 < v1 {
            let temp = v3
            let temp2 = v1
            _b[cloneItr_L] = temp
            _b[cloneItr_U] = temp2
            
            if 0 <= cloneItr_L {
                // stop program
            } else {cloneItr_L -= 1}
            if cloneItr_U <= _a.count - 1 {
                // stop
            } else {cloneItr_U += 1}
        }
        if v3 < v2 {
            let temp = v3
            let temp2 = v2
            _b[itr] = temp
            _b[cloneItr_U] = temp2
            
            if 0 <= cloneItr_L {
                // stop program
            } else {cloneItr_L -= 1}
            if cloneItr_U <= _a.count - 1 {
                // stop
            } else {cloneItr_U += 1}
        }
    }
    
    print(_b)
    
    print("this is the count of the copied array: \(_b.count)")
    
    _b = _b.sorted{(int1, int2) -> Bool in return (int1 < int2)}
    
    printSort(_a: &_b)
}
public func printSort<T>(_a: inout[T]){
    // This will output the arrays
    let size:Int = Int(_a.count)
    for i in stride(from: 0, to: size, by: 1){
        // print out to UI
        print("%d",_a[i])
    }
    print(_a)
}

