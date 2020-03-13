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
    private var mutex = pthread_mutex_t()
    private var attr = pthread_mutexattr_t()
    
    init() {
        pthread_mutexattr_init(&attr)
        pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE) //!
        pthread_mutex_init(&mutex, &attr)
    }
    func recursiveTest() {
        pthread_mutex_lock(&mutex)
        mutexTest()
        pthread_mutex_unlock(&mutex)
        print("[R_Lock] test completed")
    }
    private func mutexTest() {
        pthread_mutex_lock(&mutex)
        print("[R_Lock] test in process")
        print("[R_Lock] \(qos_class_self())")
        pthread_mutex_unlock(&mutex)
    }
}

class MyRecursiveLock {
    //рекурсивный mutex используя возможности фреймворка Foundation
    private let lock = NSRecursiveLock()
    
    func nsRecursiveTest() {
        lock.lock()
        lockTest()
        lock.unlock()
        print("[NSR_Lock] test completed")
    }
    private func lockTest() {
        lock.lock()
        print("[NSR_Lock] test in process")
        print("[NSR_Lock] \(qos_class_self())")
        lock.unlock()
    }
}
