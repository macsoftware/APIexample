//
//  ViewController.swift
//  APIexample
//
//  Created by Ian MacKinnon on 18/01/2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getRatesClicked(_ sender: Any) {
        
        // Create Request & Session
        let url = "https://api.apilayer.com/fixer/latest"
        var request = URLRequest(url: URL(string: url)!, timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        request.addValue("g0SlQ34z2eBYHJEF5vxCxgJaGL4OTNYZ", forHTTPHeaderField: "apikey")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if(error != nil){
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }else{
                if( data != nil){
                    // Get Response & Data
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        // ASYNC
                        // Parse & JSON Serialisation
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String : Any] {
                                if let cad = rates["CAD"] as? Double {
                                    self.cadLabel.text = "CAD: \(cad)"
                                }
                                if let chf = rates["CHF"] as? Double {
                                    self.chfLabel.text = "CHF: \(chf)"
                                }
                                if let gbp = rates["GBP"] as? Double {
                                    self.gbpLabel.text = "GBP: \(gbp)"
                                }
                                if let jpy = rates["JPY"] as? Double {
                                    self.jpyLabel.text = "JPY: \(jpy)"
                                }
                                if let usd = rates["USD"] as? Double {
                                    self.usdLabel.text = "USD: \(usd)"
                                }
                                if let turk = rates["TRY"] as? Double {
                                    self.tryLabel.text = "TRY: \(turk)"
                                }
                            }
                        }
                    }catch{
                        print("error")
                    }
                    
                }
            }
        }
        
        task.resume()
    }
    
}

