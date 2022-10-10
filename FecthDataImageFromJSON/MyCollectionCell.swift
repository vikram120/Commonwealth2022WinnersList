//
//  MyCollectionCell.swift
//  FecthDataImageFromJSON
//
//  Created by Vikram Kunwar on 10/10/22.
//

import UIKit

class MyCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var SportsPersonName: UILabel!
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var SportsGame: UILabel!
    
    override func prepareForReuse() {
        self.myImageView.image = nil
    }
    
}
