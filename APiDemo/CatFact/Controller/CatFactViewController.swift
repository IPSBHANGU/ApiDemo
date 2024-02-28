import UIKit

class CatFactViewController: UIViewController {

    let model = CatFactModel()
    let apiUrl = "https://catfact.ninja/fact"
    var dataFromAPI = [CatModel]()

    var fact = "waiting for API Data"
    var counter:Int = 0
    
    @IBOutlet weak var factLable: UILabel!
    @IBOutlet weak var apiHitCounter: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(refreshLable), userInfo: nil, repeats: true)
        timer.fire()
    }

    @objc func refreshLable() {
        apiHitCounter.text = "\(counter)"
        // api updates the fact with new one whenever its hit
        // displaying a static api doesnt make us cool
        // we already have timer func lets utilize it to update fact every 2
        // seconds
        fetchDatafromAPI()
        factLable.text = fact
    }

    func fetchDatafromAPI() {
        model.getCatData(url: apiUrl) { isSucceeded, data, error in
            if isSucceeded {
                guard let data = data else {return}
                self.dataFromAPI = data
                self.counter = self.counter + 1
                self.fact = self.dataFromAPI[0].fact ?? ""
            } else if let error = error {
                AlerUser.alertUser(viewController: self, title: "Error", message: "Error getting data from API: \(error)")
            }
        }
    }
}
