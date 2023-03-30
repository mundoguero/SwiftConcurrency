//Study from the articles
//
//https://medium.com/cubo-ai/concurrency-thread-safety-in-swift-5281535f7d3a
//https://medium.com/swiftcairo/avoiding-race-conditions-in-swift-9ccef0ec0b26
//https://www.objc.io/issues/2-concurrency/concurrency-apis-and-pitfalls/#dead-locks

import Foundation
struct IPhone {
    static var stock = 2000
}

class AppleStore {
    let location: String
    
    init(location: String) {
        self.location = location
    }
    
    func sell(value: Int) {
        print("\(location): start transaction process...")
        if IPhone.stock > value {
            // sleeping for some time, simulating server process
            Thread.sleep(forTimeInterval: Double.random(in: 0...1))
            IPhone.stock -= value
            print("\(location): \(value) has been sold")
            print("current balance is \(IPhone.stock)")
            if IPhone.stock < 0 {
                print("there is a stock issue")
            }
        } else {
            print("\(location): Can't sell due to insufficent balance")
        }
    }
}

func tryRaceCondition() {
    let appleStoreUS = AppleStore(location: "US")
    let appleStoreTW = AppleStore(location: "TW")
    let queue = DispatchQueue(label: "sellQueue", attributes: .concurrent)
    
    queue.async {
        appleStoreUS.sell(value: 1000)
    }
    
    queue.async {
        appleStoreTW.sell(value: 1500)
    }
}

func avoidRaceConditionWithDispatchBarrier() {
    let appleStoreUS = AppleStore(location: "US")
    let appleStoreTW = AppleStore(location: "TW")

    let queue = DispatchQueue(label: "sellQueue", attributes: .concurrent)
    
    queue.async(flags: .barrier) {
        appleStoreUS.sell(value: 1000)
    }
    
    queue.async(flags: .barrier) {
        appleStoreTW.sell(value: 1500)
    }
}

func avoidRaceConditionWithSemaphore() {
    let appleStoreUS = AppleStore(location: "US")
    let appleStoreTW = AppleStore(location: "TW")
    
    let globalQueue = DispatchQueue.global()
    let queue = DispatchQueue(label: "sellQueue", attributes: .concurrent)
    let semaphore = DispatchSemaphore(value: 0)
    
    globalQueue.async {
        queue.async{
            appleStoreUS.sell(value: 1000)
            semaphore.signal()
        }
        semaphore.wait()

        queue.async{
            appleStoreTW.sell(value: 1500)
            semaphore.signal()
        }
        semaphore.wait()
    }
    
}

func avoidRaceConditionWithLock() {
    let appleStoreUS = AppleStore(location: "US")
    let appleStoreTW = AppleStore(location: "TW")
    
    let queue = DispatchQueue(label: "sellQueue", attributes: .concurrent)
    let lock = NSLock()
    
    queue.async{
        lock.lock()
        appleStoreUS.sell(value: 1000)
        lock.unlock()
    }
    
    queue.async{
        lock.lock()
        appleStoreTW.sell(value: 1500)
        lock.unlock()
    }
    
}
//try this first
// tryRaceCondition()

//after try this
//avoidRaceConditionWithDispatchBarrier()

//or this
//avoidRaceConditionWithSemaphore()

//or  this
//avoidRaceConditionWithLock()






//: [Next](@next)
