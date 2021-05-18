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
        
        delay(3) {
            self.loginAlert()
        }
    }
    
    fileprivate func fetchImage(){
        imageURL = URL(string: "https://eksmo.ru/upload/iblock/523/rick_morty_l_min.jpg")
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            guard let url = self.imageURL, let imageData = try? Data(contentsOf: url) else { return }
        
        DispatchQueue.main.async {
            self.image = UIImage(data: imageData)
            }
        }
    }
    
    fileprivate func loginAlert(){
        let ac = UIAlertController(title: "Зарегистрированы?", message: "Введите логин и пароль", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        ac.addAction(okAction)
        ac.addAction(cancelAction)
        
        ac.addTextField { (usernameTF) in
            usernameTF.placeholder = "Введите логин"
        }
        ac.addTextField { (userPasswordTF) in
            userPasswordTF.placeholder = "Введите пароль"
            userPasswordTF.isSecureTextEntry = true
        }
        self.present(ac, animated: true, completion: nil)
    }
    
    fileprivate func delay(_ delay: Int, closure: @escaping () -> ()){
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            closure()
        }
    }
}
