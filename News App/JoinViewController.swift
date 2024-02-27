import UIKit

class JoinViewController: UIViewController {

    lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white
        return textField
    }()

    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white
        return textField
    }()

    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        return button
    }()

    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
        return button
    }()

    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setTitle("Back", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGray
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        return button
    }()

    func configureUI() {
        view.backgroundColor = .systemBackground

        let stackView = UIStackView(arrangedSubviews: [usernameTextField, passwordTextField, loginButton, registerButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 250)
        ])

        // Customize text fields
        [usernameTextField, passwordTextField].forEach {
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.systemGray.cgColor
            $0.layer.cornerRadius = 8
            $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
        }
    }

    @objc func didTapLogin() {
        let userTabBar = UserTabBarViewController()
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(vc: userTabBar)
    }

    @objc func didTapRegister() {
        let registrationVC = RegistrationViewController()
        navigationController?.pushViewController(registrationVC, animated: true)
    }

    @objc func didTapBack() {
        navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}
