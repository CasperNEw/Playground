//
//  Synchronization.swift
//  Multithreading
//
//  Created by Дмитрий Константинов on 13.03.2020.
//  Copyright © 2020 Дмитрий Константинов. All rights reserved.
//

import Foundation

class MyMutex {
    //создаем простейший unix mutex
    private var mutex = pthread_mutex_t()
    //обязательно инициализируем
    init() {
        pthread_mutex_init(&mutex, nil)
    }
    
    func mutexTest() {
        //захватываем ресурс
        pthread_mutex_lock(&mutex)
           //Do something
        //освобождаем ресурс
        pthread_mutex_unlock(&mutex)
    }
}

//создаем mutex используя возможности фреймворка Foundation
public class MyNSLock {
    private let lock = NSLock()
    
    func lockTest(i: Int) {
        lock.lock()
           //Do something
        lock.unlock()
    }
}
