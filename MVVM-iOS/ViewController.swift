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
        let todoView = TodoView(frame: view.frame)
        todoView.todo = Todo(title: "first title", content: "hello world!")
        view.addSubview(todoView)
    }
}
