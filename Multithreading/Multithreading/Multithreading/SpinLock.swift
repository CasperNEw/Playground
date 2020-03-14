//
//  SpinLock.swift
//  Multithreading
//
//  Created by Дмитрий Константинов on 13.03.2020.
//  Copyright © 2020 Дмитрий Константинов. All rights reserved.
//

import Foundation

//ресурсо затратный метод, можно сказать постоянный цикл while. не особо эффективен
//имеет смысл при малом количестве обращений и малом промежутке времени этих обращений
class MySpinLock {
    private var lock = OS_SPINLOCK_INIT
    
    func test() {
        OSSpinLockLock(&lock)
        //Do something
        OSSpinLockUnlock(&lock)
    }
}

//при использовании Unfair Lock доступ к ресурсу может получить произвольный поток, вне зависимости от порядка обращения
//предпочтение идет к потоку который обращается большее количество раз
//сокращает context switch, ресурсоемкий процесс по смене потока
class MyUnfairLock {
    private var lock = os_unfair_lock_s()
    
    func test() {
        os_unfair_lock_lock(&lock)
        //Do something
        os_unfair_lock_unlock(&lock)
    }
}
