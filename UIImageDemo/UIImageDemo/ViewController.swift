//
//  ViewController.swift
//  UIImageDemo
//
//  Created by Josscii on 2017/9/2.
//  Copyright © 2017年 Josscii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let size = CGSize(width: 200, height: 100)
        let image = #imageLiteral(resourceName: "Lenna.png")
        
        // 用裁剪 image 的方法
        let drawImageImageView = BorderedImageView(image: image.clipTo(boundingSize: size, radius: 0))
        view.addSubview(drawImageImageView)
        
        drawImageImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        drawImageImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        drawImageImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        drawImageImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        // 用直接渲染 layer 的方法
        let drawLayerImageView = BorderedImageView(image: image.clipUseLayer(boundingSize: size, radius: 0))
        view.addSubview(drawLayerImageView)
        
        drawLayerImageView.topAnchor.constraint(equalTo: drawImageImageView.bottomAnchor, constant: 5).isActive = true
        drawLayerImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        drawLayerImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        drawLayerImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        // 直接 asepectFill 的方法
        let aspectFillImageView = BorderedImageView(image: #imageLiteral(resourceName: "Lenna.png"))
        aspectFillImageView.contentMode = .scaleAspectFill
        aspectFillImageView.clipsToBounds = true
        view.addSubview(aspectFillImageView)
        
        aspectFillImageView.topAnchor.constraint(equalTo: drawLayerImageView.bottomAnchor, constant: 5).isActive = true
        aspectFillImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        aspectFillImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        aspectFillImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
}

class BorderedImageView: UIImageView {
    override init(image: UIImage?) {
        super.init(image: image)
        
        layer.borderColor = UIColor.green.cgColor
        layer.borderWidth = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIImage {
    func clipUseLayer(boundingSize: CGSize, radius: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(boundingSize, false, 0)
        let context = UIGraphicsGetCurrentContext()!
        context.interpolationQuality = .low
        
        let imageLayer = CALayer()
        
        imageLayer.contentsGravity = "resizeAspectFill"
        imageLayer.cornerRadius = radius
        imageLayer.masksToBounds = true
        imageLayer.frame.size = boundingSize
        imageLayer.contents = self.cgImage
        
        imageLayer.render(in: context)
        
        let output = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return output
    }
    
    func clipTo(boundingSize: CGSize, radius: CGFloat) -> UIImage {
        // the size when image in imageview with contentmode of .aspectFill
        let fillSize = CGSize.aspectFill(aspectRatio: size, minimumSize: boundingSize)
        let originX = (boundingSize.width - fillSize.width)/2
        let originY = (boundingSize.height - fillSize.height)/2
        UIGraphicsBeginImageContextWithOptions(boundingSize, false, 0)
        let context = UIGraphicsGetCurrentContext()!
        context.interpolationQuality = .low
        // begin at (originX, originY), draw a fillSize image
        draw(in: CGRect(x: originX, y: originY, width: fillSize.width, height: fillSize.height))
        let output = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return output
    }
}

extension CGSize {
    static func aspectFit(aspectRatio : CGSize, boundingSize: CGSize) -> CGSize {
        var boundingSize = boundingSize
        let mW = boundingSize.width / aspectRatio.width;
        let mH = boundingSize.height / aspectRatio.height;
        
        if( mH < mW ) {
            boundingSize.width = boundingSize.height / aspectRatio.height * aspectRatio.width;
        }
        else if( mW < mH ) {
            boundingSize.height = boundingSize.width / aspectRatio.width * aspectRatio.height;
        }
        
        return boundingSize;
    }
    
    static func aspectFill(aspectRatio :CGSize, minimumSize: CGSize) -> CGSize {
        var minimumSize = minimumSize
        let mW = minimumSize.width / aspectRatio.width;
        let mH = minimumSize.height / aspectRatio.height;
        
        if( mH > mW ) {
            minimumSize.width = minimumSize.height / aspectRatio.height * aspectRatio.width;
        }
        else if( mW > mH ) {
            minimumSize.height = minimumSize.width / aspectRatio.width * aspectRatio.height;
        }
        
        return minimumSize;
    }
}
