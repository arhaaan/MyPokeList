//
//  PokemonDetailsViewController.swift
//  MyPokemon
//
//  Created by Karim Arhan on 02/10/23.
//

import UIKit

class PokemonDetailsViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var captureButton: UIButton!
    
    var urlPokemonData = ""
    
    var pokemonDetail:PokemonDetails?
    
    var pokemon: PokemonList?
    
    var index = -1
    
    var isFromMyCapturedList = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getPokemonDetailsData()
        
        if isFromMyCapturedList {
            captureButton.setTitle("Release", for: .normal)
        } else {
            captureButton.setTitle("Catch", for: .normal)
        }
        
    }
    
    func getPokemonDetailsData() {
        
        let url = URL(string: urlPokemonData)!
        URLSession.shared.getPokemonDetails(at: url) { result in
          switch result {
          case .success(let pokomon):
            print(pokomon)
              DispatchQueue.main.async {
                  self.pokemonDetail = pokomon
                  self.nameLabel.text = pokomon.name
                  self.heightLabel.text = "\(pokomon.height)"
                  self.weightLabel.text = "\(pokomon.weight)"
                  self.pokemonImageView.load(url: URL(string: pokomon.sprites.front_default)!)
                  
                  var typeStrings = ""
                  for pokeType in pokomon.types {
                      typeStrings = typeStrings + ", " + pokeType.type.name
                  }
                  self.typesLabel.text = typeStrings
                  
                  
              }
              
              
              
          case .failure(let error):
            // Ohno, an error, let's handle it
              self.LoadingStop()
              print("this is error: \(error)")
          }
        }
    }
    
    func showMessage(message: String) {
        let alert = UIAlertController(title: "Message", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func capture(){
        let randomInt = Int.random(in: 1..<11)
        
        if randomInt % 2 == 0 {
            showMessage(message: "Pokemon Captured")
            print(randomInt)
            ThePokemonManager.capturedPokemon.append(self.pokemon!)
            navigationController?.popViewController(animated: true)
        } else {
            showMessage(message: "Pokemon Failed to Capture")
            print(randomInt)
        }
    }
    
    func isPrime(_ number: Int) -> Bool {
        return number > 1 && !(2..<number).contains { number % $0 == 0 }
    }
    
    func release() {
        let randomInt = Int.random(in: 1..<50)
        
        if isPrime(randomInt){
            showMessage(message: "Pokemon Released")
            print(randomInt)
            ThePokemonManager.capturedPokemon.remove(at: index)
            navigationController?.popViewController(animated: true)
        } else {
            showMessage(message: "Pokemon Failed to Release")
            print(randomInt)
        }
    }

    @IBAction func catchButtonTapped(_ sender: Any) {
        if isFromMyCapturedList {
            release()
        } else {
            capture()
        }
    }
}


extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
