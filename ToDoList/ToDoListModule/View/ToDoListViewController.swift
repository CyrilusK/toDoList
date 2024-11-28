//
//  ToDoListViewController.swift
//  ToDoList
//
//  Created by Cyril Kardash on 25.11.2024.
//

import UIKit

final class ToDoListViewController: UIViewController, ToDoListViewInputProtocol {
    var output: ToDoListOutputProtocol?
    
    private let searchBar = UISearchBar()
    private let tableView = UITableView()
    private let footerView = UIView()
    private let buttonIndiseFooter = UIButton()
    private let labelInsideFooter = UILabel()
    private let titleLabel = UILabel()
    
    private var tasks: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setupUI() {
        view.backgroundColor = .black
        title = K.tasks
        navigationController?.navigationBar.prefersLargeTitles = true
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        //setupTitleLabel()
        setupSearchBar()
        setupFooterView()
        setupTableView()
    }
    
    private func setupTitleLabel() {
        titleLabel.text = K.tasks
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.boldSystemFont(ofSize: 38)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    private func setupSearchBar() {
        searchBar.searchTextField.backgroundColor = .darkGray
        searchBar.searchTextField.textColor = .white
        searchBar.searchBarStyle = .minimal
        searchBar.tintColor = .yellow
        
        if let textField = searchBar.value(forKey: K.searchField) as? UITextField {
            textField.attributedPlaceholder = NSAttributedString(
                string: K.search,
                attributes: [.foregroundColor: UIColor.gray]
            )
            if let iconView = textField.leftView as? UIImageView {
                iconView.tintColor = UIColor.gray
            }
        }
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])
        searchBar.delegate = self
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .black
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .lightGray
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: K.taskCell)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: footerView.topAnchor),
        ])
    }
    
    private func setupFooterView() {
        footerView.backgroundColor = .darkGray
        footerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(footerView)
        NSLayoutConstraint.activate([
            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 50)
        ])
        setupLabelInsideFooter()
        setupButtonInsideFooter()
        
        let bottomSafeAreaView = UIView()
        bottomSafeAreaView.backgroundColor = UIColor.darkGray
        bottomSafeAreaView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomSafeAreaView)
        
        NSLayoutConstraint.activate([
            bottomSafeAreaView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomSafeAreaView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomSafeAreaView.topAnchor.constraint(equalTo: footerView.bottomAnchor),
            bottomSafeAreaView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setupLabelInsideFooter() {
        labelInsideFooter.textColor = .white
        labelInsideFooter.font = UIFont.systemFont(ofSize: 12)
        footerView.addSubview(labelInsideFooter)
        labelInsideFooter.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelInsideFooter.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
            labelInsideFooter.centerXAnchor.constraint(equalTo: footerView.centerXAnchor)
        ])
    }
    
    private func setupButtonInsideFooter() {
        buttonIndiseFooter.setImage(UIImage(systemName: K.squareAndPencil,
        withConfiguration: UIImage.SymbolConfiguration(scale: .large)), for: .normal)
        buttonIndiseFooter.tintColor = .yellow
        
        footerView.addSubview(buttonIndiseFooter)
        buttonIndiseFooter.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonIndiseFooter.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
            buttonIndiseFooter.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -25)
        ])
    }
    
    func showTasks(_ tasks: [Task], totalCount: Int) {
        self.tasks = tasks
        tableView.reloadData()
        labelInsideFooter.text = "\(totalCount) Задач"
    }
    
    func showError(_ message: String) {
        let alert = UIAlertController(title: K.error, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: K.ok, style: .default))
        present(alert, animated: true)
        print(message)
    }
}


extension ToDoListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.taskCell, for: indexPath) as! TaskTableViewCell
        let task = tasks[indexPath.row]
        cell.configure(with: task)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { suggestedActions in
            let editAction = UIAction(title: K.editAction, image: UIImage(systemName: K.squareAndPencil)) { action in
                self.output?.navigateToEditTask(self.tasks[indexPath.row])
            }
            let shareAction = UIAction(title: K.shareAction, image: UIImage(systemName: K.squareAndArrowUp)) { action in
                
            }
            let deleteAction = UIAction(title: K.deleteAction, image: UIImage(systemName: K.trash), attributes: .destructive) { action in
                
            }
            return UIMenu(title: "", children: [editAction, shareAction, deleteAction])
        })
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        output?.navigateToEditTask(tasks[indexPath.row])
    }
}

extension ToDoListViewController: TaskTableViewCellDelegate {
    func didToggleTaskCompletion(at cell: TaskTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        tasks[indexPath.row].completed.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
        output?.toggleTaskCompletion(at: indexPath.row)
    }
}

extension ToDoListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        output?.didSearchTextChange(searchText)
        tableView.reloadData()
    }
}
