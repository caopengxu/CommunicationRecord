//
//  DetailController.swift
//  通信录
//
//  Created by 曹鹏旭 on 16/7/25.
//  Copyright © 2016年 cpx. All rights reserved.
//

import UIKit

class DetailController: UITableViewController {

    var person: Person?
    var completionCallBack:(()->())?
    
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var titleTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if person != nil
        {
            nameTF.text = person?.name
            phoneTF.text = person?.phone
            titleTF.text = person?.title
        }
    }

    
    @IBAction func savePerson(_ sender: AnyObject)
    {
        if person == nil
        {
            person = Person()
        }
        
        person?.name = nameTF.text
        person?.phone = phoneTF.text
        person?.title = titleTF.text
        
        completionCallBack?()
        
        _ = navigationController?.popViewController(animated: true)
    }
    
}


