//
//  TaskTableViewCell.swift
//  ToDoList
//
//  Created by Cyril Kardash on 26.11.2024.
//

import UIKit

final class TaskTableViewCell: UITableViewCell {
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let dateLabel = UILabel()
    private let checkmark = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = .black
        setupCheckmark()
        setupTitleLabel()
        setupDescriptionLabel()
        setupDateLabel()
    }
    
    private func setupCheckmark() {
        checkmark.layer.cornerRadius = 12
        checkmark.layer.borderWidth = 1
        checkmark.layer.borderColor = UIColor.gray.cgColor
        
        checkmark.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(checkmark)
        
        NSLayoutConstraint.activate([
            checkmark.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            checkmark.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            checkmark.widthAnchor.constraint(equalToConstant: 25),
            checkmark.heightAnchor.constraint(equalToConstant: 25),
        ])
    }
    
    private func setupTitleLabel() {
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: checkmark.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            titleLabel.centerYAnchor.constraint(equalTo: checkmark.centerYAnchor)
        ])
    }
    
    private func setupDescriptionLabel() {
        descriptionLabel.textColor = .white
        descriptionLabel.font = UIFont.systemFont(ofSize: 12)
        descriptionLabel.numberOfLines = 2
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
        ])
    }
    
    private func setupDateLabel() {
        dateLabel.textColor = .lightGray
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
            dateLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with task: Task) {
        titleLabel.text = K.todo
        descriptionLabel.text = task.todo
        checkmark.backgroundColor = task.completed ? .yellow : .clear
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let formattedDate = dateFormatter.string(from: Date())
        dateLabel.text = formattedDate
    }
}
