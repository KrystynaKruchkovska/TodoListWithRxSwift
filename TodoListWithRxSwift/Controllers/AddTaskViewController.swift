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

    private let taskSubject = PublishSubject<Task>()

    var taskSubjectObservable: Observable<Task> {
        return taskSubject.asObservable()
    }

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: UIControl.State.selected)

    }
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {

        guard  let priority = Priority(rawValue: segmentedControl.selectedSegmentIndex), let title = textField.text else {
            return
        }
        let task = Task(title: title, priority: priority)
        taskSubject.onNext(task)
        self.dismiss(animated: true, completion: nil)
    }


}
