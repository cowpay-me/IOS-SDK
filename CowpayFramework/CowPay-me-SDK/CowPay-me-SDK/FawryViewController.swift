//
//  FawryViewController.swift
//  CowPay-me-SDK
//
//  Created by Ahmed Hesham on 14/09/2021.
//

import UIKit

class FawryViewController: UIViewController {
    
    @IBOutlet weak var fawryCodeLabel: UILabel!
    @IBOutlet weak var fawryCodeDetailLabel: UILabel!
    var fawry:Fawry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        if let code = fawry?.paymentGatewayReferenceId{
            fawryCodeLabel.text = code
            fawryCodeDetailLabel.text = code
        }
    }
    

    @IBAction func copyAction(_ sender: Any) {
        UIPasteboard.general.string = fawryCodeLabel.text
        self.showDialogue(with: true, text: "copied".localized(), completion: {})
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        CowpaySDK.callback?.successByFawry(fawry: fawry)
        self.navigationController?.dismiss(animated: true, completion: nil)
//        let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
//        keyWindow?.dismiss()
    }
    
    func showDialogue(with Success: Bool  , text: String, completion: @escaping () -> Void) {
        let frameworkBundle = Bundle(identifier: "com.Cowpay-me.CowpayFramework")

        let dialogueVC = CowPayDialogueViewController(nibName: "CowPayDialogueViewController", bundle: frameworkBundle)
        dialogueVC.modalPresentationStyle = .overCurrentContext
        if Success {
            dialogueVC.image = UIImage(named: "ic_success", in: frameworkBundle,compatibleWith:nil)
        } else {
            dialogueVC.image = UIImage(named: "ic_warning",in: frameworkBundle,compatibleWith:nil)
        }
        dialogueVC.titleText = text
        dialogueVC.action = completion
        self.present(dialogueVC, animated: true, completion: nil)
    }
    
}
