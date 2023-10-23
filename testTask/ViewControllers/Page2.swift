//
//  Page2.swift
//  testTask
//
//  Created by Edgar Sargsyan on 19.10.23.
//

import UIKit

class Page2: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    struct Trader {
        let lableNumber: String
        let imageName: String
        let name: String
        var deposit: Int
        var profit: Int
        let weight: Int
    }
    
    let header: [String] = ["№","Country","  Name","          Deposit  ","       Profit" ]
    var data: [Trader] = [
        Trader(lableNumber: "1",imageName: "usa", name: "Oliver", deposit: 2367, profit: 336755, weight: 5),
        Trader(lableNumber: "2",imageName: "canada", name: "Jack", deposit: 1175, profit: 148389, weight: 3),
        Trader(lableNumber: "3",imageName: "brazil", name: "Herry", deposit: 1000, profit: 113888, weight: 4),
        Trader(lableNumber: "4",imageName: "korea", name: "Jacob", deposit: 999, profit: 36755, weight: 2),
        Trader(lableNumber: "5",imageName: "germany", name: "Charley", deposit: 888, profit: 18389, weight: 5),
        Trader(lableNumber: "6",imageName: "brazil", name: "Thomas", deposit: 777, profit: 12000, weight: 4),
        Trader(lableNumber: "7",imageName: "france", name: "George", deposit: 666, profit: 11111, weight: 3),
        Trader(lableNumber: "8",imageName: "zealand", name: "Oscar", deposit: 555, profit: 9988, weight: 2),
        Trader(lableNumber: "9",imageName: "india", name: "James", deposit: 444, profit: 8877, weight: 4),
        Trader(lableNumber: "10",imageName: "spain", name: "William", deposit: 333, profit: 6652, weight: 5)    ]
    
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(updateData), userInfo: nil, repeats: true)
    }
    
    @objc func updateData() {
        let totalWeight = data.reduce(0, { $0 + $1.weight })
        let randomWeight = Int.random(in: 1...totalWeight)
        var selectedTrader: Trader?
        var currentWeight = 0
        
        for trader in data {
            currentWeight += trader.weight
            if randomWeight <= currentWeight {
                selectedTrader = trader
                break
            }
        }
        
        guard let trader = selectedTrader else {
            return
        }
        
        let depositIncrease = Int.random(in: 50...150)
        let profitIncrease = Int.random(in: 50...150)
        let updatedTrader = Trader(
            lableNumber: trader.lableNumber,
            imageName: trader.imageName,
            name: trader.name,
            deposit: trader.deposit + depositIncrease,
            profit: trader.profit + profitIncrease,
            weight: trader.weight
        )
        
        if let index = data.firstIndex(where: { $0.lableNumber == updatedTrader.lableNumber }) {
            data[index] = updatedTrader
            let indexPath = IndexPath(row: index, section: 0)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}

extension Page2: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let trader = data[indexPath.row]
        
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! CustomTableViewCell
        cell2.lable1.text = trader.lableNumber
        cell2.lableName.text = trader.name
        cell2.lableDeposit.text = String(trader.deposit)
        cell2.lableProfit.text = String(trader.profit)
        cell2.iconImageView.image = UIImage(named: trader.imageName)
        
        if indexPath.row % 2 == 0 {
            cell2.backgroundColor = .clear
        } else {
            cell2.backgroundColor = .specificGray
        }
        
        return cell2
    }
    
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
         headerView.backgroundColor = .specificGray

        let label = UILabel()
        label.text = "№ Country   Name           Deposit        Profit"
        label.textColor = UIColor.lightGray
         label.frame = CGRect(x: 16, y: 15, width: tableView.frame.width, height: 20)
        headerView.addSubview(label)

        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

extension UIColor {
    static var specificGray: UIColor {
        return UIColor(named: "SpecificGray")!
    }
}
