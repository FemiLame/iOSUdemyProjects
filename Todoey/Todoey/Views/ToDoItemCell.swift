//
//  ToDoItemCell.swift
//  Todoey
//
//  Created by Alex Osipova on 05.08.2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import UIKit

class ToDoItemCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
