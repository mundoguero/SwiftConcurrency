import UIKit

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

tryRaceCondition()
