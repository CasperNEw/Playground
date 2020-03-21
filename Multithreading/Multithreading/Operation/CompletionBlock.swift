//
//  CompletionBlock.swift
//  Multithreading
//
//  Created by Дмитрий Константинов on 21.03.2020.
//  Copyright © 2020 Дмитрий Константинов. All rights reserved.
//

import Foundation

class MyCompletionBlock {
    private let operationQueue = OperationQueue()
    
    func completion() {
        print("[CompletionBlock] start test")
        let operation = BlockOperation {
            print("[CompletionBlock] execute")
        }
        operation.completionBlock = {
            print("[CompletionBlock] test completed")
        }
        operationQueue.addOperation(operation)
    }
}
