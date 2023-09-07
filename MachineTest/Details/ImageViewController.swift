//
//  ImageViewController.swift
//  MachineTest
//
//  Created by Akanksha Patel on 07/09/23.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var imageUrlString: String?

        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Check if imageUrlString is valid
            guard let imageUrlString = imageUrlString, let imageUrl = URL(string: imageUrlString) else {
                return
            }
            
            // Create a URLSession task to fetch the image data
            URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
                // Check for errors
                if let error = error {
                    print("Error fetching image: \(error.localizedDescription)")
                    return
                }
                
                // Check if data is available
                guard let imageData = data else {
                    print("No image data received")
                    return
                }
                
                // Update the UI on the main thread
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: imageData)
                }
            }.resume() // Start the URLSession task
        }
    }
    





