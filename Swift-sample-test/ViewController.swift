//
//  ViewController.swift
//  Swift-sample-test
//
//  Created by apple on 26/03/21.
//

import UIKit
import ApplozicSwift
import ApplozicCore

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func launchchat(_ sender: Any) {
        let appId = ALChatManager.applicationId
        let alUser = ALUser()
        alUser.applicationId = appId
        alUser.userId = "testing464646"
        ALUserDefaultsHandler.setUserId(alUser.userId)
        alUser.password = "testing464646"
        ALUserDefaultsHandler.setPassword(alUser.password)
        alUser.authenticationTypeId = Int16(APPLOZIC.rawValue)
        ALUserDefaultsHandler.setUserAuthenticationTypeId(alUser.authenticationTypeId)
        self.view.isUserInteractionEnabled = false

        registerUserToApplozic(alUser: alUser)
    }
    /// login to applozic
    private func registerUserToApplozic(alUser: ALUser) {
        let alChatManager = ALChatManager(applicationKey: ALChatManager.applicationId as NSString)
        alChatManager.connectUser(alUser, completion: { response, error in
            self.view.isUserInteractionEnabled = true

            if error == nil {
                NSLog("[REGISTRATION] Applozic user registration was successful: %@ \(String(describing: response?.isRegisteredSuccessfully()))")
                /// launch chat list screen
                alChatManager.launchChatList(from: self, with: AppDelegate.config)
            } else {
                NSLog("[REGISTRATION] Applozic user registration error: %@", error.debugDescription)
            }
        })
    }

    @IBAction func logout(_ sender: Any) {
        let alChatManager = ALChatManager(applicationKey: ALChatManager.applicationId as NSString)
        view.isUserInteractionEnabled = false
        alChatManager.logoutUser { (success) in
            self.view.isUserInteractionEnabled = true

        }
    }

    // one to one chat
    @IBAction func oneToOne(_ sender: Any) {
        let alChatManager = ALChatManager(applicationKey: ALChatManager.applicationId as NSString)
        alChatManager.launchChatWith(contactId: "xyz1", from: self, configuration: AppDelegate.config)
    }

}

