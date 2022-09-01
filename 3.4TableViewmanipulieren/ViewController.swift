//
//  ViewController.swift
//  3.4TableViewmanipulieren
//
//  Created by Mirko Weitkowitz on 01.09.22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var packListTV: UITableView!
    
    var packListe = ["Koffer","Hosen","T-Shirts","Socken",]
    var gepackteListe = ["Zahnbürste"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //        TODO:3. DataSource übergeben
        packListTV.dataSource = self
        packListTV.delegate = self
    }
    
    
    
    @IBAction func editBar(_ sender: UIBarButtonItem) {
        
    }
    @IBAction func addPackStück(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Neues Packstück", message: "Bitte gib dein neues Packstück ein", preferredStyle: .alert)
        
        let addAction = UIAlertAction(title: "OK", style: .default) { (_) in
            
            
            let textField = alert.textFields?.first
            let packToAdd = textField?.text
            
            //         Packstücke hinzufügen und TV updaten
            self.packListe.append(packToAdd!)
            self.packListTV.reloadData()
        }
        
        alert.addTextField()
        alert.addAction(addAction)
        
        present(alert, animated:true)
        
    }
    
}

//MARK: Extension_ DataSource
//TODO: 1. Protokol einfügen

extension ViewController: UITableViewDataSource,UITableViewDelegate{
  
    
//    TODO: 2. Essentielle Funktion einfügen
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return packListe.count
        return (section == 0) ? packListe.count : gepackteListe.count
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 2
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if (section == 0){
//            return "Noch einzupacken"
//        } else  {
//
//            return "bereits eingepackt"
//        }
        
//        MARK: If bedingung kurzschreibweise
        return (section == 0) ? "Noch einzupacken": "bereits eingepackt"
            
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            packListe.remove(at: indexPath.row)
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    
    
        
// Cell registrieren
        let cell = packListTV.dequeueReusableCell(withIdentifier: "packCell", for: indexPath)
        
// Inhalte / Eigenschaften der Cell anpassen
        var content = cell.defaultContentConfiguration()
        if (indexPath.section == 0) {
            
            content.text = packListe[indexPath.row]
            cell.accessoryType = .none
           
        }else {
            content.text = gepackteListe[indexPath.row]
            cell.accessoryType = .checkmark
        }
      
            cell.contentConfiguration = content
        return cell
    }
    func tableView(_ tableView:UITableView, commit editingStyle:UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete {
            packListe.remove(at: indexPath.row)
            packListTV.deleteRows(at: [indexPath], with: .fade)
        }

    }
}
