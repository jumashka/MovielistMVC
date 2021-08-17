//
//  ViewController.swift
//  MovieDB
//
//  Created by Juma on 8/12/21.
//

import UIKit




class TableViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    
        @IBOutlet weak var tablView: UITableView!
        
        @IBOutlet weak var searchBar: UISearchBar!
    
        var MovieList: MovieModel?
        var networking: Networking?
        var constant: Contstant?
        var filteredData: [Results]? = []
    

    
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            filteredData = MovieList?.results
                guard let srchTxt = searchBar.text, srchTxt.count > 0 else {
                    tablView.reloadData()
                    return
                }
                
                let result = filteredData?.filter({movie -> Bool in
                    return (movie.title ?? "").lowercased().contains(srchTxt.lowercased())
                })
                
                filteredData = result
                tablView.reloadData()
            
        }
        
    
    
        override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tablView.delegate = self
        tablView.dataSource = self
        
        // calling api
        networking = Networking()
        networking?.response(url: Contstant.baseURL.rawValue + Contstant.api_key.rawValue) {modelData in
                print(modelData)
            self.filteredData = modelData.results
                self.MovieList = modelData
                DispatchQueue.main.async {
                    self.tablView.reloadData()
                }
                
            }

        }
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return  filteredData?.count ?? 0
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let MovieCell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as? MovieTableViewCell
            MovieCell?.titleLabel.text = filteredData?[indexPath.row].title
            if let poppi = filteredData?[indexPath.row].release_date { MovieCell?.yearOfRelease.text = "\(poppi)" }
           
            
            

            // MARK: Load Image
            
            DispatchQueue.global(qos: .background).async {
                if let url = URL(string: Contstant.image_url_path.rawValue + (self.filteredData?[indexPath.row].backdrop_path)!) {
                       let data = try? Data(contentsOf: url)
                       if let datac = data {
                           DispatchQueue.main.async {
                               // moviees depending on search
                            MovieCell?.movieImage.image = UIImage(data: datac)
                              
                           }
                       }
                   }
               }
                    
            return MovieCell!
                
        }
    

        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return CGFloat(202)
        }
    
    
        


    }
    
    

        




