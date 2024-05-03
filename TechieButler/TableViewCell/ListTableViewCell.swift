//
//  ListTableViewCell.swift
//  TechieButler
//
//  Created by Ravindra Arya on 03/05/24.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellTitle : UILabel!
    @IBOutlet weak var userId : UILabel!
    @IBOutlet weak var Id : UILabel!
    @IBOutlet weak var cellDescription : UILabel!
    @IBOutlet weak var containerView : UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
