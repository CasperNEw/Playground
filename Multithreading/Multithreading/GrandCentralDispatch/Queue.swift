//
//  Queue.swift
//  Multithreading
//
//  Created by Дмитрий Константинов on 16.03.2020.
//  Copyright © 2020 Дмитрий Константинов. All rights reserved.
//

import Foundation

class MyQueue {
    
    private let serialQueue = DispatchQueue(label: "Serial * Последовательная очередь")
    private let concurrentQueue = DispatchQueue(label: "Concurrent * Параллельная очередь", attributes: .concurrent)
    
    //получаем очередь из глобального пула очередей, все кроме main - параллельные
    //все глобальные очереди создаются системой и требуются для выполнения системных задач
    //не рекомендуется загружать глобальные очереди емкими, большими, задачами
    private let globalQueue = DispatchQueue.global()
    //main - serial global queue, главный поток
    private let mainQueue = DispatchQueue.main
}
