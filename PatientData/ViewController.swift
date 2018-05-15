//
//  ViewController.swift
//  PatientData
//
//  Created by ahmed talaat on 5/13/18.
//  Copyright © 2018 ahmed talaat. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    
    @IBOutlet weak var lab1: UILabel!
    @IBOutlet weak var lab2: UILabel!
    @IBOutlet weak var lab3: UILabel!
    @IBOutlet weak var lab4: UILabel!
    @IBOutlet weak var lab5: UILabel!
    @IBOutlet weak var lab6: UILabel!
    @IBOutlet weak var lab7: UILabel!
    @IBOutlet weak var lab8: UILabel!
    
    @IBAction func GetData(_ sender: Any) {
        /*let URLJsonString = "http://35.189.115.23:8081/patient/profile/01111111112"
        guard let url = URL(string: URLJsonString) else {return}
        URLSession.shared.dataTask(with: url) { (data , response , error) in
            guard let data = data else { return }
            do {
                //var allAdresses = jsonData.patientAddresses
                var adresse1 = self.allAdresses![0]
                
                let jsonData = try JSONDecoder().decode(patientData.self,from :data)
                self.lab1.text = ("Patient ID : \(jsonData.id!) \n\nPatient Name : \(jsonData.fullName!) \n\nPatient birthDate : \(jsonData.birthDate!) \n\nPatient lat : \(jsonData.lat!) \n\nPatient lng : \(jsonData.lng!) \n\nPatient Addresses Name : \(adresse1.name!) \n\nPatient gender :\(jsonData.gender!) \n\nPatient creationTime : \(jsonData.creationTime!)")
//                self.lab1.text = ("Patient Name : \n\(jsonData.fullName!)")
//                self.lab1.text = ("Patient birthDate : \n\(jsonData.birthDate!)")
//                self.lab1.text = ( "Patient lat : \n\(jsonData.lat!)")
//                self.lab1.text = ("Patient lng : \n\(jsonData.lng!)")
//                self.lab1.text = ("Patient Addresses Name : \n\(adresse1.name!)")
//                self.lab1.text = ("Patient gender : \n\(jsonData.gender!)")
//                self.lab1.text = ("Patient creationTime : \n\(jsonData.creationTime!)")
//            
            }catch let err {
                print(err.localizedDescription)
            }
            }.resume()*/
        
        
        let alert = UIAlertController(title: "Wellcome", message:  " HI ", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    struct adresses :Decodable {
        let name: String?
        let areaId: Int?
        let lat :Double?
        let lng :Double?
        let firstAddress :String?
        let secondAddress :String?
        let optionalData :String?
    }
    
    struct patientData :Decodable {
        let id :Int?
        let fullName :String?
        let birthDate :Int?
        let lat :Double?
        let lng :Double?
        let patientAddresses :[adresses]?
        let gender :Bool?
        let creationTime :Int?
    }
    
    
    @IBOutlet weak var progress: UILabel!
    var activityindicator :UIActivityIndicatorView = UIActivityIndicatorView()
    
    var allAdresses : [adresses]?
    override func viewDidLoad() {
        super.viewDidLoad()
//            self.activityindicator.center = self.view.center
//            self.activityindicator.hi  desWhenStopped = true
//            self.activityindicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
//            view.addSubview(self.activityindicator)
//            self.activityindicator.startAnimating()
//            UIApplication.shared.beginIgnoringInteractionEvents()
        
            var t = TimeZone(abbreviation: "")
            let URLJsonString = "http://35.189.115.23:8081/patient/profile/01111111112"
            guard let url = URL(string: URLJsonString) else {return}
            URLSession.shared.dataTask(with: url) { (data , response , error) in
                DispatchQueue.main.async {
                guard let data = data else { return }
                do {
                    let jsonData = try JSONDecoder().decode(patientData.self,from :data)
                    self.allAdresses = jsonData.patientAddresses
                    let adresse1 = self.allAdresses![0]
                    var gender = "Female"
                    if jsonData.gender == true {
                        gender = "Male"
                    }
                    self.lab1.text = ("Patient ID : \(jsonData.id!) \n\nPatient Name : \(jsonData.fullName!) \n\nPatient birthDate : \(jsonData.birthDate!) \n\nPatient lat : \(jsonData.lat!) \n\nPatient lng : \(jsonData.lng!) \n\nPatient Addresses Name : \(adresse1.name!) \n\nPatient gender :\(gender) \n\nPatient creationTime : \(jsonData.creationTime!)")
                    print("Patient ID : \(jsonData.id!)")
                    print("Patient Name : \(jsonData.fullName!)")
                    print("Patient birthDate : \(jsonData.birthDate!)")
                    print("Patient lat : \(jsonData.lat!)")
                    print("Patient lng : \(jsonData.lng!)")
                    print("Patient Addresses : \n\(jsonData.patientAddresses!)")
                    print("Patient gender : \(jsonData.gender!)")
                    print("Patient creationTime : \(jsonData.creationTime!)")

                }catch let err {
                    print(err.localizedDescription)
                }
                }}.resume()
        }
}

