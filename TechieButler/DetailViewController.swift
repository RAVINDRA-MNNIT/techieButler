//
//  DetailViewController.swift
//  TechieButler
//
//  Created by Ravindra Arya on 03/05/24.
//

import UIKit

class DetailViewController: UIViewController 
{
    var data : DataModel?
    @IBOutlet weak var tableView: UITableView!
    {
        didSet
        {
            tableView.dataSource = self
            tableView.register(UINib(nibName: ListTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ListTableViewCell.reuseIdentifier)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Details"
    }
}

extension DetailViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.reuseIdentifier) as? ListTableViewCell else { return UITableViewCell()}
        cell.cellTitle.text = data?.title
        var userId = data?.userID == nil ? "N/A" : "\(data?.userID ?? 0)"
        var id = data?.id == nil ? "N/A" : "\(data?.id ?? 0)"
        cell.userId.text = "User Id- " + userId
        cell.Id.text = "Id- " + id
        cell.Id.textColor = UIColor.systemBlue.withAlphaComponent(0.8)
        cell.userId.textColor = UIColor.systemBlue.withAlphaComponent(0.8)
        cell.cellDescription.text = "Description- " + (data?.body ?? "")
        cell.cellDescription.textColor = UIColor.gray
        cell.containerView.layer.cornerRadius = 10
        cell.containerView.clipsToBounds = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
