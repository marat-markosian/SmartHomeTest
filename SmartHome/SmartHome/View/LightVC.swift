//
//  LightVC.swift
//  SmartHome
//
//  Created by Марат Маркосян on 14.07.2022.
//

import UIKit

class LightVC: UIViewController {
    
    private lazy var backBtn = UIButton()
    private lazy var lightImage = UIImageView()
    private lazy var nameLbl = UILabel()
    private lazy var slider = UISlider()
    private lazy var onBtn = UIButton()
    
    var mode = ""
    var intensity = 0
    var name = ""

    override func loadView() {
        super.loadView()
        
        setUpSubviews()
        setUpAutoLayout()
    }
    
    private func setUpSubviews() {
        view.backgroundColor = .white
        
        view.addSubview(backBtn)
        view.addSubview(lightImage)
        view.addSubview(nameLbl)
        view.addSubview(slider)
        view.addSubview(onBtn)
        
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        lightImage.translatesAutoresizingMaskIntoConstraints = false
        nameLbl.translatesAutoresizingMaskIntoConstraints = false
        slider.translatesAutoresizingMaskIntoConstraints = false
        onBtn.translatesAutoresizingMaskIntoConstraints = false
        
        onBtn.setTitleColor(.black, for: .normal)
        onBtn.addTarget(self, action: #selector(onTapped), for: .touchUpInside)
        
        backBtn.setTitleColor(.black, for: .normal)
        backBtn.setTitle("Back", for: .normal)
        backBtn.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        
        lightImage.contentMode = .scaleAspectFit
        
        slider.maximumValue = 100
        slider.minimumValue = 0
        slider.isContinuous = true
        slider.setValue(Float(intensity), animated: true)
        
        nameLbl.textColor = .black
        nameLbl.text = name
        
        if mode == "ON" {
            lightImage.image = UIImage(named: "DeviceLightOnIcon")
            onBtn.setTitle("OFF", for: .normal)
        } else {
            lightImage.image = UIImage(named: "DeviceLightOffIcon")
            onBtn.setTitle("ON", for: .normal)
        }
    }
    
    private func setUpAutoLayout() {
        NSLayoutConstraint.activate([
            backBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            lightImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            lightImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lightImage.heightAnchor.constraint(equalToConstant: 150),
            lightImage.widthAnchor.constraint(equalToConstant: 150),
            
            nameLbl.topAnchor.constraint(equalTo: lightImage.bottomAnchor, constant: 30),
            nameLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            slider.topAnchor.constraint(equalTo: nameLbl.bottomAnchor, constant: 20),
            slider.leadingAnchor.constraint(equalTo: lightImage.leadingAnchor),
            slider.trailingAnchor.constraint(equalTo: lightImage.trailingAnchor),
            slider.heightAnchor.constraint(equalToConstant: 30),
            
            onBtn.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 30),
            onBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc private func onTapped(_ sender: UIButton) {
        if sender.title(for: .normal) == "ON" {
            lightImage.image = UIImage(named: "DeviceLightOnIcon")
            onBtn.setTitle("OFF", for: .normal)
            slider.isHidden = false
        } else {
            lightImage.image = UIImage(named: "DeviceLightOffIcon")
            onBtn.setTitle("ON", for: .normal)
            slider.isHidden = true
        }
    }
    
    @objc private func backTapped() {
        dismiss(animated: true)
    }
}
