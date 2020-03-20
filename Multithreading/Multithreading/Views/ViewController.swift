//
//  ViewController.swift
//  Multithreading
//
//  Created by Дмитрий Константинов on 13.03.2020.
//  Copyright © 2020 Дмитрий Константинов. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var firstButton = UIButton()
    var secondButton = UIButton()
    var secondButtonIsReady = true
    var secondButtonPushTime = Date()
    var thirdButton = UIButton()
    var thirdButtonIsReady = true
    var thirdButtonPushTime = Date()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        initFirstButton()
        initSecondButton()
        initThirdButton()
    }
    
    private func multithreading() {
        startNotification()
        restartSecondButton()
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
        startNotification()
        restartThirdButton()
        
        let queue = DispatchQueue.global()
        queue.async { [weak self] in
            self?.queueTest()
            self?.dispatchAfterTest()
            self?.workItemTest()
            self?.semaphoreTest()
            self?.groupTest()
            self?.sourceTest()
        }
    }
}

extension ViewController {
    
    private func setupView() {
        self.title = "Introduction in GCD"
        self.navigationController?.navigationBar.barTintColor = UIColor.darkGray
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.view.backgroundColor = .gray
        
        firstButton.addTarget(self, action: #selector(firstButtonAction), for: .touchUpInside)
        secondButton.addTarget(self, action: #selector(secondButtonAction), for: .touchUpInside)
        thirdButton.addTarget(self, action: #selector(thirdButtonAction), for: .touchUpInside)
    }
    
    @objc func firstButtonAction() {
        let vc = PhotoViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func secondButtonAction() {
        secondButtonIsReady ? multithreading() : timeNotification(date: secondButtonPushTime)
    }
    @objc func thirdButtonAction() {
        thirdButtonIsReady ? grandCentralDispatch() : timeNotification(date: thirdButtonPushTime)
    }
    
    private func initFirstButton() {
        firstButton.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
        firstButton.center = view.center
        firstButton.setTitle("Load Image", for: .normal)
        firstButton.backgroundColor = UIColor.darkGray
        firstButton.layer.cornerRadius = 15
        firstButton.setTitleColor(UIColor.white, for: .normal)
        view.addSubview(firstButton)
    }
    private func initSecondButton() {
        secondButton.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
        secondButton.center = CGPoint(x: view.center.x, y: view.center.y + CGFloat(70))
        secondButton.setTitle("Multithreading tests", for: .normal)
        secondButton.backgroundColor = UIColor.darkGray
        secondButton.layer.cornerRadius = 15
        secondButton.setTitleColor(UIColor.white, for: .normal)
        view.addSubview(secondButton)
    }
    private func initThirdButton() {
        thirdButton.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
        thirdButton.center = CGPoint(x: view.center.x, y: view.center.y + CGFloat(140))
        thirdButton.setTitle("GCD tests", for: .normal)
        thirdButton.backgroundColor = UIColor.darkGray
        thirdButton.layer.cornerRadius = 15
        thirdButton.setTitleColor(UIColor.white, for: .normal)
        view.addSubview(thirdButton)
    }
    private func startNotification() {
        let alert = UIAlertController(title: "Notification", message: "The test restarts for 10 seconds, you can see the result in the console", preferredStyle: .actionSheet)
        alert.view.tintColor = .darkGray
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    private func timeNotification(date: Date) {
        let time = 10 - Int(Date().timeIntervalSince(date))
        let alert = UIAlertController(title: "Notification", message: "method will be available in \(time) seconds", preferredStyle: .actionSheet)
        alert.view.tintColor = .darkGray
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
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
    private func restartSecondButton() {
        secondButtonIsReady = false
        secondButtonPushTime = Date()
        let thread = Thread { [weak self] in
            sleep(10)
            self?.secondButtonIsReady = true
        }
        thread.start()
    }
}

extension ViewController {
    //GCD tests
    private func queueTest() {
        //[Queue ...]
        let queue = MyAsyncVsSyncTest()
        queue.specialTest()
    }
    private func dispatchAfterTest() {
        //[DispatchAfter]
        let dispatchAfter = MyDispatchAfter()
        dispatchAfter.afterTest()
    }
    private func workItemTest() {
        //[WorkItem]
        let workItem = MyDispatchWorkItem()
        workItem.something()
    }
    private func semaphoreTest() {
        //[Semaphore]
        let semaphore = MySemaphore()
        semaphore.signalTest()
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
    private func restartThirdButton() {
        thirdButtonIsReady = false
        thirdButtonPushTime = Date()
        let thread = Thread { [weak self] in
            sleep(10)
            self?.thirdButtonIsReady = true
        }
        thread.start()
    }
}
