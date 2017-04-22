//
//  ViewController.swift
//  FireBaseOneToOneChat
//
//  Created by Pushpam Group on 12/04/17.
//  Copyright © 2017 Pushpam Group. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var signinButton: UIButton!
    @IBOutlet var createAccountButton: UIButton!
    
    @IBOutlet var waringLabels: [UILabel]!
    @IBOutlet var inputFields: [UITextField]!
    
    @IBOutlet var wrongInputTextField: UILabel!
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return UIInterfaceOrientationMask.portrait
        }
    }
    
    
    //MARK: Push to relevant ViewController
    func pushTo(viewController: ViewControllerType)  {
        switch viewController {
        case .conversations:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "navigationViewController") as! NavigationViewController
            self.present(vc, animated: false, completion: nil)
        case .welcome:
           let vc = self.storyboard?.instantiateViewController(withIdentifier: "viewController") as! ViewController
           self.present(vc, animated: false, completion: nil)
        }
    }
    
//    //MARK: Check if user is signed in or not
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        if let userInformation = UserDefaults.standard.dictionary(forKey: "userInformation") {
//            let email = userInformation["email"] as! String
//            let password = userInformation["password"] as! String
//            User.loginUser(withEmail: email, password: password, completion: { [weak weakSelf = self] (status) in
//                DispatchQueue.main.async {
//                    if status == true {
//                        weakSelf?.pushTo(viewController: .conversations)
//                    } else {
//                        weakSelf?.pushTo(viewController: .welcome)
//                    }
//                    weakSelf = nil
//                }
//            })
//        } else {
//            self.pushTo(viewController: .welcome)
//        }
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        wrongInputTextField.isHidden =  true

    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        for textField in self.view.subviews where textField is UITextField {
            textField.resignFirstResponder()
        }
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true;
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true;
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true;
    }
    func pushTomainView() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "navigationViewController") as! NavigationViewController
        self.show(vc, sender: nil)
    }
    @IBAction func signinButtonClicked(_ sender: Any) {
        self.view.makeToastActivity()
        
        for item in self.inputFields {
            item.resignFirstResponder()
        }
 
        User.loginUser(withEmail: self.usernameTextField.text!, password: self.passwordTextField.text!) { [weak weakSelf = self](status) in
            DispatchQueue.main.async {
                
                for item in self.inputFields {
                    item.text = ""
                }
                if status == true {                    
                    self.view.hideToastActivity()
                    weakSelf?.pushTomainView()
                } else {
                    for item in (weakSelf?.waringLabels)! {
                        self.view.hideToastActivity()
                        item.isHidden = false
                    }
                }
                weakSelf = nil
            }
        }

        
    }
    @IBAction func createAccountButtonClicked(_ sender: Any) {
        
        self.performSegue(withIdentifier: "segueToUserRegisterViewController", sender: self)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

