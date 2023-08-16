import UIKit

class ViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func getWeatherButtonTapped(_ sender: UIButton) {
        if let city = cityTextField.text, !city.isEmpty {
            fetchWeather(city: city)
        }
    }
    
    func fetchWeather(city: String) {
        
        let apiKey = "7cd2a1d82a8721c453fbcef061d5246d"
        
       
        if let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)") {
            let session = URLSession.shared
            
            
            let task = session.dataTask(with: url) { data, response, error in
                if let data = data {
                   
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                
                        if let main = json["main"] as? [String: Any], let temperature = main["temp"] as? Double {
                         
                            let temperatureCelsius = temperature - 273.15
                            
                            // Step 7: Update the label on the main thread
                            DispatchQueue.main.async {
                                self.weatherLabel.text = "Temperature: \(temperatureCelsius)°C"
                            }
                        }
                    }
                }
            }
            
            
            task.resume()
        }
    }
}
