//
//  CustomCollectionViewCell.swift
//  testTask
//
//  Created by Edgar Sargsyan on 22.10.23.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CustomCollectionViewCell"
    
    let myLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    var currencyName: String? 
    override init(frame: CGRect) {
            super.init(frame: frame)
            contentView.backgroundColor = .specificGray
            contentView.layer.cornerRadius = 10
            contentView.addSubview(myLabel)
            
            myLabel.frame = CGRect(x: 5, y: contentView.frame.size.height - 50, width: contentView.frame.size.width - 10, height: 50)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
