//
//  Deadlock.swift
//  Multithreading
//
//  Created by Дмитрий Константинов on 14.03.2020.
//  Copyright © 2020 Дмитрий Константинов. All rights reserved.
//

import Foundation
//Deadlock (взаимная блокировка потоков, в итоге зависание) , Livelock (оба потока выполняют бесполезную работу)
//Priority inversion (низкоприоритетный поток захватывает ресурс, остальные потоки ждут)
class MyDeadlock {
    let firstLock = NSLock()
    let secondLock = NSLock()
    var firstResource = false
    var secondResource = false
}

class MyDeadlockTest {
    func deadlockTest() {
        //[Deadlock]
        let deadlock = MyDeadlock()
        print("[Deadlock] test in process")
        let firstThread = Thread(block: {
            deadlock.firstLock.lock()
            print("[Deadlock] firstThread firstLock lock()")
            deadlock.firstResource = true
            deadlock.secondLock.lock()
            print("[Deadlock] firstThread secondLock lock()")
            deadlock.secondResource = true
            deadlock.secondLock.unlock()
            print("[Deadlock] firstThread secondLock unlock()")
            deadlock.firstLock.unlock()
            print("[Deadlock] firstThread firstLock unlock()")
        })
        firstThread.start()
        
        let secondThread = Thread(block: {
            deadlock.secondLock.lock()
            print("[Deadlock] secondThread secondLock lock()")
            deadlock.secondResource = true
            deadlock.firstLock.lock()
            print("[Deadlock] secondThread firstLock lock()")
            deadlock.firstResource = true
            deadlock.firstLock.unlock()
            print("[Deadlock] secondThread firstLock unlock()")
            deadlock.secondLock.unlock()
            print("[Deadlock] secondThread secondLock unlock()")
            print("[Deadlock] test completed, u are lucky")
        })
        secondThread.start()
    }
    
    let issuesString = """
    ~ Проблемы многопоточности ~

    - Race condition / Условия гонки, несколько потоков работает с одними и теме же данными, в результате чего сами данные становятся непредсказуемыми и зависят от порядка выполнения потоков
    - Resource contention / Конкуренция за ресурс, несколько потоков, выполняющих разные задачи, пытаются получить доступ к одному ресурсу, тем самым увеличивая время необходимое для безопасного получения ресурса. Эта задержка может привести к непредвиденному поведению.
    - Deadlock / Вечная блокировка, Несколько оптоков блокируют друг друга
    - Starvation / Голодание, поток не может получиться доступ к ресурсу и безуспешно пытается сделать это снова и снова
    - Priority Inversion / Инверсия приоритетов, поток с низким приоритетом удерживает ресурс, который требуется другому потоку, с более высоким приоритетом
    - Non-deterministic and Fairness / Неопределенность и справедливость, мы не можем делать предположений, когда и в каком порядке поток сможет получить ресурс, эта задержка не может быть определена априори и в значительной степени зависит от количества конфликтов. Однако, примитивы синхронизации могут обеспечивать справедливость, гарантируя доступ всем потокам которые ожидают, также учитывая порядок
    """
}


