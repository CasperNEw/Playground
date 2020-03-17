//
//  TargetQueueHierarchy.swift
//  Multithreading
//
//  Created by Дмитрий Константинов on 17.03.2020.
//  Copyright © 2020 Дмитрий Константинов. All rights reserved.
//

import Foundation

//Target Queue дает возможность уменьшить количество переключений, content switch. Обязательно должна быть serial
class MyTargetQueue {
    private let targetQueue = DispatchQueue(label: "TargetQueue")
    
    func optimization() {
        let firstQueue = DispatchQueue(label: "FirstQueueInTarget", target: targetQueue)
        let firstSource = DispatchSource.makeTimerSource(queue: firstQueue)
        firstSource.setEventHandler {
            print("[TargetQueue] start first queue")
        }
        firstSource.activate()
        
        let secondQueue = DispatchQueue(label: "SecondQueueInTarget", target: targetQueue)
        let secondSource = DispatchSource.makeTimerSource(queue: secondQueue)
        secondSource.setEventHandler {
            print("[TargetQueue] start second queue")
        }
        secondSource.activate()
    }
}
