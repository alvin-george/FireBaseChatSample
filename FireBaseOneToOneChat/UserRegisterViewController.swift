//
//  UserRegisterViewController.swift
//  FireBaseOneToOneChat
//
//  Created by Pushpam Group on 12/04/17.
//  Copyright © 2017 Pushpam Group. All rights reserved.
//

import UIKit

class UserRegisterViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet var inputFields: [UITextField]!
    @IBOutlet var waringLabels: [UILabel]!
    
    @IBOutlet var profilePicView: UIImageView!
    @IBOutlet var registerEmailField: UITextField!
    @IBOutlet var registerNameField: UITextField!
    @IBOutlet var registerPasswordField: UITextField!
    @IBOutlet var wrongInputLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wrongInputLabel.isHidden =  true

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

    @IBAction func registerNowButton(_ sender: Any) {
        
        for item in self.inputFields {
            item.resignFirstResponder()
        }
        
        self.view.makeToastActivity()

        User.registerUser(withName: self.registerNameField.text!, email: self.registerEmailField.text!, password: self.registerPasswordField.text!, profilePic: self.profilePicView.image!) {[weak weakSelf = self] (status) in
            
            DispatchQueue.main.async {
                for item in self.inputFields {
                    item.text = ""
                }
                if status == true {
                    self.view.hideToastActivity()
                    weakSelf?.pushTomainView()
                    weakSelf?.profilePicView.image = UIImage.init(named: "profile pic")
                } else {
                    for item in (weakSelf?.waringLabels)! {
                        self.view.hideToastActivity()
                        item.isHidden = false
                    }
                }
            }
        }

    }
    func pushTomainView() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "navigationViewController") as! NavigationViewController
        self.show(vc, sender: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
