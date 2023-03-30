//: [Previous](@previous)

import UIKit

var arrA = [Int]()
var arrB = [Int]()
let lockA = NSLock()
let lockB = NSLock()
let myQueueA = DispatchQueue(label: "my.queue.a")
let myQueueB = DispatchQueue(label: "my.queue.b")

for i in 0..<100 {
    myQueueA.async {
        lockA.lock()
        lockB.lock()
        arrA.append(i)
        arrB.append(i * 2)
        lockB.unlock()
        lockA.unlock()
    }
}

for _ in 0..<100 {
    myQueueB.async {
        lockB.lock()
        lockA.lock()
        if !arrA.isEmpty {
            arrA.removeLast()
        }
        if !arrB.isEmpty {
            arrB.removeLast()
        }
        lockA.unlock()
        lockB.unlock()
    }
}

//: [Next](@next)
