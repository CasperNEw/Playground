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
    /* //errors
    //создаем Unix поток
    var thread = pthread_t(bitPattern: 0)
    var attr = pthread_attr_t()
    
    pthread_attr_init(&attr)
    pthread_create(&thread, &attr, { pointer in
        print("test")
        return nil
        }, nil)
    
    //создаем поток NS поток, Objective-C обертка над Unix потоком
    var nsthread = Thread(block: {
        print("test")
    })
    nsthread.start()
    */
}

