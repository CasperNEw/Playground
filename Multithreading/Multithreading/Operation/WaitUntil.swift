//
//  WaitUntil.swift
//  Multithreading
//
//  Created by Дмитрий Константинов on 21.03.2020.
//  Copyright © 2020 Дмитрий Константинов. All rights reserved.
//

import Foundation

class MyWaitOperation {
    //метод wait блокирует вызывающий поток до окончания выполнения всех операций данной очереди
    private let operationQueue = OperationQueue()
    
    func waitUntil() {
        print("[WaitUntil] start test")
        DispatchQueue.global().async {
            self.firtsWaitUntil()
            self.secondWaitUntil()
        }
    }
    
    private func firtsWaitUntil() {
        operationQueue.addOperation {
            sleep(1)
            print("[WaitUntil] func 1/2 block 1/2")
        }
        operationQueue.addOperation {
            sleep(2)
            print("[WaitUntil] func 1/2 block 2/2")
        }
        operationQueue.waitUntilAllOperationsAreFinished()
    }
    
    private func secondWaitUntil() {
        let firstOperation = BlockOperation {
            sleep(1)
            print("[WaitUntil] func 2/2 block 1/2")
        }
        let secondOperation = BlockOperation {
            sleep(2)
            print("[WaitUntil] func 2/2 block 2/2")
        }
        operationQueue.addOperations([firstOperation, secondOperation], waitUntilFinished: true)
    }
}
