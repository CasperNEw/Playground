//
//  Operation&OperationQueueu.swift
//  Multithreading
//
//  Created by Дмитрий Константинов on 21.03.2020.
//  Copyright © 2020 Дмитрий Константинов. All rights reserved.
//

import Foundation

class MyOperation {
    
    class SpecialOperation: Operation {
        override func main() {
            print("[Operation] add custom operation completed")
        }
    }
    //operation может быть выполнена только 1 раз, при попытке повторного выполнения задачи словим ошибку
    //operationQueue по дефолту выполняет наши операции асинхронно
    private let operationQueue = OperationQueue()
    private let operation = SpecialOperation()
    
    func addOperation() {
        print("[Operation] start test 'add'")
        operationQueue.addOperation {
            print("[Operation] \(Thread.current)")
            print("[Operation] add operation completed")
        }
        operationQueue.addOperation(operation)
    }
}
