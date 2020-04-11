//
//  ViewController.swift
//  TravelApp
//
//  Created by Kevin Kho on 09/04/20.
//  Copyright © 2020 Kevin Kho. All rights reserved.
//

import UIKit

struct OnboardingItem {
    let title: String
    let detail: String
    let bgImage: UIImage?
}
class OnboardingViewController: UIViewController {

    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var darkView: UIView!
    
    private let items: [OnboardingItem] = [
        .init(title: "Travel Your Way", detail: "Find your perfect places", bgImage: UIImage(named: "white-boat")),
        .init(title: "Stay Your Way", detail: "Find the perfect accomodation", bgImage: UIImage(named: "field")),
        .init(title: "Discover Your Way", detail: "Explore exotic destinations", bgImage: UIImage(named: "mountain")),
        .init(title: "Feast your way", detail: "Safe and highly recommended by the locals!", bgImage: UIImage(named: "food"))
    ]
    private var currentPage: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageControl()
        setupScreen(index: currentPage)
        updateBackgroundImage(index: currentPage)
        setupGestures()
        setupViews()
    }
    
    private func setupPageControl(){
        pageControl.numberOfPages = items.count
    }
    
    private func setupScreen(index: Int){
        titleLabel.text = items[index].title
        detailLabel.text = items[index].detail
        pageControl.currentPage = index
        titleLabel.alpha = 1.0
        detailLabel.alpha = 1.0
        titleLabel.transform = .identity
        detailLabel.transform = .identity
    }
    
    private func setupGestures(){
        let tapGestures = UITapGestureRecognizer(target: self, action: #selector(handleTapAnimation))
        view.addGestureRecognizer(tapGestures)
    }
    
    @objc private func handleTapAnimation(){
        print("tapped!")
        
        // first animation - title label
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            
            self.titleLabel.alpha = 0.0
            self.titleLabel.transform = CGAffineTransform(translationX: -30, y: 0)
        }) { _ in
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                
                self.titleLabel.alpha = 0.0
                self.titleLabel.transform = CGAffineTransform(translationX: 0, y: -550)
            }, completion: nil)
            
        }
        
        // second animation - detail label
        
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            
            self.detailLabel.alpha = 0.0
            self.detailLabel.transform = CGAffineTransform(translationX: -30, y: 0)
            
        }) { _ in
            
            if self.currentPage < self.items.count - 1 {
                self.updateBackgroundImage(index: self.currentPage + 1)
            }
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                
                self.detailLabel.alpha = 0.0
                self.detailLabel.transform = CGAffineTransform(translationX: 0, y: -550)
            }) { _ in
                self.currentPage += 1
                
                if self.isLastItem(){
                    self.showMainApp()
                }
                else {
                    self.setupScreen(index: self.currentPage)
                }
            }
        }
    }
    
    private func isLastItem() -> Bool {
        return currentPage == self.items.count
    }
    
    private func showMainApp() {
        let mainAppViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainStoryboard")
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let sceneDelegate = windowScene.delegate as? SceneDelegate, let window = sceneDelegate.window{
            window.rootViewController = mainAppViewController
            UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }
    
    private func setupViews() {
        darkView.backgroundColor = UIColor.init(white: 0.1, alpha: 0.5)
    }
    
    private func updateBackgroundImage(index: Int){
        let image = items[index].bgImage
        
        UIView.transition(with: bgImageView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.bgImageView.image = image
        }, completion: nil)
    }
}

