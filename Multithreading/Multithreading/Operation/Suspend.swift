//
//  Suspend.swift
//  Multithreading
//
//  Created by Дмитрий Константинов on 21.03.2020.
//  Copyright © 2020 Дмитрий Константинов. All rights reserved.
//

import Foundation

class MyOperationSuspend {
    private let operationQueue = OperationQueue()
    
    func suspend() {
        let firstOperation = BlockOperation {
            print("[Suspend] 1/2 operation completed")
            sleep(1)
        }
        let secondOperation = BlockOperation {
            sleep(1)
            print("[Suspend] 2/2 operation completed")
        }
        secondOperation.completionBlock = { print("[Suspend] ERROR")}
        
        operationQueue.maxConcurrentOperationCount = 1
        operationQueue.addOperations([firstOperation, secondOperation], waitUntilFinished: false)
        
        operationQueue.isSuspended = true
        if operationQueue.isSuspended { sleep(1) ; print("[Suspend] suspended completed") }
    }
}
