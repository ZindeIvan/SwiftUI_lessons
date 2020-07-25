//
//  NewsTableViewController.swift
//  VK_client
//
//  Created by Зинде Иван on 7/25/20.
//  Copyright © 2020 zindeivan. All rights reserved.
//

import UIKit

class NewsTableViewController : UIViewController {
    
    @IBOutlet weak var newsTableView : UITableView!
    
    private var newsList : [News] = [
    
        News(newsID: "news1", newsWatchedCount: 1321, newsOwner: "Daly planet", newsDate:  "12.05.2020", newsText: "The object, known as Comet, was discovered by an instrument floating in space and it is falling towards the Earth."),
        News(newsID: "news2", newsWatchedCount: 200, newsOwner: "Justice Society of America", newsDate:  "15.04.2020", newsText: "Justice Society of America held anual veteran meeting"),
    
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsTableView.dataSource = self
        newsTableView.delegate = self
        
        newsTableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
    }
    
}

extension NewsTableViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as? NewsCell else { fatalError() }
        //Зададим надпись ячейки
        cell.newsOwner.text = newsList[indexPath.row].newsOwner
        //Установим иконку ячейки
        cell.newsText.text = newsList[indexPath.row].newsText
        cell.newsDate.text = newsList[indexPath.row].newsDate
        cell.watchedCountLabel.text = String(newsList[indexPath.row].newsWatchedCount)
        cell.likeLabel.text = String(Int.random(in: 0 ..< 100))
        cell.newsIconView.image = UIImage(named: newsList[indexPath.row].newsID + "_icon")
        cell.newsImage.image = UIImage(named: newsList[indexPath.row].newsID + "_image")
        
        return cell
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 581
    }

    
}

extension NewsTableViewController : UITableViewDelegate {
    
}
