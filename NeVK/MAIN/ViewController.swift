//
//  ViewController.swift
//  NeVK
//
//  Created by Mikhail Papullo on 11/23/21.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var enterButton: CustomShadow!
    @IBOutlet weak var VKLabel: CustomLabel!
    @IBOutlet var topImageView: UIImageView!
    @IBOutlet weak var bottomImage: UIImageView!
    @IBOutlet weak var loginLabel: CustomLabel!
    @IBOutlet weak var passwordLabel: CustomLabel!
    
    //MARK: - lifeCycle
    
    override func loadView() {
        super.loadView()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loginInput.layer.shadowColor = UIColor.black.cgColor
        loginInput.layer.shadowOpacity = 100
        passwordInput.layer.shadowColor = UIColor.black.cgColor
        passwordInput.layer.shadowOpacity = 100
        scrollView.delegate = self
        let hideKeyBoardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView.addGestureRecognizer(hideKeyBoardGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWasShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillBeHidden(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        runAnimate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let checkResult = checkUserData()
        
        if !checkResult {
            showLoginError()
        }
        
        loginInput.text = ""
        passwordInput.text = ""
        
        return checkResult
    }
    
    @IBAction func unwindvc(unwind: UIStoryboardSegue) {}
    
    @objc func hideKeyboard() {
        scrollView.endEditing(true)
        
    }
    
    @objc func keyboardWasShow(notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey:UIResponder.keyboardFrameEndUserInfoKey) as! NSValue) .cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    @objc func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
    }
}

//MARK: - UIScrollViewDelegate
extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.x = 0.0
    }
}
//MARK: - Animations
private extension ViewController {
    
    func runAnimate() {
        transitionAnimate()
        springAnimation()
        springInputLabelAnimation()
        springInputAnimation()
        springPasswordLabelAnimation()
        springPasswordAnimation()
        layerLoginLabelAnimation()
        layerLoginAnimation()
        layerPasswordLabelAnimation()
        layerPasswordAnimation()
        UIView.animate(withDuration: 1) {
            self.VKLabel.frame.origin.y += 50
        } completion: { _ in
            self.revertAnimate()
        }
    }
// Orange animation
    func revertAnimate() {
        UIView.animate(withDuration: 1,
                       delay: 2,
                       options: [.repeat, .autoreverse],
                       animations: {
            self.VKLabel.frame.origin.y -= 50
        },
                       completion: nil)
    }
//OrangeVK Label animation
    func transitionAnimate() {
        UIView.transition(from: bottomImage,
                          to: topImageView,
                          duration: 1,
                          options: [.transitionFlipFromRight, .repeat, .autoreverse],
                          completion: nil
        )
    }
    
    //LoginLabel animation
    func springInputLabelAnimation() {
        let animation = CASpringAnimation(keyPath: "position.x")
        animation.fromValue = loginInput.layer.position.x - 500
        animation.toValue = loginInput.layer.position.x
        animation.duration = 3
        animation.timingFunction = .init(name: .easeInEaseOut)
        animation.mass = 2
        animation.stiffness = 100
        loginLabel.layer.add(animation, forKey: nil)
    }
    
    func layerLoginLabelAnimation() {
        let animation = CABasicAnimation(keyPath: "shadowRadius")
        animation.fromValue = loginInput.layer.shadowRadius + 500
        animation.toValue = loginInput.layer.shadowRadius
        animation.duration = 1
        animation.beginTime = CACurrentMediaTime() + 0.5
        animation.fillMode = .both
        animation.isRemovedOnCompletion = false
        loginLabel.layer.add(animation, forKey: nil)
    }
   
    //Login Input animation
    func springInputAnimation() {
        let animation = CASpringAnimation(keyPath: "position.x")
        animation.fromValue = loginInput.layer.position.x + 500
        animation.toValue = loginInput.layer.position.x
        animation.duration = 3
        animation.timingFunction = .init(name: .easeInEaseOut)
        animation.mass = 2
        animation.stiffness = 100
        loginInput.layer.add(animation, forKey: nil)
    }
    
    func layerLoginAnimation() {
        let animation = CABasicAnimation(keyPath: "shadowRadius")
        animation.fromValue = loginInput.layer.shadowRadius + 200
        animation.toValue = loginInput.layer.shadowRadius
        animation.duration = 1
        animation.beginTime = CACurrentMediaTime() + 1
        animation.fillMode = .both
        animation.isRemovedOnCompletion = false
        loginInput.layer.add(animation, forKey: nil)
    }
    
    //Password Label animation
    func springPasswordLabelAnimation() {
        let animation = CASpringAnimation(keyPath: "position.x")
        animation.fromValue = loginInput.layer.position.x - 500
        animation.toValue = loginInput.layer.position.x
        animation.duration = 3
        animation.timingFunction = .init(name: .easeInEaseOut)
        animation.mass = 2
        animation.stiffness = 100
        passwordLabel.layer.add(animation, forKey: nil)
    }
    
    func layerPasswordLabelAnimation() {
        let animation = CABasicAnimation(keyPath: "shadowRadius")
        animation.fromValue = loginInput.layer.shadowRadius + 500
        animation.toValue = loginInput.layer.shadowRadius
        animation.duration = 1
        animation.beginTime = CACurrentMediaTime() + 1.5
        animation.fillMode = .both
        animation.isRemovedOnCompletion = false
        passwordLabel.layer.add(animation, forKey: nil)
    }
    
    //Password Input animation
    func springPasswordAnimation() {
        let animation = CASpringAnimation(keyPath: "position.x")
        animation.fromValue = loginInput.layer.position.x + 500
        animation.toValue = loginInput.layer.position.x
        animation.duration = 3
        animation.timingFunction = .init(name: .easeInEaseOut)
        animation.mass = 2
        animation.stiffness = 100
        passwordInput.layer.add(animation, forKey: nil)
    }
    
    func layerPasswordAnimation() {
        let animation = CABasicAnimation(keyPath: "shadowRadius")
        animation.fromValue = loginInput.layer.shadowRadius + 200
        animation.toValue = loginInput.layer.shadowRadius
        animation.duration = 1
        animation.beginTime = CACurrentMediaTime() + 2
        animation.fillMode = .both
        animation.isRemovedOnCompletion = false
        passwordInput.layer.add(animation, forKey: nil)
    }
    
    //Enter Button animation
    func springAnimation() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0
        animation.toValue = 1
        animation.stiffness = 200
        animation.mass = 2
        animation.duration = 2
        animation.beginTime = CACurrentMediaTime() + 1
        animation.fillMode = CAMediaTimingFillMode.backwards

        enterButton.layer.add(animation, forKey: nil)
        }
   //MARK: - Checking User data
    //Check User data
    func checkUserData() -> Bool {
        guard
            let login = loginInput.text,
            let password = passwordInput.text
        else {
            return false
        }
        
        if login == "admin" && password == "1234" {
            return true
        } else {
            return false
        }
    }

    //Login Password Error
    func showLoginError() {
        let alert = UIAlertController(title: "Ты не админ!",
                                      message: "Здесь тебе не место",
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
}

