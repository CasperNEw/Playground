//
//  DispatchIO.swift
//  Multithreading
//
//  Created by Дмитрий Константинов on 17.03.2020.
//  Copyright © 2020 Дмитрий Константинов. All rights reserved.
//

import Foundation

//API для взаимодействия с файловой системой
class MyDispatchIO {
    private let queue = DispatchQueue(label: "DispatchIO", attributes: .concurrent)
    private var channel: DispatchIO? //descriptor?
    
    func test() {
        guard let filePath = Bundle.main.path(forResource: "file", ofType: "txt") else { return }
        channel = DispatchIO(type: DispatchIO.StreamType.stream, path: filePath, oflag: O_RDONLY, mode: 0, queue: DispatchQueue.global(), cleanupHandler: { (error) in
            //Handle error
        })
        channel?.read(offset: 0, length: Int.max, queue: queue) { (done, data, error) in
            if data != nil {
                //Handle data
            }
            if error != 0 {
                //Handle error
            }
        }
    }
}
