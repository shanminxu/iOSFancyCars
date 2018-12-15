//
//  CarDetailViewController.swift
//  WalmartTest
//
//  Created by Shanmin on 2018-12-13.
//  Copyright © 2018 Heavenbrook. All rights reserved.
//

import UIKit
import RxSwift
import ObjectMapper

class CarDetailViewController: UITableViewController {
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var carName: UILabel!
    @IBOutlet weak var carMake: UILabel!
    @IBOutlet weak var carModelLabel: UILabel!
    @IBOutlet weak var carYear: UILabel!
    @IBOutlet weak var carStatus: UILabel!
    
    var carModel: CarModel?
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let carModel = carModel {
            carImage.image = UIImage(named: carModel.img ?? "")
            carName.text = carModel.name
            carMake.text = carModel.make
            carModelLabel.text = carModel.model
            carYear.text = carModel.year
            self.navigationItem.title = carModel.name
            
            carStatus.text = carModel.available.rawValue
            if carModel.available == .inDealership {
                let rightBarButton = UIBarButtonItem(title: "Buy", style: .plain, target: self, action: nil)
                rightBarButton.rx.tap.subscribe(onNext: { [weak self] in
                    let alert = UIAlertController(title: "Alert", message: "Make sure you have enough money!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self?.present(alert, animated: true, completion: nil)
                }).disposed(by: disposeBag)
                self.navigationItem.rightBarButtonItem = rightBarButton
            }
        }
    }
    

    

}
