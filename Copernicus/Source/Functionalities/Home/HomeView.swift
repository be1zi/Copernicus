//
//  ContentView.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 14/12/2019.
//  Copyright © 2019 Konrad Bełzowski. All rights reserved.
//

import SwiftUI

struct HomeView: View {
        
    var body: some View {
        
        VStack {
            Spacer()
            
            Button(action: {
                print("polish")
            }) {
                Text("language.polish".localized())
                    .frame(width: ElementSize.Button.width.rawValue, height: 44.0, alignment: .center)
                    .background(Color.red)
                    .foregroundColor(.white)
            }
            
            Button(action: {
                print("English")
            }) {
                Text("language.english".localized())
                    .frame(width: ElementSize.Button.width.rawValue, height: 44.0, alignment: .center)
                    .background(Color.red)
                    .foregroundColor(.white)
            }.offset(x: 0.0, y: 20.0)
            
        }.padding(EdgeInsets(top: 30, leading: 20, bottom: 50, trailing: 20))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
