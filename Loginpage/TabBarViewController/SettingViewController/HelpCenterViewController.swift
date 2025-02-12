//
//  HelpCenterViewController.swift
//  Loginpage
//
//  Created by IE13 on 15/11/23.
//

import UIKit

class Section {
    let title: String
    let options: String
    var isOpened: Bool = false
    init(title: String, options: String, isOpened: Bool) {
        self.title = title
        self.options = options
        self.isOpened = isOpened
    }
}
class HelpCenterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    private var sections = [Section]()
    override func viewDidLoad() {
        super.viewDidLoad()
        sections = [
            Section(title: "what is parkz doller", options: ConstantHandle.optionsMessage, isOpened: false),
            Section(title: "what is benifits", options: ConstantHandle.optionsMessage, isOpened: false),
            Section(title: "How to i make purchase ", options: ConstantHandle.optionsMessage, isOpened: false),
            Section(title: "How can i get more parkz", options: ConstantHandle.optionsMessage, isOpened: false)
        ]
    }
    func numberOfSections(in tableView: UITableView) -> Int {
       return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:
                    "HelpCenterViewCell", for: indexPath) as? HelpCenterViewCell else {
            return UITableViewCell()
        }
        let section = sections[indexPath.section]
        cell.textNameLabel.text = section.title
        cell.textDescLabel.text = section.options
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sections[indexPath.section].isOpened = !sections[indexPath.section].isOpened
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = sections[indexPath.section]
        if section.isOpened {
            return 140
        } else {
            return 40
        }
    }
}
