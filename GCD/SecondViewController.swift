//
//  SecondViewController.swift
//  GCD
//
//  Created by Олеся Егорова on 18.05.2021.
//

import UIKit

class SecondViewController: UIViewController {
    
    fileprivate var imageURL: URL?
    fileprivate var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            
            imageView.image = newValue
            imageView.sizeToFit()
        }
    }

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchImage()

        // Do any additional setup after loading the view.
    }
    
    fileprivate func fetchImage(){
        imageURL = URL(string: "https://eksmo.ru/upload/iblock/523/rick_morty_l_min.jpg")
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        guard let url = imageURL, let imageData = try? Data(contentsOf: url) else { return }
        self.image = UIImage(data: imageData)
    }
}
