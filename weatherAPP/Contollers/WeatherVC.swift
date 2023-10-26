//
//  WeatherVC.swift
//  weatherAPP
//
//  Created by Миржигит Суранбаев on 22/10/23.
//

import UIKit
import Firebase
import FirebaseAuth

class WeatherVC: UIViewController {

    
    
    let searchField: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "Введите название города"
        view.borderStyle = .roundedRect
        return view
    }()
    
    let temperatureLbl: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .boldSystemFont(ofSize: 26)
        view.tintColor = .blue
        return view
    }()
    
    let symbolCelc: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "°C"
        view.font = .boldSystemFont(ofSize: 26)
        view.textColor = .blue
        return view
    }()
    
    let cityName: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .blue
        view.font = .boldSystemFont(ofSize: 22)
        return view
    }()
    
    lazy var searchButton: UIButton = {
       let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Search", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.tintColor = .black
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.addTarget(self, action: #selector(didTapSearch), for: .touchUpInside)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
        
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    
    @objc private func didTapSearch() {
        setupData()
    }
    
    func setup() {
        setupUI()
    }
    
    func setupData() {
        let city = searchField.text ?? ""
        NetworkManager.shared.fetchData(city: city, completion: {[weak self] result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self?.cityName.text = model.name
                    self?.temperatureLbl.text = String(model.main.temp)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        })
    }

    func setupUI(){
    
        view.addSubview(temperatureLbl)
        view.addSubview(symbolCelc)
        view.addSubview(cityName)
        view.addSubview(searchField)
        view.addSubview(searchButton)
        
        NSLayoutConstraint.activate([
            
            
            symbolCelc.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 60),
            symbolCelc.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -60),
            
            cityName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityName.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            cityName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityName.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            searchField.bottomAnchor.constraint(equalTo: cityName.topAnchor),
            searchField.heightAnchor.constraint(equalToConstant: 50),
            searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            searchButton.bottomAnchor.constraint(equalTo: searchField.topAnchor),
            searchButton.centerXAnchor.constraint(equalTo: searchField.centerXAnchor),
            searchButton.heightAnchor.constraint(equalToConstant: 50),
            searchButton.widthAnchor.constraint(equalToConstant: 150),
            
            temperatureLbl.topAnchor.constraint(equalTo: cityName.bottomAnchor),
            temperatureLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        ])
    }
}

