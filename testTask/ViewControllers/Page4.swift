//
//  Page4.swift
//  testTask
//
//  Created by Edgar Sargsyan on 22.10.23.
//

import UIKit

protocol Page4DataPassDelegate: AnyObject {
    func passInfo(info: SelectedInfoModel)
}

struct SelectedInfoModel {
    var info: String?
    var selectedIndex: Int?
}

class Page4: UIViewController {
    
    @IBOutlet weak var tittleLabel: UILabel!
    
    private var collectionView: UICollectionView?
    var selectedIndexPath: IndexPath?
    var selectedIndex: Int!
    weak var delegate: Page4DataPassDelegate?
    
    let currencyNames = ["EUR / USD", "GPB / USD", "EUR / USD",
                        "EUR / USD", "GPB / USD", "EUR / USD",
                        "EUR / USD", "EUR / USD", "EUR / USD", "GPB / USD",
                        "EUR / USD", "EUR / USD", "GPB / USD", "EUR / USD"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        configureCollectionView()
        if let indexPath = selectedIndexPath {
                collectionView?.selectItem(at: indexPath, animated: false, scrollPosition: .top)
            }
    }
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: 140, height: 54)
        layout.sectionInset = UIEdgeInsets(top: 35, left: 40, bottom: 0, right: 40)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else {
            return
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: tittleLabel.bottomAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
    }

    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
extension Page4: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currencyNames.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
        
        cell.contentView.backgroundColor = selectedIndex != nil && selectedIndex == indexPath.row ? .systemGreen : .specificGray

        let currencyName = currencyNames[indexPath.row]
        cell.myLabel.text = currencyName
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CustomCollectionViewCell
        var infoModel = SelectedInfoModel()
        infoModel.info = cell.myLabel.text ?? ""
        infoModel.selectedIndex = indexPath.row
        delegate?.passInfo(info: infoModel)

        selectedIndex = indexPath.row
        collectionView.reloadData()
    }
}
     
