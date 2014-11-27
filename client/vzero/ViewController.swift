//
//  ViewController.swift
//  vzero
//
//  Created by Messerschmidt, Tim on 16.11.14.
//  Copyright (c) 2014 Messerschmidt, Tim. All rights reserved.
//

import UIKit

class ViewController: UIViewController, BTDropInViewControllerDelegate {
    let manager: AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
    let serverBase = "http://127.0.0.1:3000"

    var braintree: Braintree?
    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var transactionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        getToken()
    }

    @IBAction func payClick(sender: AnyObject) {
        var dropInViewController: BTDropInViewController = braintree!.dropInViewControllerWithDelegate(self)
        dropInViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: Selector("userDidCancel"))
        
        //Customize the UI
        dropInViewController.summaryTitle = "A Braintree Mug"
        dropInViewController.summaryDescription = "Enough for a good cup of coffee"
        dropInViewController.displayAmount = "$10"

        var navigationController: UINavigationController = UINavigationController(rootViewController: dropInViewController)

        self.presentViewController(navigationController, animated: true, completion: nil)
    }

    func getToken() {
        manager.GET("\(serverBase)/token",
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) -> Void in
                var clientToken = responseObject["clientToken"] as String
                self.braintree = Braintree(clientToken: clientToken)
                self.payButton.userInteractionEnabled = true
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error.description)
        }
    }

    func postNonce(paymentMethodNonce: String) {
        var parameters = ["payment_method_nonce": paymentMethodNonce]

        manager.POST("\(serverBase)/payment",
            parameters: parameters,
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) -> Void in
                var transactionId : String = (responseObject["transaction"] as AnyObject!)["id"] as String
                self.transactionLabel.text = "Transaction ID: \(transactionId)"
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error.description)
        }
    }

    func userDidCancel() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    func dropInViewControllerDidCancel(viewController: BTDropInViewController!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    func dropInViewControllerWillComplete(viewController: BTDropInViewController!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    func dropInViewController(viewController: BTDropInViewController!, didSucceedWithPaymentMethod paymentMethod: BTPaymentMethod!) {
        postNonce(paymentMethod.nonce)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
