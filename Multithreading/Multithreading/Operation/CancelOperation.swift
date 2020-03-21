//
//  CancelOperation.swift
//  Multithreading
//
//  Created by Дмитрий Константинов on 21.03.2020.
//  Copyright © 2020 Дмитрий Константинов. All rights reserved.
//

import Foundation

class MyOperationCancel {
    
    private let operationQueue = OperationQueue()
    
    class SpecialOperation: Operation {
        //если дошли до main(), то для реализации cancel() необходимо реализовать переодические проверки состояния
        override func main() {
            print("[CancelOperation] start test 'cancel'")
            if isCancelled {
                print("[CancelOperation] first cancellation check worked")
                return
            }
            sleep(1)
            if isCancelled {
                print("[CancelOperation] second cancellation check worked")
                return
            }
            print("[CancelOperation] ERROR cancellation check not worked")
        }
    }
    
    func cancelOperation() {
        let cancelOperation = SpecialOperation()
        operationQueue.addOperation(cancelOperation)
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.3) {
            cancelOperation.cancel()
        }
    }
}
