//
//  WorkItem.swift
//  Multithreading
//
//  Created by Дмитрий Константинов on 16.03.2020.
//  Copyright © 2020 Дмитрий Константинов. All rights reserved.
//

import Foundation

class MyDispatchWorkItem {
    private let concurrentQueue = DispatchQueue(label: "DispatchWorkItem", attributes: .concurrent)
    private let serialQueue = DispatchQueue(label: "DispatchWorkItemTwo")
    
    func something() {
        //абстракция над выполняемой задачей, которая предоставляет различные удобные методы, например notify
        let item = DispatchWorkItem {
            print("[WorkItem] test in progress")
        }
        let secondItem = DispatchWorkItem {
            print("[WorkItem] ERROR, item for cancel")
        }
        
        //метод notify отрабатывает по окончанию работы WorkItem, без разницы успешный он будет или нет
        item.notify(queue: DispatchQueue.main) {
            print("[WorkItem] it is notify")
        }
        concurrentQueue.async(execute: item)
        
        serialQueue.async {
            sleep(2)
            print("[WorkItem] test completed")
        }
        serialQueue.async(execute: secondItem)
        
        secondItem.cancel()
        if secondItem.isCancelled { print("[WorkItem] item canceled")}
    }
}
