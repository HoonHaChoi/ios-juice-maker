//
//  JuiceMaker - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {

    @IBOutlet var fruitLabels: [UILabel]!
    @IBOutlet var JuiceOrderButtons: [UIButton]!
    
    var juiceMaker = JuiceMaker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabels(numbers: juiceMaker.show())
        DispatchQueue.main.async {
            self.order()
        }
    }
    
    func order() {
        do {
            try doneAlert(message: juiceMaker.takeOrder(recipeType: .strawberryJuice))
            setLabels(numbers: juiceMaker.show())
        } catch {
            showErrorMessage(from: error)
        }
    }
    
    private func setLabels(numbers: [Int]) {
        for (fruitLabel, number) in zip(fruitLabels, numbers) {
            fruitLabel.text = "\(number)"
        }
    }
    
    func moveChangeFruitStock() {
        let alert = UIAlertController(title: "", message: "재고 부족함", preferredStyle: .alert)
        alert.addAction(.init(title: "확인", style: .default, handler: nil))
        alert.addAction(.init(title: "취소", style: .cancel, handler: { [weak self] _ in
            self?.navigationController?.pushViewController(UIViewController(), animated: true)
        }))
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    var moveVC: UIAction {
        UIAction { _ in
            self.navigationController?.pushViewController(UIViewController(), animated: true)
        }
    }
    
    func moveVC2() {
        self.navigationController?.pushViewController(UIViewController(), animated: true)
    }
}

extension ViewController {
    
    func showErrorMessage(from error: Error) {
        guard let error = error as? JuiceMakerError else {
            return
        }
        switch error {
        case .notEnough:
            selectAlet(message: error.description, action: moveVC2())
        default:
            doneAlert(message: error.description)
        }
    }
}

extension UIViewController {
    
    func doneAlert(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "확인", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func selectAlet(message: String, action: Void) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "확인", style: .default, handler: nil))
        alert.addAction(.init(title: "취소", style: .cancel) { _ in
            action
        })
        present(alert, animated: true, completion: nil)
    }
}
