//
//  JuiceMaker - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var fruitStack: UIStackView!
    @IBOutlet weak var multiJuiceStack: UIStackView!
    @IBOutlet weak var singleJuiceStack: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setFruitStack()
        setJuiceStack()
    }

    private func setFruitStack() {
        let fruits: [FruitsType : Fruit] = JuiceMaker.shared.getFruits()
        
        for (key: fruitName, value: fruit) in fruits {
            let fruitView = FruitView()
            fruitView.translatesAutoresizingMaskIntoConstraints = false
            fruitStack.addArrangedSubview(fruitView)
            fruitView.widthAnchor.constraint(equalTo: fruitView.heightAnchor, multiplier: 1.0).isActive = true
            
            fruitView.fruitName.text = fruitName.rawValue
            fruitView.fruitStock.text = String(fruit.stock)
        }
    }

    private func setJuiceStack() {
        let juices: [Juices] = JuiceMaker.shared.getJuices()
        
        for juice in juices {
            
            let info = juice.getJuiceInfo()
            
            let juiceButton = JuiceButton(juice: juice, name: info.name)
            juiceButton.translatesAutoresizingMaskIntoConstraints = false
            if info.type == .multi {
                multiJuiceStack.addArrangedSubview(juiceButton)
            }
            else {
                singleJuiceStack.addArrangedSubview(juiceButton)
            }
            juiceButton.addTarget(self, action: #selector(makeJuice(sender:)), for: .touchUpInside)
        }
    }
    
    @objc func makeJuice(sender: JuiceButton) throws {
        guard let juice = sender.juice else {
            throw JuiceMakerError.system
        }
        
        do {
            try JuiceMaker.shared.choiceJuice(juice: juice)
            successJuiceAlert(juice: juice)
        } catch JuiceMakerError.outOfStock {
            outOfStockError(.outOfStock)
        } catch JuiceMakerError.notFound {
            notFoundError(.notFound)
        }
    }
    
    @IBAction func moveManageStock() {
        let manageStockViewController = UINavigationController(rootViewController: ManageStockViewController())
        self.present(manageStockViewController, animated: true, completion: nil)
    }
    
    func successJuiceAlert(juice: Juices) {
        let alert = UIAlertController(title: nil, message: "\(juice.getJuiceInfo().name) 나왔습니다!\n맛있게 드세요!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: false, completion: nil)
    }
    
    func outOfStockError(_ error: JuiceMakerError) {
        let alert = UIAlertController(title: nil, message: error.getMessage(), preferredStyle: .alert)
        let okAction = UIAlertAction(title: "예", style: .default, handler: nil)
        let cancleAction = UIAlertAction(title: "아니요", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancleAction)
        
        present(alert, animated: false, completion: nil)
    }
    
    func notFoundError(_ error: JuiceMakerError) {
        let alert = UIAlertController(title: "오류", message: error.getMessage(), preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: false, completion: nil)
    }
}

