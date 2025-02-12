//
//  PrivacyPolicyViewController.swift
//  Loginpage
//
//  Created by IE13 on 15/11/23.
//

import UIKit
import WebKit
class PrivacyPolicyViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet weak var privacyWebView: WKWebView!
    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    var url: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        activitySpinner.startAnimating()
        view.addSubview(privacyWebView)
        privacyWebView.navigationDelegate = self
        privacyWebView.backgroundColor = .clear
        guard let goUrl = URL(string: url ?? "https://www.facebook.com/help/581066165581870") else {
            return
        }
        privacyWebView.load(URLRequest(url: goUrl))
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activitySpinner.stopAnimating()
    }
}
