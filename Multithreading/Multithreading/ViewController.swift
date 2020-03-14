//
//  ViewController.swift
//  Multithreading
//
//  Created by Дмитрий Константинов on 13.03.2020.
//  Copyright © 2020 Дмитрий Константинов. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //     multithreading()
    }
    
    private func multithreading() {
        threadTest()
        qosTest()
        recursiveTest()
        nsRecursiveTest()
        conditionTest()
        nsConditionTest()
        deadlockTest()
        atomicOperationTest()
    }
}

extension ViewController {
    //Multithreading tests
    private func threadTest() {
        //[Thread] & [NSThread]
        let thread = MyThread()
        thread.threadTests()
    }
    private func qosTest() {
        //[QoS] & [NS QoS]
        let thread = MyPthreadQos()
        thread.qosTest()
        let nsthread = MyThreadQos()
        nsthread.test()
    }
    private func recursiveTest() {
        //[R_Lock]
        let recursive = MyRecursiveMutex()
        recursive.recursiveTest()
    }
    private func nsRecursiveTest() {
        //[NSR_Lock]
        let recursive = MyRecursiveLock()
        recursive.nsRecursiveTest()
    }
    private func conditionTest() {
        //[Cond]
        let condition = MyConditionTest()
        condition.conditionTest()
    }
    private func nsConditionTest() {
        //[NS_Cond]
        let condition = MyConditionTest()
        condition.nsConditionTest()
    }
    private func deadlockTest() {
        //[Deadlock]
        let deadlock = MyDeadlockTest()
        deadlock.deadlockTest()
    }
    private func atomicOperationTest() {
        //[AtomicOp]
        let atomic = MyAtomicOperation()
        var atomicValue: Int64 = 33
        atomic.atomicOperationTest(atomicValue: &atomicValue, swapValue: 22, addValue: 14)
    }
}

