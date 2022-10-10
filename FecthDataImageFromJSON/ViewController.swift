//
//  ViewController.swift
//  FecthDataImageFromJSON
//
//  Created by Vikram Kunwar on 10/10/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    var winnerList = [SportsData]()

    @IBOutlet weak var MyCVC: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: Fecthing Sports APi Data from JSON -------------------------------------
    func fetchData(){
        
        let url = URL(string: "http://haritibhakti.com/commonwealth/goldwinner.json")
        let task = URLSession.shared.dataTask(with: url!, completionHandler: {
            (data,response,error) in
            guard let data = data , error == nil else
            {
                print("Error occurs while Accessing Data")
                return
            }
            do
            {
                self.winnerList = try JSONDecoder().decode([SportsData].self, from: data)
//                print(self.winnerList)
            }
            catch
            {
             print("Error while decoding Json data into Swift structure \(error)")
            }
            
            DispatchQueue.main.async {
                self.MyCVC.reloadData()
            }
            
        })
        task.resume()
        
    }


}
extension UIImageView
{
    func downloadImage(from url : URL){
        contentMode = .scaleToFill
        let dataTask = URLSession.shared.dataTask(with: url, completionHandler: {
            (data,response,error) in
            
            guard let httpResponse = response as? HTTPURLResponse , httpResponse.statusCode == 200,
                  let mimType = response?.mimeType , mimType.hasPrefix("image"),
                  let data = data , error == nil,
                  let image = UIImage(data: data)
            else{
                print("Error Occur while fetching data\(error)")
                return
            }
            DispatchQueue.main.async {
                self.image = image
            }
            
        })
        dataTask.resume()
    }
}
extension ViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return winnerList.count
    }
    
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = MyCVC.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionCell
       let urlImage = URL(string: winnerList[indexPath.row].imagename)
       cell.myImageView.downloadImage(from: urlImage!)
       cell.myImageView.layer.cornerRadius = 25
       cell.SportsPersonName.text = winnerList[indexPath.row].playername
       cell.SportsGame.text = winnerList[indexPath.row].gamename
       cell.layer.borderColor = UIColor.black.cgColor
       cell.layer.borderWidth = 1
       return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width-10)/2
        return CGSize(width: size, height: size)
    }
}

