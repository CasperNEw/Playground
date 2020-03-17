//
//  ReadWriteLock.swift
//  Multithreading
//
//  Created by Дмитрий Константинов on 13.03.2020.
//  Copyright © 2020 Дмитрий Константинов. All rights reserved.
//

import Foundation

//Unix реализация Read Write Lock, Foudation не предоставляет нам свою реализацию данного "метода"
class MyReadWriteLock {
    private var lock = pthread_rwlock_t()
    private var attr = pthread_rwlockattr_t()
    
    private var value = 0
    
    init() {
        pthread_rwlock_init(&lock, &attr)
    }
    
    //пример работы RWL на обращении к свойству класса
    public var readWriteProperty: Int {
        get {
            //блокируем на запись
            pthread_rwlock_rdlock(&lock)
            let tempValue = value
            pthread_rwlock_unlock(&lock)
            return tempValue
        }
        set {
            //блокируем на запись и чтение
            pthread_rwlock_wrlock(&lock)
            value = newValue
            pthread_rwlock_unlock(&lock)
        }
    }
}
