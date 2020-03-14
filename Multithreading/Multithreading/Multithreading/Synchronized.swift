//
//  Synchronized.swift
//  Multithreading
//
//  Created by Дмитрий Константинов on 14.03.2020.
//  Copyright © 2020 Дмитрий Константинов. All rights reserved.
//

import Foundation
//конструкция основана на recursive mutex, лучше испольщзовать его на прямую
class MySynchronized {
    //в качестве mutex используем NSObject
    private let lock = NSObject()
    
    func test() {
        objc_sync_enter(lock)
        //Do something
        objc_sync_exit(lock)
    }
}
