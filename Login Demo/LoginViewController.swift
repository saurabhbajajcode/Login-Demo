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

    var collection: [String: Any] = {
        if let path = Bundle.main.path(forResource: "collection", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                if let jsonResult = jsonResult as? [String: Any] {
                    return jsonResult
                }
            } catch {

            }
        }
        return [:]
    }()

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
        let included = collection["included"] as! [[String: Any]]
        let flatIncluded = included.compactMap( { $0["attributes"] } )  as? [[String: Any]]
        let msnArray = flatIncluded?.compactMap ({ $0["msn"] }) as? [String]
        if msnArray?.contains(msnText) == true {
            (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController?.view.showToast(message: "Login successfull")
        }
    }
 
    // MARK: UITextFieldDelegate methods
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        switch textField {
//        case (loginView?.emailTextField)!, (loginView?.passwordTextField)! :
//            textField.layer.borderWidth = 2
//
//        default: return true
//        }
        return true
    }



    // MARK: helpers
    private func saveLoginResponse() {
        // show home screen i.e. scanner screen from Main storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeNavigationController = storyboard.instantiateViewController(withIdentifier: "homeNavigationScene")
//        AppManager.hideLoading()
        DispatchQueue.main.async {
            self.present(homeNavigationController, animated: true, completion: nil)
        }
    }
}
