//
//  Dispatch group.swift
//  Multithreading
//
//  Created by Дмитрий Константинов on 16.03.2020.
//  Copyright © 2020 Дмитрий Константинов. All rights reserved.
//

import Foundation

class MyDispatchGroup {
    private let group = DispatchGroup()
    private let anotherGroup = DispatchGroup()
    private let queue = DispatchQueue(label: "DispatchGroupTest", attributes: .concurrent)
    
    func groupTest() {
        notifyTest()
        waitTest()
    }
    
    private func notifyTest() {
        queue.async(group: group) {
            print("[DispatchGroup] wait 1 second, \(Date())")
            sleep(1)
        }
        queue.async(group: group) {
            print("[DispatchGroup] wait 2 second, \(Date())")
            sleep(2)
        }
        group.notify(queue: DispatchQueue.main) {
            print("[DispatchGroup] test completed, \(Date())")
        }
    }
    
    private func waitTest() {
        anotherGroup.enter()
        queue.async {
            sleep(1)
            self.anotherGroup.leave()
        }
        anotherGroup.enter()
        queue.async {
            sleep(3)
            self.anotherGroup.leave()
        }
        anotherGroup.wait()
        print("[DispatchGroup] another test completed")
        
    }
    
}
