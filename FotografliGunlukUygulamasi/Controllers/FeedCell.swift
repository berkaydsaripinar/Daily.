//
//  FeedCell.swift
//  FotografliGunlukUygulamasi
//
//  Created by yasin on 2.07.2023.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    
  // @IBOutlet weak var datetimeLabel: UILabel!
    
    @IBOutlet weak var feedImageView: UIImageView!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
