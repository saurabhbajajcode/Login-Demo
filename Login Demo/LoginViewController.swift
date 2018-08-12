//
//  LoginViewController.swift
//  Login Demo
//
//  Created by Saurabh on 12/08/18.
//  Copyright © 2018 Saurabh. All rights reserved.
//

//
//  LoginViewController.swift
//  Craftsmen
//
//  Created by Macbook Air on 05/06/17.
//  Copyright © 2017 Promobi. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var msnTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        AppManager.setStatusBarBackgroundColor(color: UIColor.black)
        UIApplication.shared.statusBarStyle = .lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signInButtonTapped(_ sender: Any) {
        self.view.endEditing(true)

        guard let msnText = msnTextField.text?.trimmingCharacters(in: .whitespaces), msnText.isEmpty == false else {
            self.view.showToast(message: "Enter msn number.")
            return
        }

        // extract msn values from collection object
        let included = AppManager.collection["included"] as! [[String: Any]]
        let flatIncluded = included.compactMap( { $0["attributes"] } )  as? [[String: Any]]
        let msnArray = flatIncluded?.compactMap ({ $0["msn"] }) as? [String]
        if msnArray?.contains(msnText) == true {
            (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController?.view.showToast(message: "Login successfull")
            showHomeScene()
        }
    }

    // MARK: helpers
    private func showHomeScene() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeNavController = storyboard.instantiateViewController(withIdentifier: "homeScene")
        self.show(homeNavController, sender: self)
    }
}
