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
