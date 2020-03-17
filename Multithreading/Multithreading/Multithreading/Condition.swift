//
//  Condition.swift
//  Multithreading
//
//  Created by Дмитрий Константинов on 13.03.2020.
//  Copyright © 2020 Дмитрий Константинов. All rights reserved.
//

import Foundation

class MyCondition {
    //решил сделать Seangleton что бы не создавать глобальные переменные, так как в перспективе возможно большое увеличение их количества
    static let instance = MyCondition()
    private init() {}
    
    var condition = pthread_cond_t()
    var mutex = pthread_mutex_t()
    var conditionCheck = false
    
    var nsCondition = NSCondition()
    var nsConditionCheck = false
}

class MyMutexConditionPrinter: Thread {
    
    override init() {
        pthread_cond_init(&MyCondition.instance.condition, nil)
        pthread_mutex_init(&MyCondition.instance.mutex, nil)
    }
    
    override func main() {
        printMethod()
    }
    
    private func printMethod() {
        pthread_mutex_lock(&MyCondition.instance.mutex)
        print("[Cond] test in progress")
        while !MyCondition.instance.conditionCheck {
            print("[Cond] condition wait")
            pthread_cond_wait(&MyCondition.instance.condition, &MyCondition.instance.mutex)
        }
        MyCondition.instance.conditionCheck = false
        defer {
            pthread_mutex_unlock(&MyCondition.instance.mutex)
        }
        print("[Cond] test completed")
    }
    
}

class MyMutexConditionWriter: Thread {
    
    override init() {
        pthread_cond_init(&MyCondition.instance.condition, nil)
        pthread_mutex_init(&MyCondition.instance.mutex, nil)
    }
    
    override func main() {
        writeMethod()
    }
    
    private func writeMethod() {
        pthread_mutex_lock(&MyCondition.instance.mutex)
        MyCondition.instance.conditionCheck = true
        pthread_cond_signal(&MyCondition.instance.condition)
        defer {
            pthread_mutex_unlock(&MyCondition.instance.mutex)
        }
        print("[Cond] signal to condition")
    }
}

class MyConditionPrinter: Thread {
    
    override func main() {
        printMethod()
    }
    
    private func printMethod() {
        MyCondition.instance.nsCondition.lock()
        print("[NS_Cond] test in progress")
        while !MyCondition.instance.nsConditionCheck {
            print("[NS_Cond] waiting condition")
            MyCondition.instance.nsCondition.wait()
        }
        MyCondition.instance.nsConditionCheck = false
        defer {
            MyCondition.instance.nsCondition.unlock()
        }
        print("[NS_Cond] test completed")
    }
}
class MyConditionWriter: Thread {
    
    override func main() {
        writeMethod()
    }
    
    private func writeMethod() {
        MyCondition.instance.nsCondition.lock()
        MyCondition.instance.nsConditionCheck = true
        MyCondition.instance.nsCondition.signal()
        defer {
            MyCondition.instance.nsCondition.unlock()
        }
        print("[NS_Cond] signal to condition")
    }
}
