//
//  MaxConcurrentOperationCount.swift
//  Multithreading
//
//  Created by Дмитрий Константинов on 21.03.2020.
//  Copyright © 2020 Дмитрий Константинов. All rights reserved.
//

import Foundation

class MyOperationCount {
    
    private let operationQueue = OperationQueue()
    //ограничение максимального количества параллельных операций
    func concurrentOperationTest() {
        operationQueue.maxConcurrentOperationCount = 1
        operationQueue.addOperation {
            sleep(1)
            print("[OperationCount] sleep 1 operation 1")
        }
        operationQueue.addOperation {
            sleep(1)
            print("[OperationCount] sleep 1 operation 2")
        }
        operationQueue.addOperation {
            sleep(1)
            print("[OperationCount] sleep 1 operation 3")
        }
    }
}
