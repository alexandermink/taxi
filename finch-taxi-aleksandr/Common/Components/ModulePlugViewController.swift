//
//  ModulePlugViewController.swift
//  finch-taxi-aleksandr
//
//  Created by Александр Минк on 18.04.2022.
//

import UIKit

final class ModulePlugViewController: UIViewController {
    
    // MARK: - Properties
    
    private let plugLabel = UILabel()
    private var timer = Timer()
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawSelf()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        startAnimatePlug()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        timer.invalidate()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        plugLabel.font = Fonts.systemBold40
        plugLabel.textAlignment = .center
        plugLabel.text = Texts.comingSoonTemplate.replacingOccurrences(of: "#", with: "")
        plugLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(plugLabel)
        
        NSLayoutConstraint.activate([
            plugLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            plugLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            plugLabel.heightAnchor.constraint(equalToConstant: 60),
            plugLabel.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    
    // MARK: - Private methods
    
    private func startAnimatePlug() {
        
        var dots = ""
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            if dots.count < 3 {
                dots = dots + "."
            } else {
                dots = ""
            }
            self?.plugLabel.text = Texts.comingSoonTemplate.replacingOccurrences(of: "#", with: dots)
        }
    }
}
