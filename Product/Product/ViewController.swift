//
//  ViewController.swift
//  Product
//
//  Created by Yeni Kullanıcı on 17.10.2020.
//  Copyright © 2020 Busra Nur OK. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    final let url = URL(string: "http://vaktihazar.com/product/GetProductList")
    private var productList = [Product]()
    @IBOutlet weak var tableView: UITableView!
    
    var productNameArray = [String]()
    var productIdArray = [UUID]()
    
    //listelerme ekranında bir cell e tıkladığımızdaki veriyi elimize alıp detay ekranına göndermek istediğimizdendir.
    var selectedProduct = ""
    var selectedProductId : UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableview
        tableView.delegate = self
        tableView.dataSource = self
        
        
        //Ek çubuk düğmesi öğeleri
        let plusImage   = UIImage(named: "PlusIcon")!.withRenderingMode(.alwaysOriginal)
        let plusButton   = UIBarButtonItem(image: plusImage,  style: .plain, target: self, action:#selector(didTapPlusButton))
        
        navigationItem.rightBarButtonItems = [plusButton]
        
        Json()
        tableView.tableFooterView = UIView()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //ekranın sağ üst kısmında, buraya tıkladığımızda
    @objc func didTapPlusButton(sender: AnyObject){
        //detail view controlda if i yazarken chosenInformation u kullandık. bu yüzden burada da bu veriyi boş gönderdik.
        selectedProduct = ""
        //ekranı değiştirmesini söylüyoruz
        performSegue(withIdentifier: "toProductDetailVC", sender: nil)
    }
    
    
    //sağ üsteki artı butonuna tıklamak yerine listeleme kısmındaki veriye tıkladığında toDetailVC ye git diyoruz
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedProduct = productNameArray[indexPath.row]
        selectedProductId = productIdArray[indexPath.row]
        performSegue(withIdentifier: "toProductDetailsVC", sender: nil)
    }
    
    
    func Json() {
        guard let downloadURL = url else { return }
        URLSession.shared.dataTask(with: downloadURL) { data, URLResponse, error in
            guard let data = data, error == nil, URLResponse != nil else {
                print("something is wrong")
                return }
             print("downloaded")
            do{
                let decoder = JSONDecoder()
                let downloadProducts = try decoder.decode(GetProductsResponseMesssage.self, from: data)
                self.productList = downloadProducts.productList
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }catch{
                print("something wrong after download")
            }
            
            }.resume()
        
    }
    
    
    //Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList.count
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as? ProductTableViewCell
        cell?.productNameLabel.text = "Product Id: \(productList[indexPath.row].ProductId)" + "Product Name: \(productList[indexPath.row].Name)" + "Created Date: \(productList[indexPath.row].CreatedDate)"
        cell?.contentView.backgroundColor = UIColor.darkGray
        cell?.backgroundColor = UIColor.darkGray
        return cell!
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}

