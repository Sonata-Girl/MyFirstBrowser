//
//  ViewController.swift
//  MyFirstBrowser
//
//  Created by Sonata Girl on 08.08.2022.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var urlTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        urlTextField.delegate = self
        webView.navigationDelegate = self
        let homePage = "https://www.apple.com"
        urlTextField.text = homePage
        
        let url = URL(string: homePage)
        let request = URLRequest(url: url!)
        
        webView.load(request)
        webView.allowsBackForwardNavigationGestures = true
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    @IBAction func buttonBackAction(_ sender: UIButton) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    @IBAction func buttonForwardAction(_ sender: UIButton) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
}

extension ViewController: UITextFieldDelegate, WKNavigationDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let urlString = textField.text!
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        
        webView.load(request)
        
        textField.resignFirstResponder() // скрытие клавиатуры textfield
        
        return true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        urlTextField.text = webView.url?.absoluteString // строку адреса переводим в текстовое поле
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
    }
}
