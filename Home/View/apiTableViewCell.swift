//
//  apiTableViewCell.swift
//  APiDemo
//
//  Created by Inderpreet Singh on 22/02/24.
//

import UIKit

class apiTableViewCell: UITableViewCell {

    @IBOutlet weak var idLable: UILabel!
    @IBOutlet weak var nameLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCellView(id:String, name:String){
        idLable.text = id
        nameLable.text = name
    }
    
}
