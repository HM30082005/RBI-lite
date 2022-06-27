//
//  ViewController.swift
//  RBI-lite
//
//  Created by mihail haretonenko on 26.06.2022.
//

import UIKit



class ViewController: UIViewController {

    struct recipe: Decodable {
        let id: Int
        let title: String
        let description: String
        let ingridients: [String]
        let directions: String
    }
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    private func parse(jsonData: Data) {
        guard let recipes = try? JSONDecoder().decode([recipe].self, from: jsonData) else {
            print("Decode Error")
            return
        }
        print(recipes)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let localData = self.readLocalFile(forName: "recipes") {
            self.parse(jsonData: localData)
        }
    }


}

