//
//  ContentView.swift
//  TodoApp
//
//  Created by Liam Gleeson on 3/1/22.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    
    @State var tasks: [Todo] = []

    
    var body: some View {
        
        HomeView()
      
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
