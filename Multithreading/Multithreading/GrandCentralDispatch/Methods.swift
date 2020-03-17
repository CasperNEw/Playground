//
//  Methods.swift
//  Multithreading
//
//  Created by Дмитрий Константинов on 16.03.2020.
//  Copyright © 2020 Дмитрий Константинов. All rights reserved.
//

import Foundation

class MyAsyncVsSyncTest {
    
    private let serialQueue = DispatchQueue(label: "SerialTest")
    private let concurrentQueue = DispatchQueue.global()
    private let anotherConcurrentQueue = DispatchQueue(label: "AsyncAfterTest", attributes: .concurrent)
    
    func specialTest() {
        testAsyncAfter()
        testSerialQueue()
        testConcurrentQueue()
    }
    
    private func testSerialQueue() {
        serialQueue.async {
            sleep(1)
            print("[Queue serial] 1 async with 1 second latency")
        }
        serialQueue.async {
            print("[Queue serial] 2 async")
        }
        serialQueue.sync {
            print("[Queue serial] 3 sync first")
        }
        serialQueue.sync {
            print("[Queue serial] 4 sync second")
        }
    }
    
    private func testConcurrentQueue() {
        concurrentQueue.async {
            sleep(2)
            print("[Queue concurrent] 1 async with 2 second latency")
        }
        concurrentQueue.async {
            sleep(1)
            print("[Queue concurrent] 2 async with 1 second latency")
        }
        concurrentQueue.sync {
            print("[Queue concurrent] 3 sync first")
        }
        concurrentQueue.sync {
            print("[Queue concurrent] 4 sync second")
        }
    }
    
    private func testAsyncAfter() {
        anotherConcurrentQueue.asyncAfter(deadline: .now() + 2) {
            print("[Queue asyncAfter] .now() + 2 second")
        }
    }
}
