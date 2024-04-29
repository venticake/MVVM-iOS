//
//  ViewController.swift
//  MVVM-iOS
//
//  Created by BYUNGWOOK JEONG on 4/29/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let todoView = TODOView(frame: view.frame)
        todoView.todo = TODO(title: "first title", content: "hello world!")
        view.addSubview(todoView)
    }
}
