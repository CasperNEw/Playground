//
//  Condition.swift
//  Multithreading
//
//  Created by Дмитрий Константинов on 13.03.2020.
//  Copyright © 2020 Дмитрий Константинов. All rights reserved.
//

import Foundation

class MyMutexCondition {
    private var condition = pthread_cond_t()
    private var mutex = pthread_mutex_t()
    private var check = false
    
    init() {
        pthread_cond_init(&condition, nil)
        pthread_mutex_init(&mutex, nil)
    }
    func conditionTest() {
        pthread_mutex_lock(&mutex)
        print("[Cond] test in progress")
        while !check {
            print("[Cond] waiting condition")
            pthread_cond_wait(&condition, &mutex)
        }
        pthread_mutex_unlock(&mutex)
        print("[Cond] test completed")
    }
    
    func signalToCondition() {
        pthread_mutex_lock(&mutex)
        print("[Cond] signal to condition")
        check = true
        pthread_cond_signal(&condition)
        pthread_mutex_unlock(&mutex)
    }
}

class MyCondition {
    private let condition = NSCondition()
    private var check = false
    
    func nsConditionTest() {
        condition.lock()
        print("[NS_Cond] test in progress")
        while !check {
            print("[NS_Cond] waiting condition")
            condition.wait()
        }
        condition.unlock()
        print("[NS_Cond] test completed")
    }
    
    func signalToCondition() {
        condition.lock()
        print("[NS_Cond] signal to condition")
        check = true
        condition.signal()
        condition.unlock()
    }
}

class MyConditionTest {
    func conditionTest() {
        //[Cond]
        let condition = MyMutexCondition()
        // создаем свою очередь
        let queue = DispatchQueue(label: "com.condition.serialQueue")
        // описываем разные потоки
        let threads: [Thread] = [
            .init { condition.conditionTest() },
            .init { condition.signalToCondition() } ]
        // выполняем работу из очереди в разных потоках
        threads.forEach { thread in queue.sync { thread.start() }}
    }
    func nsConditionTest() {
        //[NS_Cond]
        let condition = MyCondition()
        let queue = DispatchQueue(label: "com.nsCondition.serialQueue")
        let threads: [Thread] = [
            .init { condition.nsConditionTest() },
            .init { condition.signalToCondition() } ]
        threads.forEach { thread in queue.sync { thread.start() }}
    }
}
