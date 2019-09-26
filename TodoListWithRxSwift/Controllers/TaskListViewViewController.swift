//
//  TaskListViewViewController.swift
//  TodoListWithRxSwift
//
//  Created by Krystyna Kruchkovska on 9/25/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TaskListViewViewController: UIViewController {

    private let disposeBag = DisposeBag()
    private let tasks = BehaviorRelay<[Task]>(value:[])
    private var filteredTasks = [Task]()

    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        // Do any additional setup after loading the view.
    }


    // MARK: - Navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nc = segue.destination as? UINavigationController,
         let addTaskVc = nc.viewControllers.first as? AddTaskViewController else {
             fatalError("line \(#line) faild")
         }

        addTaskVc.taskSubjectObservable
            .subscribe(onNext: { [weak self] task in

                guard let weakSelf = self else { return }

                let priority = Priority(rawValue: weakSelf.prioritySegmentedControl.selectedSegmentIndex - 1)

                var existingTasks = weakSelf.tasks.value
                existingTasks.append(task)
                weakSelf.tasks.accept(existingTasks)

                weakSelf.filterTasks(by: priority)
            }).disposed(by: disposeBag)
     }

    private func filterTasks(by priority: Priority?) {

        if priority == nil {
            self.filteredTasks = self.tasks.value
            updateTableView()
        } else {
            self.tasks.map { tasks in
                return tasks.filter { $0.priority == priority }
            }.subscribe(onNext: { [weak self] tasks in
                self?.filteredTasks = tasks
                self?.updateTableView()
                }).disposed(by: disposeBag)
        }
    }

    private func updateTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }

    @IBAction func priorityValueChanged(_ sender: UISegmentedControl) {

        let priority = Priority(rawValue: sender.selectedSegmentIndex - 1)
        filterTasks(by: priority)
    }

}

extension TaskListViewViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

         let cell = tableView.dequeueReusableCell(withIdentifier: "TaskListViewViewCell", for: indexPath)

        cell.textLabel?.text = filteredTasks[indexPath.row].title

        return cell
    }


}
