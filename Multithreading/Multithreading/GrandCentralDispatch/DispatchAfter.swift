//
//  DispatchAfter.swift
//  Multithreading
//
//  Created by Дмитрий Константинов on 19.03.2020.
//  Copyright © 2020 Дмитрий Константинов. All rights reserved.
//

import Foundation

class MyDispatchAfter {
    
    func afterTest() {
        afterBlock(seconds: 3, queue: .global()) {
            print("[DispatchAfter] \(Thread.current)")
        }
    }
    
    private func afterBlock(seconds: Int, queue: DispatchQueue = DispatchQueue.global(), complition: @escaping ()->()) {
        queue.asyncAfter(deadline: .now() + .seconds(seconds)) {
            complition()
        }
    }
    
}
