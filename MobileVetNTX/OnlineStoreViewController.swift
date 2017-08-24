//
//  OnlineStoreViewController.swift
//  MobileVetNTX
//
//  Created by Tyler Lafferty on 7/3/17.
//  Copyright © 2017 Tyler Lafferty. All rights reserved.
//

import Foundation
import UIKit

class OnlineStoreViewController : UIViewController {
    
    // -- Outlets --
    @IBOutlet var webView: UIWebView!
    @IBOutlet var webNavView: UIView!
    @IBOutlet var forwardBtn: UIImageView!
    @IBOutlet var backBtn: UIImageView!
    @IBOutlet var activity: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL (string: "http://mobilevetclinicofnorthtexas.vetsfirstchoice.com/")
        let requestObj = URLRequest(url: url!)
        webView.loadRequest(requestObj)
        
        // Back Image View
        backBtn.image = UIImage(named: "arrow-right")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        backBtn.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        backBtn.isUserInteractionEnabled = true
        let back = UITapGestureRecognizer(target: self, action: #selector(OnlineStoreViewController.goBack))
        backBtn.addGestureRecognizer(back)
        
        // Forward Image View
        forwardBtn.image = UIImage(named: "arrow-right")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        forwardBtn.isUserInteractionEnabled = true
        let forward = UITapGestureRecognizer(target: self, action: #selector(OnlineStoreViewController.goForward))
        forwardBtn.addGestureRecognizer(forward)
        
        setButtonColors()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

// MARK: - Web View Delegate
extension OnlineStoreViewController : UIWebViewDelegate {
    func webViewDidStartLoad(_ webView: UIWebView) {
        activity.isHidden = false
        activity.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        setButtonColors()
        activity.isHidden = true
        activity.stopAnimating()
    }
}

// MARK: - Button Naviagation
extension OnlineStoreViewController {
    
    func goBack() {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    func goForward() {
        if webView.canGoForward {
            webView.goForward()
        }
    }
}

// MARK: - Helpers
extension OnlineStoreViewController {
    
    func setButtonColors() {
        if webView.canGoBack {
            backBtn.tintColor = UIColor.white
        } else {
            backBtn.tintColor = UIColor.lightGray
        }
        
        if webView.canGoForward {
            forwardBtn.tintColor = UIColor.white
        } else {
            forwardBtn.tintColor = UIColor.lightGray
        }
    }
}
