//
//  AddTaskViewController.swift
//  TodoListWithRxSwift
//
//  Created by Krystyna Kruchkovska on 9/25/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import RxSwift

class AddTaskViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: UIControl.State.selected)

    }
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {

        guard  let priority = Prionrity(rawValue: segmentedControl.selectedSegmentIndex), let title = textField.text else {
            return
        }
        let task = Task(title: title, priority: priority)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
