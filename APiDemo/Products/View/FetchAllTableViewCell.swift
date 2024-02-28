//
//  FetchAllTableViewCell.swift
//  APiDemo
//
//  Created by Inderpreet Singh on 26/02/24.
//

import UIKit

class FetchAllTableViewCell: UITableViewCell {

    
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var descriptionLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCellView(title:String, description:String){
        titleLable.text = title
        descriptionLable.text = description
    }

}
