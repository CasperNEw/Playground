//
//  Operation.swift
//  Multithreading
//
//  Created by Дмитрий Константинов on 20.03.2020.
//  Copyright © 2020 Дмитрий Константинов. All rights reserved.
//

import Foundation

class MyBlockOperation {
    private let operationQueue = OperationQueue()
    
    func addBlock() {
        let blockOperation = BlockOperation {
            print("test")
        }
        operationQueue.addOperation(blockOperation)
    }
}

class MyOperationKVO: NSObject {
    //пример реализации KVO на изменения статуса нашего блока операции (isCancelled, isAsynchronous, isExecuting, isFinished, isReady, dependencies, completionBlock)
//    let operation: Operation
//    init(operation: Operation) {
//        self.operation = operation
//    }
    
    func testingObserver() {
        let operation = Operation()
        operation.addObserver(self, forKeyPath: "isFinished", options: NSKeyValueObservingOptions.new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "isFinished" {
            print("[OperationKVO] operation isFinished change status")
        }
    }
    
    let notice = """
 isReady говорит о том, что операция готова для выполнения (свойство выставлено в true). Свойство выставлено в false, если зависимые операции еще не выполнились. Обычно у вас нет прямой необходимости для того, чтобы переопределять это свойство. Если готовность ваших операций определяется не только через зависимые операции, вы можете предоставить свою собственную имплементацию isReady и определять готовность операции для выполнения самостоятельно.
    isExecuting означает, что операция выполняется в данный момент. True если операция выполняется, false если нет. Если вы переопределяете метод start, вы также должны переопределить isExecuting и отправлять kvo нотификации, когда статус выполнения вашей операции изменился.
    isFinished означает, что операция была успешно завершена или отменена. Пока свойство будет выставлено в false, операция будет находиться в operation queue. Если вы переопределяете метод start, вы также должны переопределить isFinished и отправлять kvo нотификации, когда ваша операция будет выполнена или отменена.
    isCancelled означает, что запрос об отмене операции был отправлен. Поддержку отмены операции вы должны реализовать самостоятельно.
"""
}
