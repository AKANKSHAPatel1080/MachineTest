//
//  LoginVC.swift
//  MachineTest
//
//  Created by Akanksha Patel on 06/09/23.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var mobiletxt: UITextField!
        override func viewDidLoad() {
            super.viewDidLoad()
            // Additional setup if needed
        }

        @IBAction func loginButtonTapped(_ sender: UIButton) {
            // Perform mobile number validation
            if isValidMobileNumber() {
                // Mobile number is valid, navigate to NewsViewController
                navigateToNewsViewController()
            } else {
                // Display an error message to the user
                showAlert(message: "Invalid mobile number. Please enter a valid number.")
            }
        }

        func isValidMobileNumber() -> Bool {
            // Implement your mobile number validation logic here
            // You can use regular expressions or simple conditions
            // For simplicity, we'll check if it's not empty and has 10 digits
            if let mobileNumber = mobiletxt.text,
                mobileNumber.count == 10,
                mobileNumber.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil {
                return true
            }
            return false
        }

        func navigateToNewsViewController() {
            // Perform the navigation to NewsViewController here
            // You can use a segue or instantiate the view controller programmatically
            // Example using a storyboard segue (make sure it's set up in the storyboard):
            performSegue(withIdentifier: "NewsViewController", sender: self)
        }

        func showAlert(message: String) {
            let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
