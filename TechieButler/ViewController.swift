//
//  ViewController.swift
//  TechieButler
//
//  Created by Ravindra Arya on 03/05/24.
//

import UIKit

class ViewController: UIViewController {
    
    var dataList : [DataModel]?
    var currentPage = 1
    var noData = false

    @IBOutlet weak var tableView: UITableView!
    {
        didSet
        {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: ListTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ListTableViewCell.reuseIdentifier)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "List"
        apiCall()
    }
}

extension ViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.reuseIdentifier) as? ListTableViewCell else { return UITableViewCell()}
        cell.cellTitle.text = dataList?[indexPath.row].title
        var userId = dataList?[indexPath.row].userID == nil ? "N/A" : "\(dataList?[indexPath.row].userID ?? 0)"
        var id = dataList?[indexPath.row].id == nil ? "N/A" : "\(dataList?[indexPath.row].id ?? 0)"
        cell.userId.text = "User Id- " + userId
        cell.Id.text = "Id- " + id
        cell.Id.textColor = UIColor.systemBlue.withAlphaComponent(0.8)
        cell.userId.textColor = UIColor.systemBlue.withAlphaComponent(0.8)
        cell.cellDescription.text = "Description- " + (dataList?[indexPath.row].body ?? "")
        cell.cellDescription.textColor = UIColor.gray
        cell.containerView.layer.cornerRadius = 10
        cell.containerView.clipsToBounds = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !noData && indexPath.row == (dataList?.count ?? 1) - 1 {
            currentPage += 1
            apiCall()
        }
    }
}

extension ViewController : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.data = dataList?[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController
{
    func apiCall()
    {
        Task{
            do {
                let data = try await APISniper.shared.fetchData(request: DataRequestModel(page: currentPage,limit: 10).getUrlRequest(), returnType: [DataModel].self)
                noData = data.count > 0 ? false : true
                if (dataList?.count ?? 0) > 0
                {
                    dataList?.append(contentsOf: data)
                }
                else
                {
                    dataList = data
                }
                self.tableView.reloadData()
            } catch {
                print(error)
            }
        }

    }
}

