//
//  ViewController.swift
//  通信录
//
//  Created by 曹鹏旭 on 16/7/25.
//  Copyright © 2016年 cpx. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var personList = [Person]()
    
    
    // MARK:=== viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 加载数据
        loaddata { (list) in
            
            print(list)
            self.personList += list
            
            self.tableView.reloadData()
        }
    }
    
    
    // MARK: === 添加数据
    @IBAction func addPerson(_ sender: AnyObject)
    {
        performSegue(withIdentifier: "detail", sender: nil)
    }
    
    
    // MARK: === 模拟异步，利用闭包回调
    private func loaddata(completion:(list:[Person])->()) -> () {
        
        DispatchQueue.global().async {
            
            print("正在努力加载中...")
            
            Thread.sleep(forTimeInterval: 1)
            
            var arrayM = [Person]()
            
            for i in 0..<20
            {
                let p = Person()
                
                p.name = "zhangsan - \(i)"
                p.phone = "18600" + String(format:"%06d", arc4random_uniform(1000000))
                p.title = "boss"
                
                arrayM.append(p)
            }
            
            // 主线程回调
            DispatchQueue.main.async(execute: {
                
                completion(list: arrayM)
            })
        }
    }
    
    
    // MARK: === <UITableViewDataSource, UITableViewDelegate>
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1;
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return personList.count;
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = personList[indexPath.row].name
        cell.detailTextLabel?.text = personList[indexPath.row].phone
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "detail", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let vc = segue.destinationViewController as! DetailController
        
        if let indexPath = sender as? IndexPath
        {
            vc.person = personList[indexPath.row]
            
            vc.completionCallBack = {
            
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
        else
        {
            vc.completionCallBack = {
                
                guard let p = vc.person else {
                    return
                }
                
                self.personList.insert(p, at: 0)
                
                self.tableView.reloadData()
            }
        }
    }
}


