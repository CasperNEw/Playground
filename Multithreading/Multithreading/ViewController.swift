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
        pthreadQosTest()
        recursiveTest()
        nsRecursiveTest()
        conditionTest()
        nsConditionTest()
    }
}

extension ViewController {
    private func pthreadQosTest() {
        //[QoS]
        let thread = MyPthreadQos()
        thread.qosTest()
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
        let condition = MyMutexCondition()
        // создаем свою очередь
        let queue = DispatchQueue(label: "com.condition.serialQueue")
        // описываем разные потоки
        let threads: [Thread] = [
            .init { condition.conditionTest() },
            .init { condition.signalToCondition() } ]
        // выполняем работу из очереди в разных потоках
        threads.forEach { thread in queue.sync { thread.start() }}
    }
    private func nsConditionTest() {
        //[NS_Cond]
        let condition = MyCondition()
        let queue = DispatchQueue(label: "com.nsCondition.serialQueue")
        let threads: [Thread] = [
            .init { condition.nsConditionTest() },
            .init { condition.signalToCondition() } ]
        threads.forEach { thread in queue.sync { thread.start() }}
    }
}

