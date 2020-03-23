//
//  PhotoViewController.swift
//  Multithreading
//
//  Created by Дмитрий Константинов on 18.03.2020.
//  Copyright © 2020 Дмитрий Константинов. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    var button = UIButton()
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
        initFirstButton()
    }
    
    private func setupView() {
        self.title = "Hi! It's me %)"
        self.view.backgroundColor = UIColor.gray
        
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    private func initImage() {
        image.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        image.center = view.center
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        view.addSubview(image)
    }
    @objc func buttonAction() {
        let vc = ImagesViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    private func initFirstButton() {
        button.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
        button.center = view.center
        button.center = CGPoint(x: view.center.x, y: view.center.y + CGFloat(195))
        button.setTitle("Click me", for: .normal)
        button.backgroundColor = UIColor.darkGray
        button.layer.cornerRadius = 15
        button.setTitleColor(UIColor.white, for: .normal)
        view.addSubview(button)
    }
    
    private func loadPhoto() {
        loadPhotoWithData()
//        loadPhotoWithWorkItem()
//        loadPhotoWithUrlSession()
    }
}

extension PhotoViewController {
    //варианты методов загрузки фотографии из url
    private func loadPhotoWithData() {
        guard let url = imageURL else { return }
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            print("[LoadPhoto] load with Data - \(Thread.current)")
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async { [weak self] in
                    self?.image.image = UIImage(data: data)
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
        workItem.notify(queue: DispatchQueue.main) { [weak self] in
            if let imageData = data {
                self?.image.image = UIImage(data: imageData)
            }
        }
    }
    
    private func loadPhotoWithUrlSession() {
        guard let url = imageURL else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            print("[LoadPhoto] load with URLSession - \(Thread.current)")
            if let imageData = data {
                DispatchQueue.main.async { [weak self] in
                    self?.image.image = UIImage(data: imageData)
                }
            }
        }
        task.resume()
    }
}
