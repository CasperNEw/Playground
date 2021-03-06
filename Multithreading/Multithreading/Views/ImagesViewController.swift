//
//  ImagesViewController.swift
//  Multithreading
//
//  Created by Дмитрий Константинов on 20.03.2020.
//  Copyright © 2020 Дмитрий Константинов. All rights reserved.
//

import UIKit

class ImagesViewController: UIViewController {
    
    private var imageView = MyCollectionView()
    private var images = [UIImage]()
    private var label = UILabel()
    private var completedTestsCount = 0
    
    private let imagesURLs = ["https://sun9-32.userapi.com/c628018/v628018189/43519/TsDPbkc84mI.jpg", "https://sun9-11.userapi.com/hlcgxAvinbasOxZNjTgQXy_FDORIN7dmwY6KEA/pBe2dcwzsrY.jpg", "https://sun9-69.userapi.com/kmyitAd-gqAzQ7izZy7fnEUqaOGKE9ugs35f2Q/_KkdA_sm9As.jpg", "https://sun9-11.userapi.com/hlcgxAvinbasOxZNjTgQXy_FDORIN7dmwY6KEA/pBe2dcwzsrY.jpg", "https://sun9-69.userapi.com/kmyitAd-gqAzQ7izZy7fnEUqaOGKE9ugs35f2Q/_KkdA_sm9As.jpg", "https://sun9-32.userapi.com/c628018/v628018189/43519/TsDPbkc84mI.jpg", "https://sun9-69.userapi.com/kmyitAd-gqAzQ7izZy7fnEUqaOGKE9ugs35f2Q/_KkdA_sm9As.jpg", "https://sun9-32.userapi.com/c628018/v628018189/43519/TsDPbkc84mI.jpg", "https://sun9-11.userapi.com/hlcgxAvinbasOxZNjTgQXy_FDORIN7dmwY6KEA/pBe2dcwzsrY.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        initImageView()
        initStatusLabel()
        loadDataForImages()
    }
    
    private func setupView() {
        self.title = "Click me"
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
    
    private func loadDataForImages() {
        loadImagesWithDispatchGroup()
        loadImagesWithUrlSession()
        loadImagesWithOperation()
    }
    
    private func checkStatus() {
        completedTestsCount += 1
        if completedTestsCount == 3 {
            self.label.text = "Test completed"
        }
    }
    
    private func loadImagesWithDispatchGroup() {
        print("[LoadImages] DispatchGroup loading started")
        let aGroup = DispatchGroup()
        
        for index in 0...2 {
            guard let url = URL(string: imagesURLs[index]) else { return }
            aGroup.enter()
            asyncLoadImage(imageURL: url, runQueue: .global(), completionQueue: .main) { [weak self] (result, error) in
                guard let image = result else { return }
                self?.images.append(image)
                aGroup.leave()
            }
        }
        
        aGroup.notify(queue: .main) { [weak self] in
            for index in 0...2 {
                self?.imageView.imageViews[index].image = self?.images[index]
            }
            self?.checkStatus()
            print("[LoadImages] DispatchGroup loading completed")
        }
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
    
    private func loadImagesWithUrlSession() {
        print("[LoadImages] URLSession loading started")
        for index in 3...5 {
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
        checkStatus()
        print("[LoadImages] URLSession loading completed")
    }
    
    private func loadImagesWithOperation() {
        print("[LoadImages] Operation loading started")
        let queue = OperationQueue()

        for index in 6...8 {
            let operation = BlockOperation {
                guard let url = URL(string: self.imagesURLs[index]) else { return }
                guard let data = try? Data(contentsOf: url) else { return }
                guard let image = UIImage(data: data) else { return }
                OperationQueue.main.addOperation { self.imageView.imageViews[index].image = image }
            }
            queue.addOperation(operation)
        }
        checkStatus()
        print("[LoadImages] Operation loading completed")
    }
}
