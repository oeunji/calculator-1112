import UIKit

class ViewController: UIViewController {
    
    private let model = CalculatorModel()  // 모델 인스턴스 생성
    
    private var answer: String = ""
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = .systemFont(ofSize: 40)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setupLayoutAnswer() {
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            label.heightAnchor.constraint(equalToConstant: 80),
        ])
    }
    
    private let buttonData: [[String]] = [
        ["AC", "", "", "÷"],
        ["7", "8", "9", "×"],
        ["4", "5", "6", "−"],
        ["1", "2", "3", "+"],
        ["", "0", "", "="]
    ]
    
    private func setupLayoutButton() {
        let buttonStackView = buttonStackView()
        view.addSubview(buttonStackView)
        
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    private func buttonStackView() -> UIStackView {
        var rowStackViews: [UIStackView] = []
        
        for row in buttonData {
            var buttons: [UIButton] = []
            
            for title in row {
                let button = UIButton(type: .system)
                button.setTitle(title, for: .normal)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
                button.translatesAutoresizingMaskIntoConstraints = false
                
                button.layer.borderWidth = 0.5
                button.layer.cornerRadius = 10
                button.layer.borderColor = UIColor.lightGray.cgColor
                
                NSLayoutConstraint.activate([
                    button.heightAnchor.constraint(equalTo: button.widthAnchor)
                ])
                
                button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
                buttons.append(button)
            }
            
            let rowStackView = UIStackView(arrangedSubviews: buttons)
            rowStackView.axis = .horizontal
            rowStackView.distribution = .fillEqually
            rowStackView.spacing = 10
            rowStackViews.append(rowStackView)
        }
        
        let buttonStackView = UIStackView(arrangedSubviews: rowStackViews)
        buttonStackView.axis = .vertical
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 10
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        return buttonStackView
    }
    
    // 버튼이 눌렸을 때 호출되는 메서드
    @objc private func buttonTapped(_ sender: UIButton) {
        guard let title = sender.currentTitle, !title.isEmpty else { return }
        
        if title == "AC" {
            model.clear()
            label.text = "0"
        } else if title == "=" {
            if let result = model.calculate() {
                label.text = result
            } else {
                label.text = "Error"
            }
        } else {
            model.append(title)
            label.text = model.getExpression()  // 모델의 현재 식을 레이블에 표시
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayoutAnswer()
        setupLayoutButton()
    }
}
