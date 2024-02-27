//
//  EditProfileViewController.swift
//  News App
//
//  Created by Сырлыбай Рамазан on 27.02.2024.


import UIKit

class EditProfileViewController: UIViewController {

    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let surnameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapSave), for: .touchUpInside)
        button.backgroundColor = .green
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        loadProfileData()
    }

    func configureUI() {
        view.backgroundColor = .white

        view.addSubview(nameLabel)
        view.addSubview(surnameLabel)
        view.addSubview(saveButton)

        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),

            surnameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            surnameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 10),

            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.topAnchor.constraint(equalTo: surnameLabel.bottomAnchor, constant: 20),
            saveButton.widthAnchor.constraint(equalToConstant: 150),
            saveButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }

    func loadProfileData() {
        // Загрузите данные пользователя для редактирования (замените на реальные данные)
        let firstName = "John"
        let lastName = "Doe"

        nameLabel.text = "First Name: \(firstName)"
        surnameLabel.text = "Last Name: \(lastName)"
    }

    

    @objc func didTapSave() {
        // Реализуйте сохранение отредактированных данных пользователя
        // Например, отправьте данные на сервер или сохраните их локально

        // После успешного сохранения, вы можете выполнить дополнительные действия, например, возврат на предыдущий экран
        let userTabBar = UserTabBarViewController()
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(vc: userTabBar)
    }

   
}
