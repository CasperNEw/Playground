//
//  ConcurrentPerform.swift
//  Multithreading
//
//  Created by Дмитрий Константинов on 16.03.2020.
//  Copyright © 2020 Дмитрий Константинов. All rights reserved.
//

import Foundation

class MyConcurrentPerform {
    //метод concurrentPerform автоматически раскидывает наши задачи по ядрам цп, позволяет эффективно использовать свободные ресурсы системы
    func perform() {
        DispatchQueue.concurrentPerform(iterations: 15) { (count) in
            print(count)
        }
    }
}
