import Foundation

// Queue

class BankAccount {
    private var balance: Double = 1000.0
    private let lock = NSLock()

    func deposit(amount: Double) {
        lock.lock()
        balance += amount
        print("Deposited \(amount). New balance: \(balance) \t|\t Thread: \(Thread.current)")
        lock.unlock()
    }

    func withdraw(amount: Double) {
        lock.lock()
        balance -= amount
        print("Withdrew \(amount). New balance: \(balance) \t|\t Thread: \(Thread.current)")
        lock.unlock()
    }

    func getBalance() -> Double {
        return balance
    }
}

let account = BankAccount()
let queue = DispatchQueue(label: "serial", attributes: .concurrent)
let group = DispatchGroup()

for _ in 1...5 {
    queue.async(group: group) {
        account.deposit(amount: 100.0)
    }
    
    queue.async(group: group) {
        account.withdraw(amount: 100.0)
    }
}

group.notify(queue: DispatchQueue.main) {
    print("All transactions are completed. Final balance: \(account.getBalance())")
}

RunLoop.main.run(until: Date(timeIntervalSinceNow: 3))

// Threads

let accountThreads = BankAccount()

let semaphore = DispatchSemaphore(value: 0)

let depositThread = Thread {
    for _ in 1...5 {
        accountThreads.deposit(amount: 50.0)
        Thread.sleep(forTimeInterval: Double.random(in: 0.1...0.3))
    }
    semaphore.signal()
}

let withdrawThread = Thread {
    for _ in 1...5 {
        accountThreads.withdraw(amount: 50.0)
        Thread.sleep(forTimeInterval: Double.random(in: 0.1...0.3))
    }
    semaphore.signal()
}

depositThread.start()
withdrawThread.start()

semaphore.wait()
semaphore.wait()

print("All transactions are completed. Final balance: \(accountThreads.getBalance())")
