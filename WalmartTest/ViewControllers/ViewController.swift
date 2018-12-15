//
//  ViewController.swift
//  WalmartTest
//
//  Created by Shanmin on 2018-12-12.
//  Copyright © 2018 Heavenbrook. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let carViewModel = CarViewModel()
        var sortBy = "name"
        
        carViewModel.navigationTitle.bind(to: self.navigationItem.rx.title).disposed(by: disposeBag)
        
        carViewModel.cars.asObservable().bind(to: tableView.rx.items) { (tableView, row, element) in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else {
                return UITableViewCell()
            }
            cell.textLabel?.text = element.name
            let makeString = element.make ?? ""
            let modelString = element.model ?? ""
            let statusString = element.available.rawValue
            cell.detailTextLabel?.text = makeString + " - " + modelString + " [" + statusString + "]"
            cell.imageView?.image = UIImage(named: element.img ?? "")
            return cell
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(CarModel.self)
            .subscribe(onNext: { [weak self] item in
                self?.performSegue(withIdentifier: "carDetail", sender: item)
            }).disposed(by: disposeBag)
        
        let rightBarButton = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: nil)
        
        rightBarButton.rx.tap.subscribe(onNext: { [weak self] in
            let alert = UIAlertController(title: "Sort by", message: nil, preferredStyle: .actionSheet)
    
            alert.addAction(UIAlertAction(title: (sortBy == "name" ? "* " : "") + "Name", style: .default, handler: { action in
                carViewModel.sortBy(path: \CarModel.name)
                sortBy = "name"
            }))
            alert.addAction(UIAlertAction(title: (sortBy == "availability" ? "* " : "") + "Availability", style: .default, handler: { action in
                carViewModel.sortBy(path: \CarModel.available.rawValue)
                sortBy = "availability"
            }))
            self?.present(alert, animated: true, completion: nil)
        }).disposed(by: disposeBag)
        self.navigationItem.rightBarButtonItem = rightBarButton
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "carDetail" {
            if let vc = segue.destination as? CarDetailViewController {
                vc.carModel = sender as? CarModel
            }
        }
    }
}

