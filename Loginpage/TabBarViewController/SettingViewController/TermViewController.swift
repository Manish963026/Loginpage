//
//  TermViewController.swift
//  Loginpage
//
//  Created by IE13 on 15/11/23.
//

import UIKit
import WebKit
class TermViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet weak var helpWebView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(helpWebView)
        helpWebView.navigationDelegate = self
        helpWebView.backgroundColor = .clear
        guard let url = URL(string: "https://www.facebook.com/help/581066165581870") else {
            return
        }
        helpWebView.load(URLRequest(url: url))
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}
