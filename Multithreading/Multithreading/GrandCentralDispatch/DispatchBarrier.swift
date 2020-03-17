//
//  DispatchBarrier.swift
//  Multithreading
//
//  Created by Дмитрий Константинов on 17.03.2020.
//  Copyright © 2020 Дмитрий Константинов. All rights reserved.
//

import Foundation

class MyDispatchBarrier {
    
    private let queue = DispatchQueue(label: "DispatchBarrier", attributes: .concurrent)
    private var value = 0
    
    //создаем сеттер для нашего значения с блокировкой доступа барьером
    func setValue(_ value: Int) {
        queue.async(flags: .barrier) {
            self.value = value
        }
    }
    //создаем геттер, которые не блокирует и не изменяет значения, то есть мы можем пользоваться им из разных потоков
    func getValue() -> Int {
        var tempValue = 0
        queue.sync {
            tempValue = self.value
        }
        return tempValue
    }
}
