//
//  ProductDetailsViewController.swift
//  Product
//
//  Created by Yeni Kullanıcı on 21.10.2020.
//  Copyright © 2020 Busra Nur OK. All rights reserved.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    
    @IBOutlet weak var productNameText: UITextField!
    @IBOutlet weak var productAmountText: UITextField!
    @IBOutlet weak var productPriceText: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    var responseURLString : String = ""
    var jsonData : Data!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)

    }
    
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func buttonPostClicked(_ sender: Any) {
        
        
        let productName = productNameText.text
        
        if productNameText.text == "" || productAmountText.text == nil || productPriceText.text == nil {
            
            let alert = UIAlertController(title: "Error", message: "Its Mandatort to enter all the fields.", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
            
            alert.addAction(ok)
            
            self.present(alert, animated: true, completion: nil)
            
        }
        
        if saveButton.currentTitle == "KAYDET" {
            
            let url = URL(string: "http://vaktihazar.com/product/NewProduct")
            guard let requestUrl = url else { fatalError() }
            var request = URLRequest(url: requestUrl)
            request.httpMethod = "POST"
            
            // Set HTTP Request Header (Vaşlığında ne göndereceğim)
            //token burada gönderilir
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            //textlerden bilgiler alınıyor: productNameText.text şeklinde
            //body e yazılacak kısım
            let requestBody = PostProductRequestMessage(name: productNameText.text!, amount: Int(productAmountText.text!)!, price: Float(productPriceText.text!)!)
            let jsonData = try! JSONEncoder().encode(requestBody)
            request.httpBody = jsonData
            
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                if let error = error {
                    
                    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    
                    //butona tıklanınca bir şey olmasın istediğimiz için handler a ihtiyacımız yok
                    let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                    
                    return
                }
                
                guard let data = data else {return}
                
                do{
                    
                    //datayı önce string e çeviriyorum
                    //bir formata çevirmiş isem o formata encode ettim olur
                    //orjinal formatına çevirir isem decode ederim
                    let dataString = String(data: data, encoding: .utf8)
                    //sonra onu json a çeviriyorum
                    self.jsonData = dataString!.data(using: .utf8)!
                    //json dan nesneye çevirmek decode (bana dönen cevap)
                    let response = try! JSONDecoder().decode(PostProductResponseMessage.self, from: self.jsonData)
                    
                    
                    var resultStr : String = ""
                    resultStr += "Result: \(response.result) ErrorMessage : \(response.errorMessage) \n"
                    
                    let alert = UIAlertController(title: "Information", message: resultStr, preferredStyle: .alert)
                    
                    let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    
                    alert.addAction(ok)
                    
                    self.present(alert, animated: true, completion: nil)
                    
                } catch let jsonErr{
                    
                    print(jsonErr)
                    
                }
                
            }
            
            task.resume()
            
        }
        
    }
        
  }

