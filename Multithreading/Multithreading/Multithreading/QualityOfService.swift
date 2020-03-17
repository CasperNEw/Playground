//
//  QualityOfService.swift
//  Multithreading
//
//  Created by Дмитрий Константинов on 13.03.2020.
//  Copyright © 2020 Дмитрий Константинов. All rights reserved.
//

import Foundation
//Quality of Service * Качество обслуживания
class MyPthreadQos {
    
    func qosTest() {
        var thread = pthread_t(bitPattern: 0)
        var attribute = pthread_attr_t()
        pthread_attr_init(&attribute)
        //устанавливаем приоритет потока в атрибут
        pthread_attr_set_qos_class_np(&attribute, QOS_CLASS_USER_INITIATED, 0)
        //создаем поток
        pthread_create(&thread, &attribute, { pointer in
            print("[QoS] test in process")
            print("[QoS] self - \(qos_class_self())")
            //меняем приоритет нашего потока обращаясь к спец методу 'self'
            pthread_set_qos_class_self_np(QOS_CLASS_BACKGROUND, 0)
            print("[QoS] test completed")
            return nil
        }, nil)
    }
}

//проверка работы потоков с приоритетом
class MyThreadQos {
    
    func test() {
        //создаем поток
        let thread = Thread {
            print("[NS QoS] test in process")
            //распечатка приоритета текущего потока
            print("[NS QoS] self - \(qos_class_self())")
        }
        //определяем ему приоритет
        thread.qualityOfService = .userInteractive
        thread.start()
        print("[NS QoS] test completed")
    }
    
}
