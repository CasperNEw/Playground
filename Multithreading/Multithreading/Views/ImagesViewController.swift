//
//  ImagesViewController.swift
//  Multithreading
//
//  Created by Дмитрий Константинов on 20.03.2020.
//  Copyright © 2020 Дмитрий Константинов. All rights reserved.
//

import UIKit

class ImagesViewController: UIViewController {

    var imageView = MyCollectionView()
    var images = [UIImage]()
    var label = UILabel()
    
    let imagesURLs = ["https://sun9-32.userapi.com/c628018/v628018189/43519/TsDPbkc84mI.jpg", "https://sun9-11.userapi.com/hlcgxAvinbasOxZNjTgQXy_FDORIN7dmwY6KEA/pBe2dcwzsrY.jpg", "https://sun9-69.userapi.com/kmyitAd-gqAzQ7izZy7fnEUqaOGKE9ugs35f2Q/_KkdA_sm9As.jpg", "https://sun9-11.userapi.com/hlcgxAvinbasOxZNjTgQXy_FDORIN7dmwY6KEA/pBe2dcwzsrY.jpg", "https://sun9-69.userapi.com/kmyitAd-gqAzQ7izZy7fnEUqaOGKE9ugs35f2Q/_KkdA_sm9As.jpg", "https://sun9-32.userapi.com/c628018/v628018189/43519/TsDPbkc84mI.jpg", "https://sun9-69.userapi.com/kmyitAd-gqAzQ7izZy7fnEUqaOGKE9ugs35f2Q/_KkdA_sm9As.jpg", "https://sun9-32.userapi.com/c628018/v628018189/43519/TsDPbkc84mI.jpg", "https://sun9-11.userapi.com/hlcgxAvinbasOxZNjTgQXy_FDORIN7dmwY6KEA/pBe2dcwzsrY.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        initImageView()
        initStatusLabel()
        asyncGroup()
        asyncUrlSession()
    }
    
    private func setupView() {
        self.title = "Load images async & group"
        self.view.backgroundColor = UIColor.gray
    }
    private func initImageView() {
        imageView = MyCollectionView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        imageView.center = view.center
        imageView.backgroundColor = UIColor.gray
        view.addSubview(imageView)
    }
    private func initStatusLabel() {
        label.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
        label.center = CGPoint(x: view.center.x, y: view.center.y - CGFloat(195))
        label.text = "Loading ..."
        label.textAlignment = .center
        label.backgroundColor = UIColor.gray
        label.textColor = UIColor.darkGray
        view.addSubview(label)
        
    }
    
    private func asyncLoadImage(imageURL: URL,
                                runQueue: DispatchQueue,
                                completionQueue: DispatchQueue,
                                completion: @escaping (UIImage?, Error?) -> ()) {
        runQueue.async {
            do {
                let data = try Data(contentsOf: imageURL)
                completionQueue.async { completion(UIImage(data: data), nil) }
            } catch let error {
                completionQueue.async { completion(nil, error) }
            }
        }
    }
    
    private func asyncGroup() {
        let aGroup = DispatchGroup()
        
        for index in 0...5 {
            guard let url = URL(string: imagesURLs[index]) else { return }
            aGroup.enter()
            asyncLoadImage(imageURL: url, runQueue: .global(), completionQueue: .main) { [weak self] (result, error) in
                guard let image = result else { return }
                self?.images.append(image)
                aGroup.leave()
            }
        }
        
        aGroup.notify(queue: .main) { [weak self] in
            for index in 0...5 {
                self?.imageView.imageViews[index].image = self?.images[index]
            }
            self?.label.isHidden = true
        }
    }
    
    private func asyncUrlSession() {
        for index in 6...8 {
            guard let url = URL(string: imagesURLs[index]) else { return }
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
                DispatchQueue.main.async {
                    guard let data = data else { return }
                    self?.imageView.imageViews[index].image = UIImage(data: data)
                }
            }
            task.resume()
        }
    }
}
