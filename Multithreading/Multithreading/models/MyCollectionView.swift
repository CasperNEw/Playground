//
//  MyCollectionView.swift
//  Multithreading
//
//  Created by Дмитрий Константинов on 20.03.2020.
//  Copyright © 2020 Дмитрий Константинов. All rights reserved.
//

import UIKit

class MyCollectionView: UIView {
    public var imageViews = [UIImageView]()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageViews.append(UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100)))
        imageViews.append(UIImageView(frame: CGRect(x: 100, y: 0, width: 100, height: 100)))
        imageViews.append(UIImageView(frame: CGRect(x: 200, y: 0, width: 100, height: 100)))
        imageViews.append(UIImageView(frame: CGRect(x: 0, y: 100, width: 100, height: 100)))
        imageViews.append(UIImageView(frame: CGRect(x: 100, y: 100, width: 100, height: 100)))
        imageViews.append(UIImageView(frame: CGRect(x: 200, y: 100, width: 100, height: 100)))
        imageViews.append(UIImageView(frame: CGRect(x: 0, y: 200, width: 100, height: 100)))
        imageViews.append(UIImageView(frame: CGRect(x: 100, y: 200, width: 100, height: 100)))
        imageViews.append(UIImageView(frame: CGRect(x: 200, y: 200, width: 100, height: 100)))
        
        if imageViews.isEmpty { return }
        for index in 0...(imageViews.count - 1) {
            imageViews[index].contentMode = .scaleAspectFill
            imageViews[index].layer.cornerRadius = 50
            imageViews[index].clipsToBounds = true
            self.addSubview(imageViews[index])
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
