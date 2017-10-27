//
//  ImageViewController.swift
//  Cassini
//
//  Created by Christopher Lee on 27/10/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    // MARK: Model
    var imageURL: URL? {
        didSet {
            image = nil
            
            if view.window != nil {
                fetchImage()
            }
        }
    }
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    // MARK: Private Implementation
    private func fetchImage() {
        if let url = imageURL {
            spinner.startAnimating()
            
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let urlContents = try? Data(contentsOf: url)
                
                if let imageData = urlContents, url == self?.imageURL {
                    DispatchQueue.main.async {
                        self?.image = UIImage(data: imageData)
                    }
                }
            }
        }
    }
    
    // MARK: View Controller Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if image == nil {
            fetchImage()
        }
    }
    
    // MARK: User Interface
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.03
            scrollView.maximumZoomScale = 1.0
            scrollView.contentSize = imageView.frame.size
            scrollView.addSubview(imageView)
        }
    }
    
    fileprivate var imageView = UIImageView()
    
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
            spinner?.stopAnimating()
        }
    }
}

extension ImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
