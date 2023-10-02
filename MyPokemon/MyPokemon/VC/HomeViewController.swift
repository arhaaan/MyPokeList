//
//  HomeViewController.swift
//  MyPokemon
//
//  Created by Karim Arhan on 29/09/23.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var pokeList = [PokemonList]()
    
    var isMyListPage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        getPokemonDatas()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func initUI() {
        tableView.register(UINib(nibName: "PokemonListTableViewCell", bundle: nil), forCellReuseIdentifier: "PokemonListTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func getPokemonDatas() {
        self.LoadingStart()
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon")!
        URLSession.shared.getPokemons(at: url) { result in
          switch result {
          case .success(let pokomon):
            print(pokomon)
              DispatchQueue.main.async {
                  self.pokeList = pokomon.results
                  self.tableView.reloadData()
              }
              
              self.LoadingStop()
              
          case .failure(let error):
            // Ohno, an error, let's handle it
              self.LoadingStop()
              print("this is error: \(error)")
          }
        }

    }

    @IBAction func segmentValueChanged(_ sender: Any) {
        if isMyListPage {
            isMyListPage = false
            getPokemonDatas()
        } else {
            isMyListPage = true
            pokeList = ThePokemonManager.capturedPokemon
            tableView.reloadData()
        }
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokeList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonListTableViewCell", for: indexPath) as! PokemonListTableViewCell
        cell.setCell(item: pokeList[indexPath.row].name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PokemonDetailsViewController()
        vc.urlPokemonData = pokeList[indexPath.row].url
        vc.pokemon = pokeList[indexPath.row]
        vc.index = indexPath.row
        vc.isFromMyCapturedList = self.isMyListPage
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

struct ProgressDialog {
    static var alert = UIAlertController()
    static var progressView = UIProgressView()
    static var progressPoint : Float = 0{
        didSet{
            if(progressPoint == 1){
                ProgressDialog.alert.dismiss(animated: true, completion: nil)
            }
        }
    }
}
extension UIViewController {
    
   func LoadingStart(){
        ProgressDialog.alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
    
    let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
    loadingIndicator.hidesWhenStopped = true
    loadingIndicator.style = UIActivityIndicatorView.Style.medium
    loadingIndicator.startAnimating();

    ProgressDialog.alert.view.addSubview(loadingIndicator)
    present(ProgressDialog.alert, animated: true, completion: nil)
  }

  func LoadingStop(){
    ProgressDialog.alert.dismiss(animated: true, completion: nil)
  }
}
