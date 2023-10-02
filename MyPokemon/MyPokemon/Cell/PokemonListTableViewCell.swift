//
//  PokemonListTableViewCell.swift
//  MyPokemon
//
//  Created by Karim Arhan on 02/10/23.
//

import UIKit

class PokemonListTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(item: String) {
        label.text = item
    }
    
}
