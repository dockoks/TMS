//
//  ViewController.swift
//  HW2App
//
//  Created by Danila Kokin on 05.06.2024.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var daysCounterLabel: UILabel!
    @IBOutlet weak var dayInputTextField: UITextField!
    @IBOutlet weak var checkDaysButton: UIButton!
    private var daysLeft: String = "Неизвестно"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func calculateDaysTillWeekend(_ sender: Any) {
        switch dayInputTextField.text {
        case .none:
            daysCounterLabel.text = ""
        case .some(let text):
            switch text {
            case "понедельник":
                daysLeft = "5"
            case "вторник":
                daysLeft = "4"
            case "среда":
                daysLeft = "3"
            case "четверг":
                daysLeft = "2"
            case "пятница":
                daysLeft = "1"
            default:
                daysLeft = "Неизвестно"
            }
        }
        
        daysCounterLabel.text = daysLeft
    }
}

