//
//  ServicioController.swift
//  UpaxPrueba
//
//  Created by Jair Moreno Gaspar on 3/7/19.
//  Copyright © 2019 Jair Moreno Gaspar. All rights reserved.
//


import UIKit

class ServicioController: UIViewController {
    
    
    //MARK: Properties
    
    let url = "https://reqres.in/api/users"
    var user: User = User()
    let cellId = "cellId"
    
    let botonConsumir: UIButton = {
        let boton = UIButton()
        boton.backgroundColor = .blue
        boton.addTarget(self, action: #selector(consumirServicio), for: .touchUpInside)
        boton.setTitle("Consumir Servicio", for: .normal)
        boton.titleLabel?.font = .systemFont(ofSize: 17)
        boton.setTitleColor(UIColor.white, for: .normal)
        boton.layer.cornerRadius = 10
        boton.translatesAutoresizingMaskIntoConstraints = false
        return boton
        
    }()
    
    let textoRespuesta: UITextView = {
        
        let tv = UITextView()
        tv.isEditable = false
        tv.backgroundColor = .white
        tv.layer.borderColor = UIColor.black.cgColor
        tv.layer.borderWidth = 1
        tv.textColor = .black
        tv.textAlignment = .left
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
        
    }()
    
    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    //MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureNavigationBar()
        setUpViews()
        
    }
    
    
    //MARK: Functions
    
    func setUpViews(){
        
        collectionView.frame = view.frame
        view.addSubview(collectionView)
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: cellId)
        consumirServicio()
    }
    
    @objc func consumirServicio(){
        
        ApiService.sharedInstance.fetchForUrlString(urlString: url) { (user: User) in
            print(user)
            self.user = user
            self.collectionView.reloadData()
        }
        
        
    }

    
    func configureNavigationBar(){
        navigationController?.navigationBar.barTintColor = .blue
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barStyle = .black
        navigationItem.title = "Servicio"
    }
    
}


extension ServicioController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.user.data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ImageCell
        cell.backgroundColor = .white
        if let data = user.data {
            cell.configure(with: (data[indexPath.row]))
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: view.bounds.height * 0.2)
    }
    
    
}
