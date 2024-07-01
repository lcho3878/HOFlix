//
//  PreviewController.swift
//  HOFlix
//
//  Created by 이찬호 on 7/1/24.
//

import UIKit
import SnapKit
import WebKit

class PreviewController: UIViewController {
    
    var previewKey: String!
    
    private let webView = WKWebView()
    
    private let activityIndicator = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.color = .black
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureHierarchy()
        configureLayout()
        configureWebView()
        webViewLoad()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureHierarchy() {
        view.addSubview(webView)
        view.addSubview(activityIndicator)
    }
    
    private func configureLayout() {
        webView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        activityIndicator.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}

extension PreviewController: WKNavigationDelegate {
    
    private func configureWebView() {
        webView.navigationDelegate = self
    }
    
    private func webViewLoad() {
        guard let previewKey,
              let url = URL(string: "https://www.youtube.com/watch?v=\(previewKey)") else { return }
        let request = URLRequest(url: url, timeoutInterval: 5)
        webView.load(request)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: any Error) {
        print(error.localizedDescription)
        activityIndicator.stopAnimating()
    }
}
