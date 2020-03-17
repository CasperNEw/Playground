//
//  DispatchSource.swift
//  Multithreading
//
//  Created by Дмитрий Константинов on 17.03.2020.
//  Copyright © 2020 Дмитрий Константинов. All rights reserved.
//

import Foundation

class MyDispatchSource {
    
    private let timerSource = DispatchSource.makeTimerSource()
    private let userDataAddSource = DispatchSource.makeUserDataAddSource(queue: DispatchQueue.main)
    
    init() {
        userDataAddSource.setEventHandler {
            print("[UserDataSource] \(self.userDataAddSource.data)")
        }
        userDataAddSource.activate()
    }

    
    func notify() {
        timerSource.setEventHandler {
            print("[TimerSource] Hello, I'm timer, it's repeated every 3 second")
        }
        timerSource.setCancelHandler {
            print("[TimerSource] Timer canceled")
        }
        
        timerSource.schedule(deadline: .now(), repeating: 3)
        timerSource.activate()
        
        DispatchQueue.global().async {
            sleep(7)
            self.timerSource.cancel()
        }
    }
    
    func addData(count: UInt8) {
        for _ in 0..<count {
            sleep(2)
            DispatchQueue.global().async {
                self.userDataAddSource.add(data: 10) //?
            }
        }
    }
    
    //Timer - тип Dispatch source генерирующий переодические нотификации
    //Signal - тип Dispatch source взаимодействующий с unix-сигналами
    //Descriptor - тип Dispatch source оповещающий о том, что с файлом были произведены различные операции
    //Process - тип Dispatch source позволяющий слушать события процесса
    
}
