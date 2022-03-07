//
//  ViewModel.swift
//  TodoApp
//
//  Created by Liam Gleeson on 3/3/22.
//

//crudRepo

import Foundation
import Alamofire



struct todo {
    
    
    
    func fetchAll() async{
        //fetches data fromm apiRepo (which is the api call) and then
        //will have all tasks from db
        // can then call the view and have it fill in with the data from apiRepo
        var allTasks: [Todo] = []
        allTasks = await Api().getTasks()
        
        
        
        
        
        
    }
    
    
    
}
