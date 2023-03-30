# SwiftConcurrency
A study about concurrency in Swift

In the ConcurrencyAndThreadSafety.playground there is a hipotetical situation of a system that handle 2000 of iPhones in stock and two different stores are selling the same stock at the same time.

To prevent sell problems caused by race conditions I used some thread safety strategies with dispatch barrier, semaphore and lock.


