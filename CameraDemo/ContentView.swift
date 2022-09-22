//
//  ContentView.swift
//  CameraDemo
//
//  Created by PPG on 28.08.22.
//

import SwiftUI

struct ContentView: View {
    @State private var showSheet: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State private var image: UIImage?
    

    var body: some View {
        NavigationView{
            
            VStack{
                Image(uiImage: image ?? UIImage(named: "placeholder")!)                    .resizable().frame(width: 100, height: 100)
                
                Button("Chosse Picture"){
                    self.showSheet = true
                    
                }.padding()
                    .actionSheet(isPresented: $showSheet) {
                        ActionSheet(title: Text("Select Photo"),
                                    message: Text("Choose"), buttons:[
                                        .default(Text("Photo Library")){
                                            self.showImagePicker = true
                                            self.sourceType = .photoLibrary
                                        },
                                        .default(Text("Camera")){
                                            self.showImagePicker = true
                                            self.sourceType = .camera
                                        },
                                        .cancel()
                                        
                                    ])
                    }
                // upload image
                Button(action: {
                    // convert image into base 64
                    let uiImage: UIImage = image ?? UIImage(named: "placeholder")!
                    let imageData: Data = uiImage.jpegData(compressionQuality: 0.1) ?? Data()
                    
                    let imageStr: String = imageData.base64EncodedString()
                    

                    
                    //send request to server
                    guard let url: URL = URL(string: "http://localhost:3000/createBilling")
                            else{
                                print("invalid URL")
                        return
                            }
                    
                    // create parameters
                    let paramStr: String = "image=\(imageStr)"
                    
                    let paramData: Data = paramStr.data(using: .utf8) ?? Data()

                    var urlRequest: URLRequest = URLRequest(url:url)
                    urlRequest.httpMethod = "POST"
                    urlRequest.httpBody = paramData
                    // required for sending large data
                    urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                    
                    // send the request
                    URLSession.shared.dataTask(with: urlRequest, completionHandler: {
                        (data, request, error) in guard let data = data else {
                            print("invalid data")
                            return
                        }
                        
                        // show response in string
                        let responseStr: String = String(data: data, encoding: .utf8) ?? ""
                        
                        print(responseStr)
                    })
                    .resume()
                    
                }, label: {
                    Text("Upload Image")
                })
            }
            .navigationBarTitle("Camera Demo")
            
        }.sheet(isPresented: $showImagePicker) {
            ImagePicker(isShown: self.$showImagePicker, image: self.$image, sourceType: self.sourceType)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
