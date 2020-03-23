//
//  AsyncOperation.swift
//  Multithreading
//
//  Created by Дмитрий Константинов on 21.03.2020.
//  Copyright © 2020 Дмитрий Константинов. All rights reserved.
//

import Foundation
//Простейший пример реализации асинхронной операции, необходимые переопределения методов и свойств
class MyAsyncOperation: Operation {
    
    private let queue = DispatchQueue(label: "AsyncOperation")
    private var execute = false
    private var finish = false
    
    override var isAsynchronous: Bool { return true }
    override var isExecuting: Bool { return execute }
    override var isFinished: Bool { return finish }
    
    override func start() {
        print("[AsyncOperation] operation start")
        //добавляем поддержку KVO
        willChangeValue(forKey: "isExecuting")
        queue.async {
            self.main()
        }
        execute = true
        didChangeValue(forKey: "isExecuting")
    }
    
    override func main() {
        print("[AsyncOperation] operation completed")
        willChangeValue(forKey: "isFinished")
        willChangeValue(forKey: "isExecuting")
        execute = false
        finish = true
        didChangeValue(forKey: "isFinished")
        didChangeValue(forKey: "isExecuting")
    }
}
