//
//  RecursiveLock.swift
//  Multithreading
//
//  Created by Дмитрий Константинов on 13.03.2020.
//  Copyright © 2020 Дмитрий Константинов. All rights reserved.
//

import Foundation

class MyRecursiveMutex {
    //рекурсивный Unix mutex
    //mutex - защита объекта от доступа к нему из других потоков
    private var mutex = pthread_mutex_t()
    private var attr = pthread_mutexattr_t()
    
    init() {
        pthread_mutexattr_init(&attr)
        pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE) //!
        pthread_mutex_init(&mutex, &attr)
    }
    func recursiveTest() {
        print("[R_Lock] test start")
        pthread_mutex_lock(&mutex)
        mutexTest()
        defer {
            pthread_mutex_unlock(&mutex)
        }
        print("[R_Lock] test completed")
    }
    private func mutexTest() {
        pthread_mutex_lock(&mutex)
        print("[R_Lock] \(qos_class_self())")
        defer {
            pthread_mutex_unlock(&mutex)
        }
        print("[R_Lock] method in test completed")
    }
}

class MyRecursiveLock: Thread {
    //рекурсивный mutex используя возможности фреймворка Foundation
    private let recursiveLock = NSRecursiveLock()
    
    override func main() {
        print("[NSR_Lock] test start")
        recursiveLock.lock()
        lockTest()
        defer {
            recursiveLock.unlock()
        }
        print("[NSR_Lock] test completed")
    }
    private func lockTest() {
        recursiveLock.lock()
        print("[NSR_Lock] \(qos_class_self())")
        defer {
            recursiveLock.unlock()
        }
        print("[NSR_Lock] method in test completed")
    }
}
