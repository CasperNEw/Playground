//
//  AtomicOperation.swift
//  Multithreading
//
//  Created by Дмитрий Константинов on 14.03.2020.
//  Copyright © 2020 Дмитрий Константинов. All rights reserved.
//

import Foundation
//общие принципы реализации атомарных операций
class MyMemoryBarrier {
    //осторожно псевдокод, сильно упрощенный
    //метод MemoryBarrier обеспечивает выполнение операций 'после него', только после выполнения операций 'до него'
    class MyType {
        var valueOne: Int?
        var valueTwo: Int?
    }
    var myValue: MyType?
    
    func barrierTest() {
        let firstThread = Thread {
            let value = MyType()
            value.valueOne = 100
            value.valueTwo = 500
            OSMemoryBarrier()
            self.myValue = value
        }
        firstThread.start()
        
        let secondThread = Thread {
            while self.myValue == nil { }
            OSMemoryBarrier()
            print(self.myValue?.valueOne ?? "[Memory Barrier] error, I know that the value should not be nil, but it is nil ...")
        }
        secondThread.start()
    }
}
class MyAtomicOperation {
    //осторожно псевдокод, сильно упрощенный
    private func compareAndSwap(old: Int, new: Int, value: UnsafeMutablePointer<Int>) -> Bool {
        if value.pointee == old {
            value.pointee = new
            return true
        }
        return false
    }
    
    private func atomicAdd(amount: Int, value: UnsafeMutablePointer<Int>) -> Int {
        var success = false
        var new = 0
        
        while !success {
            let original = value.pointee
            new = original + amount
            success = compareAndSwap(old: original, new: new, value: value)
        }
        return new
    }
}

extension MyAtomicOperation {
    
    func atomicOperationTest(atomicValue: inout Int64, swapValue: Int64, addValue: Int64) {
        print("[AtomicOp] your start value - \(atomicValue)")
        OSAtomicCompareAndSwap64Barrier(atomicValue, swapValue, &atomicValue)
        print("[AtomicOp] after compare and swap with \(swapValue) - \(atomicValue)")
        OSAtomicAdd64Barrier(addValue, &atomicValue)
        print("[AtomicOp] after add \(addValue) - \(atomicValue)")
        OSAtomicIncrement64Barrier(&atomicValue)
        print("[AtomicOp] after increment method - \(atomicValue)")
    }
}
