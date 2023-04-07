//
//  APIByAlamofireController.swift
//  NotifyAndAPI
//
//  Created by Bhushan Tambe on 07/04/23.
//

import UIKit
import Alamofire

class APIByAlamofireController: UIViewController {

    @IBOutlet weak var tableViewAf: UITableView!
    @IBOutlet weak var showButton: UITableView!
    var jokes: [Value]?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewAf.dataSource = self
        tableViewAf.delegate = self
        tableViewAf.backgroundColor = UIColor.black
        tableViewAf.separatorColor = UIColor.white
        
    }
    @IBAction func showTapped(_ sender: Any) {
        getJokes()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.tableViewAf.reloadData()
        }
        
    }
    
    private func getJokes(){
        AF.request("https://raw.githubusercontent.com/atilsamancioglu/JokesAppJsonData/main/chuck.json",method: .get).responseDecodable(of: Response.self) { data in
            switch data.result{
            case .success(let res) :
                self.jokes = res.value
            case .failure(let error):
                print(error.localizedDescription + "ERRORRRRR")
            }
        
        }
        
    }
}

extension APIByAlamofireController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellAlamofire", for: indexPath)
        cell.textLabel?.text = self.jokes?[indexPath.row].joke
        cell.textLabel?.numberOfLines = 0
        cell.backgroundColor = UIColor.black
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
    
}
