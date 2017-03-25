//
//  ItemDetailsVC.swift
//  Lista zelja
//
//  Created by Vuk on 3/25/17.
//  Copyright © 2017 Vuk. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var priceField: CustomTextField!
    @IBOutlet weak var detailField: CustomTextField!
    @IBOutlet weak var thumbImg: UIImageView!
    
    var stores = [Store]()
    var itemToEdit: Item?
    var imagePicker: UIImagePickerController!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        storePicker.delegate = self
        storePicker.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self

        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil) //ovim sam promenio back dugme u navigation baru, koje je ispisivalo <Lista_zelja , a sad ispisuje <
        }
        
        /*  Ubacio sam test rezultate, tj napunio niz stores
        let store = Store(context: context)
        store.name = "Best Buy"
        let store2 = Store(context: context)
        store2.name = "Tesla INC"
        let store3 = Store(context: context)
        store3.name = "Frys Electronics"
        let store4 = Store(context: context)
        store4.name = "Target"
        let store5 = Store(context: context)
        store5.name = "Amazon"
        let store6 = Store(context: context)
        store6.name = "K Mart"
        
        mojDelegat.saveContext()
         */
        getStores()
        
        if itemToEdit != nil {
            loadItemData()
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let store = stores[row]
        return store.name
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //
    }
    
    func getStores() {
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        do {
            self.stores = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
        } catch let error as NSError {
            print(error.debugDescription)
        }
        
    }
    @IBAction func savePressed(_ sender: UIButton) {
        var item: Item!
        
        let picture = Image(context: context)
        picture.image = thumbImg
        
        //item.toimage = picture //entitet se dodaljuje entitetu preko relationshipa
        
        //ovaj if/else je da bi mogli da editujemo a ne samo da dodajemo nove iteme
        if itemToEdit == nil {
            item = Item(context: context)
        } else {
            item = itemToEdit
        }
        
        item.toimage = picture // i mora da se prebaci ispod if/else zato sto jos uvek nije odluceno da li ce upisuje nove podatke u bazu ili ce da edituje podatke iz baze
        
        
        //postavljam vrednosti koje cu cuvati u bazi
        if let title = titleField.text {
            item.title = title
        }
        if let price = priceField.text {
            item.price = Double(price)!
        }
        if let detail = detailField.text {
            item.details = detail
        }
        item.toStore = stores[storePicker.selectedRow(inComponent: 0)] //piker je jednokomponentni, pa mu je indeks nula
        //i sad ih cuvam
        mojDelegat.saveContext()
        
        _ = navigationController?.popViewController(animated: true) //ovo ispred sam dodao da bi sklonio ono zuto upozorenje
    }
    
    func loadItemData() {
        if let item = itemToEdit { // ovo je samo da je ne bih pisao itemToEdit 100X
            titleField.text = item.title
            priceField.text = String(item.price)
            detailField.text = item.details
            thumbImg.image = item.toimage?.image as? UIImage
            
            if let store = item.toStore {
                var index = 0
                repeat {
                    let s = stores[index]
                    if s.name == store.name {
                        storePicker.selectRow(index, inComponent: 0, animated: false)
                        break
                    }
                    index *= 1
                } while index < stores.count
            }
        }
    }
    
    @IBAction func deletePressed(_ sender: UIBarButtonItem) {
        
        if itemToEdit != nil {
            context.delete(itemToEdit!)
            mojDelegat.saveContext()
        }
        _ = navigationController?.popViewController(animated: true) //ovo ispred sam dodao da bi sklonio ono zuto upozorenje
    }
    
    @IBAction func addImage(_ sender: UIButton) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
            thumbImg.image = img
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    

}
