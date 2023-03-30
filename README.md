# SwiftConcurrency
A study about concurrency in Swift

In the ConcurrencyAndThreadSafety.playground there is a hipotetical situation of a system that handle 2000 of iPhones in stock and two different stores are selling the same stock at the same time.

To prevent sell problems caused by race conditions I used some thread safety strategies with dispatch barrier, semaphore and lock.

In the LittleJohn app I worked with a Vapor server that runs a back-end application to provide live prices for some stocks.

It's just a introduction to modern concurrency but a several concepts learned here, async/await with SwiftUI, how to work with asynchronous sequences, work with this in views, tasks etc...

For future steps I want to lear more about AssyncStream, TaskGroup, Actors and Combine.

