//
//  Dependencies.swift
//  Multithreading
//
//  Created by Дмитрий Константинов on 21.03.2020.
//  Copyright © 2020 Дмитрий Константинов. All rights reserved.
//

import Foundation

class MyDependencies {
    
    private let operationQueue = OperationQueue()
    
    private let firstOperation = BlockOperation { print("[Dependencies] 1/5 block") }
    private let secondOperation = BlockOperation { print("[Dependencies] 2/5 block") }
    private let thirdOperation = BlockOperation { print("[Dependencies] 3/5 block, dependency to 1") }
    private let fourthOperation = BlockOperation { print("[Dependencies] 4/5 block") }
    private let fifthOperation = BlockOperation { print("[Dependencies] 5/5 block,dependency to 3") }
    
    func dependecies() {
        thirdOperation.addDependency(firstOperation)
        fifthOperation.addDependency(thirdOperation)
        operationQueue.addOperations([firstOperation, secondOperation, thirdOperation, fourthOperation, fifthOperation], waitUntilFinished: false)
    }
}
