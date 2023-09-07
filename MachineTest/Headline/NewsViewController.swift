//
//  NewsViewController.swift
//  MachineTest
//
//  Created by Akanksha Patel on 07/09/23.
//

import UIKit

class NewsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var blackview: UIView!
    @IBOutlet weak var headlinelbl: UILabel!
    var articles: [Article] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        headlinelbl.font = UIFont(name: "Roboto Slab Bold", size: 29)
        
        let apiKey = "c94df83acd1c4f929767e4e6575b06cd"

        let urlString = "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(apiKey)"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL")
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(NewsResponse.self, from: data)
                self.articles = response.articles

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }.resume()
        
        // Register the custom cell
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")

        // Set the table view data source and delegate
        tableView.dataSource = self
        tableView.delegate = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        let article = articles[indexPath.row]
        cell.configure(with: article)
        cell.imageTappedHandler = { [weak self] in
               self?.performSegue(withIdentifier: "NewsTableViewCell", sender: article)
           }
        return cell
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
        let selectedArticle = articles[indexPath.row]
        performSegue(withIdentifier: "NewsTableViewCell", sender: selectedArticle)
        if let url = URL(string: article.url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NewsTableViewCell", let indexPath = tableView.indexPathForSelectedRow {
            let selectedArticle = articles[indexPath.row]
            if let imageDetailViewController = segue.destination as? ImageViewController {
                imageDetailViewController.imageUrlString = selectedArticle.imageURL
            }
        }
    }


}


