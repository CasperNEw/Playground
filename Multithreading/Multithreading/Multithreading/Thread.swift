//
//  Thread.swift
//  Multithreading
//
//  Created by Дмитрий Константинов on 13.03.2020.
//  Copyright © 2020 Дмитрий Константинов. All rights reserved.
//

//простейшее создание потока

import Foundation

class MyThread {
    
    func threadTests() {
        //создаем Unix поток, Unix - POSIX
        var thread = pthread_t(bitPattern: 0)
        var attribute = pthread_attr_t()
        
        pthread_attr_init(&attribute)
        pthread_create(&thread, &attribute, { (pointer) -> UnsafeMutableRawPointer? in
            print("[Thread] test in progress")
            return nil
        }, nil)
        
    //создаем NS поток, Objective-C обертка над Unix потоком
        let nsthread = Thread {
        print("[NSThread] test in progress")
    }
        nsthread.start()
        print("[Thread] test completed")
        print("[NSThread] test completed")
    }
}

