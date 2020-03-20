//
//  DispatchBarrier.swift
//  Multithreading
//
//  Created by Дмитрий Константинов on 17.03.2020.
//  Copyright © 2020 Дмитрий Константинов. All rights reserved.
//

import Foundation

class MyDispatchBarrier {
    
    private let queue = DispatchQueue(label: "DispatchBarrier", attributes: .concurrent)
    private var value = 0
    
    //создаем сеттер для нашего значения с блокировкой доступа барьером
    func setValue(_ value: Int) {
        queue.async(flags: .barrier) {
            self.value = value
        }
    }
    //создаем геттер, которые не блокирует и не изменяет значения, то есть мы можем пользоваться им из разных потоков
    func getValue() -> Int {
        var tempValue = 0
        queue.sync {
            tempValue = self.value
        }
        return tempValue
    }
    
    func safeArrayHandling() {
        let array = SafeArray<Int>()
        DispatchQueue.concurrentPerform(iterations: 100) { (index) in
            array.append(index)
        }
        
        print("[DispatchBarrier] array: ", array.valueArray)
        print("[DispatchBarrier] array.count: ", array.valueArray.count)
    }
    
    
}

class SafeArray<T> {
    private var array = [T]()
    private let queue = DispatchQueue(label: "SafeArrayQueue", attributes: .concurrent)
    
    public func append(_ value: T) {
        queue.async(flags: .barrier) {
            self.array.append(value)
        }
    }
    
    public var valueArray: [T] {
        var result = [T]()
        queue.sync {
            result = self.array
        }
        return result
    }
}
