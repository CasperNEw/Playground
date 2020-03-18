//
//  Semaphore.swift
//  Multithreading
//
//  Created by Дмитрий Константинов on 16.03.2020.
//  Copyright © 2020 Дмитрий Константинов. All rights reserved.
//

import Foundation

class MySemaphore {
    private let semaphore = DispatchSemaphore(value: 0)
    private let anotherSemaphore = DispatchSemaphore(value: 2) //defaulte, zero, =2
    
    func signalTest() {
        print("[Semaphore] start test")
        DispatchQueue.global().async {
            sleep(2)
            print("[Semaphore] send signal")
            self.semaphore.signal()
        }
        semaphore.wait()
        print("[Semaphore] test completed")
    }
    
    private func access() {
        anotherSemaphore.wait()
        print("[Semaphore] thread can access")
        sleep(2)
        anotherSemaphore.signal()
    }
    
    func threadCountTest() {
        
        DispatchQueue.global().async {
            self.access()
        }
        DispatchQueue.global().async {
            self.access()
        }
        DispatchQueue.global().async {
            self.access()
        }
    }
    
}
