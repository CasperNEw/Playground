//
//  ConcurrentPerform.swift
//  Multithreading
//
//  Created by Дмитрий Константинов on 16.03.2020.
//  Copyright © 2020 Дмитрий Константинов. All rights reserved.
//

import Foundation

class MyConcurrentPerform {
    //метод concurrentPerform автоматически раскидывает наши задачи по всем потокам, позволяет эффективно использовать свободные ресурсы системы
    func perform() {
        DispatchQueue.concurrentPerform(iterations: 15) { (count) in
            print(count)
            print(Thread.current)
        }
    }
    
    func withoutMainPerform() {
        //метод concurrentPerform реализованный без блокировки main потока
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            DispatchQueue.concurrentPerform(iterations: 30) { (count) in
                print(count)
                print(Thread.current)
            }
        }
    }
    
    func myInactiveQueue() {
        let inactiveQueue = DispatchQueue(label: "InactiveQueue", attributes: [.concurrent, .initiallyInactive])
        
        inactiveQueue.async {
            print("[InactiveQueue] test completed")
        }
        
        print("[InactiveQueue] method preparation")
        inactiveQueue.activate()
        print("[InactiveQueue] activate")
        inactiveQueue.suspend()
        print("[InactiveQueue] pause")
        inactiveQueue.resume()
    }
    
    
}
