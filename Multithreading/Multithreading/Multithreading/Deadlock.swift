//
//  Deadlock.swift
//  Multithreading
//
//  Created by Дмитрий Константинов on 14.03.2020.
//  Copyright © 2020 Дмитрий Константинов. All rights reserved.
//

import Foundation
//Deadlock (взаимная блокировка потоков, в итоге зависание) , Livelock (оба потока выполняют бесполезную работу)
//Priority inversion (низкоприоритетный поток захватывает ресурс, остальные потоки ждут)
class MyDeadlock {
    let firstLock = NSLock()
    let secondLock = NSLock()
    var firstResource = false
    var secondResource = false
}

class MyDeadlockTest {
    func deadlockTest() {
        //[Deadlock]
        let deadlock = MyDeadlock()
        print("[Deadlock] test in process")
        let firstThread = Thread(block: {
            deadlock.firstLock.lock()
            print("[Deadlock] firstThread firstLock lock()")
            deadlock.firstResource = true
            deadlock.secondLock.lock()
            print("[Deadlock] firstThread secondLock lock()")
            deadlock.secondResource = true
            deadlock.secondLock.unlock()
            print("[Deadlock] firstThread secondLock unlock()")
            deadlock.firstLock.unlock()
            print("[Deadlock] firstThread firstLock unlock()")
        })
        firstThread.start()
        
        let secondThread = Thread(block: {
            deadlock.secondLock.lock()
            print("[Deadlock] secondThread secondLock lock()")
            deadlock.secondResource = true
            deadlock.firstLock.lock()
            print("[Deadlock] secondThread firstLock lock()")
            deadlock.firstResource = true
            deadlock.firstLock.unlock()
            print("[Deadlock] secondThread firstLock unlock()")
            deadlock.secondLock.unlock()
            print("[Deadlock] secondThread secondLock unlock()")
            print("[Deadlock] test completed, u are lucky")
        })
        secondThread.start()
    }
}
