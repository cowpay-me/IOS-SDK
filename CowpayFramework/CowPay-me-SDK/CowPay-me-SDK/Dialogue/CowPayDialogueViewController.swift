//
//  CowPayDialogueViewController.swift
//  CowPay-me-SDK
//
//  Created by Ahmed Hesham on 14/09/2021.
//

import UIKit

class CowPayDialogueViewController: UIViewController {

  var action: (() -> Void)?

    @IBOutlet weak var dialogueImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var titleText : String?
    var image: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        dialogueImage.image = image
        titleLabel.text = titleText
    }


    @IBAction func okAction(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            self?.dismiss(animated: true){
                self?.action?()
            }
        }
    }
    

}
