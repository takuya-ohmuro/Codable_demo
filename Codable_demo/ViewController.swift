//
//  ViewController.swift
//  Codable_demo
//
//  Created by takuyaOhmuro on 2018/08/30.
//  Copyright © 2018年 takuyaOhmuro. All rights reserved.
//

import UIKit

struct  Post:Codable {
    
    let userId:Int?
    let id:Int?
    let title:String?
    let body:String?
}

class ViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        URLSession.shared.dataTask(with: url) { data,response,error in
            if let error = error {
                print("Error:\(error.localizedDescription)")
            }
            guard let httpsResponse = response as? HTTPURLResponse,httpsResponse.statusCode == 200 else {
                print("Error")
                return
            }
            guard let data = data else {
                print("Error")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let posts = try decoder.decode([Post].self, from: data)
                print(posts.map{ $0.title })
            }
            catch {
                print("Error:\(error.localizedDescription)")
                
            }
        }.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

