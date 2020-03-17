//
//  Synchronization.swift
//  Multithreading
//
//  Created by Дмитрий Константинов on 13.03.2020.
//  Copyright © 2020 Дмитрий Константинов. All rights reserved.
//

import Foundation
//'работает в 15-20 раз быстрее чем GCD' (c)
class MyMutex {
    //mutex - защита объекта от доступа к нему из других потоков
    //создаем простейший unix mutex
    private var mutex = pthread_mutex_t()
    //обязательно инициализируем
    init() {
        pthread_mutex_init(&mutex, nil)
    }
    //Потоко защищенный метод
    func mutexTest(completion: () -> ()) {
        //захватываем ресурс
        pthread_mutex_lock(&mutex)
        //Do something
        completion()
        //используемый специальный механизм 'defer', который в случае какого либо 'несчастного случая' гарантированно освободит наш ресурс ( объект )
        defer {
            //освобождаем ресурс
            pthread_mutex_unlock(&mutex)
        }
        print()
    }
}

//создаем mutex используя возможности фреймворка Foundation, обертку Objective-C
public class MyNSLock {
    private let lock = NSLock()
    
    func lockTest(completion: () -> ()) {
        lock.lock()
        completion()
        defer {
            lock.unlock()
        }
        print()
    }
}
