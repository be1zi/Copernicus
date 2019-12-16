//
//  ContentView.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 14/12/2019.
//  Copyright © 2019 Konrad Bełzowski. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let text = "test.test".localized()
    
    var body: some View {
        Text(text)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
