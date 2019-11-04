//
//  CountriesTableViewController.swift
//  Weather
//
//  Created by Narine Balasanyan on 11/3/19.
//  Copyright © 2019 Fifth. All rights reserved.
//

import UIKit

class CountriesTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var countriesData: Countries?
    
    // MARK: - View initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        getCountriesData()
    }
    
    // MARK: - Methods
    
    func getCountriesData() {
        if let jsonData = loadCountriesJson() {
            let decoder = JSONDecoder()
            
            do {
                let countries = try decoder.decode(Countries.self, from: jsonData)
                self.countriesData = countries
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func loadCountriesJson() -> Data? {
        if let path = Bundle.main.path(forAuxiliaryExecutable: "cities.json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch {
                print(error.localizedDescription)
                return nil
            }
        }
        return nil
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countriesData?.countries.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCellIds.countryCell, for: indexPath)
        cell.textLabel?.text = countriesData?.countries[indexPath.row].city
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let weatherVC = self.tabBarController?.viewControllers?[0] as? WeatherViewController {
            weatherVC.country = countriesData?.countries[indexPath.row]
            self.tabBarController?.selectedIndex = 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
