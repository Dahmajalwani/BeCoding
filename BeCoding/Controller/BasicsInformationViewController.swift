//
//  BasicsInformationViewController.swift
//  BeCoding
//
//  Created by dahma alwani on 07/06/1443 AH.
//

import Foundation
import UIKit

class BasicsInformationViewController: UIViewController {

    @IBOutlet weak var viewHidder: UIView!
    {
        didSet{
            viewHidder.layer.borderColor = UIColor.tertiarySystemBackground.cgColor
            viewHidder.layer.borderWidth = 0
            viewHidder.layer.cornerRadius = 20
            viewHidder.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            viewHidder.layer.masksToBounds = true
            viewHidder.isUserInteractionEnabled = true
        }
    }
    
    
    @IBOutlet weak var theTableView: UITableView! {
        didSet {
        theTableView.delegate = self
        theTableView.dataSource = self
    }
    }
    var items:[[Item]] = Item.all
    
    var sectionTitles = ["Section1","Section2","Section3"]
    var selectedItem:Item?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let sendTo = segue.destination as! ViewControllerForShow
        sendTo.selectedItem = selectedItem
     
    }
}
extension BasicsInformationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"ItemCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = items[indexPath.section][indexPath.row].theName
        content.secondaryText = items[indexPath.section][indexPath.row].theDetails
        let image = UIImage(named: items[indexPath.section][indexPath.row].theImage)
        
        content.image = image
        content.imageProperties.maximumSize = CGSize(width: 60, height: 60)
    
        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator
        return cell


}
    }
extension BasicsInformationViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == sectionTitles.count - 1{
            return "this is the footer"
        }else {
            return ""
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
        view.backgroundColor = .systemGray2
        let label = UILabel(frame: CGRect(x: 10, y: 0, width: UIScreen.main.bounds.width, height: 40))
        label.text = sectionTitles[section]
        label.textColor = .white
        view.addSubview(label)
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItem = items[indexPath.section][indexPath.row]
        performSegue(withIdentifier: "goToShow", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

