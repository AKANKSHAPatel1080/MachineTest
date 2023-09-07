//
//  NewsTableViewCell.swift
//  MachineTest
//
//  Created by Akanksha Patel on 06/09/23.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgview: UIImageView!
    
    @IBOutlet weak var lbl: UILabel!
    
    var imageTappedHandler: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lbl.font = UIFont(name: "Roboto Slab Bold", size: 29)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        imgview.addGestureRecognizer(tapGesture)
        imgview.isUserInteractionEnabled = true
    }
    
    @objc private func imageViewTapped() {
        imageTappedHandler?()
    }
    
    func configure(with article: Article) {
        lbl.text = article.title
        
       
        if let imageURLString = article.imageURL, let imageURL = URL(string: imageURLString) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: imageURL) {
                    DispatchQueue.main.async {
                        self.imgview.image = UIImage(data: data)
                    }
                }
            }
        }
    }
}
