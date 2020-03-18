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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Hi! It's me %)"
        self.view.backgroundColor = UIColor.gray
        
        loadPhoto()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        initImage()
    }
    
    private func initImage() {
        image.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        image.center = view.center
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        view.addSubview(image)
    }
    
    private func loadPhoto() {
        guard let imageURL: URL = URL(string: "https://sun9-21.userapi.com/c626216/v626216189/66049/yxQ32rgkQnk.jpg") else { return }
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            if let data = try? Data(contentsOf: imageURL) {
                DispatchQueue.main.async {
                    self.image.image = UIImage(data: data)
                    self.image.contentMode = .scaleAspectFill
                }
            }
        }
        
    }

}
