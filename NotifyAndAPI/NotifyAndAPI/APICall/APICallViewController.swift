//
//  APICallViewController.swift
//  NotifyAndAPI
//
//  Created by Bhushan Tambe on 07/04/23.
//

import UIKit

class APICallViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var result: Response?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.black
        tableView.separatorColor = UIColor.white
    }
    
    @IBAction func showTapped(_ sender: Any) {
      getJokes()
        tableView.rowHeight = UITableView.automaticDimension
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.tableView.reloadData()
           
        }
    }
   private func getJokes(){
        //MARK: URL
            let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/JokesAppJsonData/main/chuck.json")

        //MARK: Get URL session
            let session = URLSession.shared
            
        //MARK: Create the data task
        let dataTask = session.dataTask(with: url!,completionHandler:  { [self] (data, response, error) in
                if error == nil && data != nil{
                    //try parsing data
                    do{
                        result = try JSONDecoder().decode(Response.self,from: data!)
              
                    }catch{
                        print(error.localizedDescription)
                    }
                }
            })
       
        //MARK: FireOff the data task
            dataTask.resume()
    }
}


extension APICallViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result?.value.count ?? 0
       
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.result?.value[indexPath.row].joke
        cell.textLabel?.numberOfLines = 0
        cell.backgroundColor = UIColor.black
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
}
