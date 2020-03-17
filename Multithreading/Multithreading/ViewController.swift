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
        grandCentralDispatch()
        
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
    
    private func grandCentralDispatch() {
        //queueTest()
        //workItemTest()
        //semaphoreTest()
        //groupTest()
        sourceTest()
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
        recursive.start()
    }
    private func conditionTest() {
        //[Cond]
        let conditionPrinter = MyMutexConditionPrinter()
        let conditionWriter = MyMutexConditionWriter()
        conditionPrinter.start()
        conditionWriter.start()
    }
    private func nsConditionTest() {
        //[NS_Cond]
        let conditionPrinter = MyConditionPrinter()
        let conditionWriter = MyConditionWriter()
        conditionPrinter.start()
        conditionWriter.start()
    }
    private func deadlockTest() {
        //[Deadlock]
        let deadlock = MyDeadlockTest()
        deadlock.deadlockTest()
        //MARK: major multithreading issues
        //print(deadlock.issuesString)
    }
    private func atomicOperationTest() {
        //[AtomicOp]
        let atomic = MyAtomicOperation()
        var atomicValue: Int64 = 33
        atomic.atomicOperationTest(atomicValue: &atomicValue, swapValue: 22, addValue: 14)
    }
}

extension ViewController {
    //GCD tests
    private func queueTest() {
        //[Queue ...]
        let queue = MyAsyncVsSyncTest()
        queue.specialTest()
    }
    private func workItemTest() {
        //[WorkItem]
        let workItem = MyDispatchWorkItem()
        workItem.something()
    }
    private func semaphoreTest() {
        //[Semaphore]
        let semaphore = MySemaphore()
        //semaphore.signalTest()
        semaphore.threadCountTest()
    }
    private func groupTest() {
        //[DispatchGroup]
        let group = MyDispatchGroup()
        group.groupTest()
    }
    private func sourceTest() {
        //[TimerSource]
        let source = MyDispatchSource()
        source.notify()
        source.addData(count: 3)
    }
    
}
