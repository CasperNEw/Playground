//
//  SecondViewController.swift
//  Multithreading
//
//  Created by Дмитрий Константинов on 18.03.2020.
//  Copyright © 2020 Дмитрий Константинов. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    var image = UIImageView()
    let imageURL = URL(string: "https://sun9-21.userapi.com/c626216/v626216189/66049/yxQ32rgkQnk.jpg")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loadPhoto()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        initImage()
    }
    
    private func setupView() {
        self.title = "Hi! It's me %)"
        self.view.backgroundColor = UIColor.gray
    }
    
    private func initImage() {
        image.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        image.center = view.center
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        view.addSubview(image)
    }
    
    private func loadPhoto() {
        loadPhotoWithData()
//        loadPhotoWithWorkItem()
//        loadPhotoWithUrlSession()
    }
}

extension SecondViewController {
    //варианты методов загрузки фотографии из url
    private func loadPhotoWithData() {
        guard let url = imageURL else { return }
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            print("[LoadPhoto] load with Data - \(Thread.current)")
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self.image.image = UIImage(data: data)
                }
            }
        }
    }
    
    private func loadPhotoWithWorkItem() {
        guard let url = imageURL else { return }
        var data: Data?
        let queue = DispatchQueue.global(qos: .utility)
        
        let workItem = DispatchWorkItem(qos: .userInteractive) {
            data = try? Data(contentsOf: url)
            print("[LoadPhoto] load with WorkItem - \(Thread.current)")
        }
        
        queue.async(execute: workItem)
        workItem.notify(queue: DispatchQueue.main) {
            if let imageData = data {
                self.image.image = UIImage(data: imageData)
            }
        }
    }
    
    private func loadPhotoWithUrlSession() {
        guard let url = imageURL else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            print("[LoadPhoto] load with URLSession - \(Thread.current)")
            if let imageData = data {
                DispatchQueue.main.async {
                    self.image.image = UIImage(data: imageData)
                }
            }
        }
        task.resume()
    }
}
