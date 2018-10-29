//
//  ViewController.swift
//  JsWebView
//
//  Created by Ofer Irani on 28/10/2018.
//  Copyright © 2018 Via. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKScriptMessageHandler {
    
    var wkWebView: WKWebView!
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let configurations = WKWebViewConfiguration()
        configurations.userContentController.add(self, name: "jsHandler")
        
        wkWebView = WKWebView(frame: self.view.bounds, configuration: configurations)
        view.addSubview(wkWebView)
        
        let bundleURL = Bundle.main.resourceURL!.absoluteURL
        let html = bundleURL.appendingPathComponent("try.html")
        wkWebView.loadFileURL(html, allowingReadAccessTo:bundleURL)
    }
    
    func sendTokenToJs() {
        let token =  UUID().uuidString
        let js = "showToken('\(token)');"
        wkWebView.evaluateJavaScript(js, completionHandler: { _, error in
            if let error = error {
                print("*** \(error)")
            }
        })
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "jsHandler" {
            print(message.body)
            sendTokenToJs()
        }
    }
}




