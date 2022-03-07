//
//  UpdateView.swift
//  TodoApp
//
//  Created by Liam Gleeson on 3/4/22.
//

import SwiftUI

struct UpdateView: View {
    let screenSize = UIScreen.main.bounds
    
    var title: String = ""
    @Binding var taskTitle: String
    @Binding var taskDate: String
   // @Binding var taskComplete: Bool
    @Binding var isShown: Bool
    var onCreate1: (String, String) -> Void = { _,_  in }
    var onCreate2: (String) -> Void = { _ in }
    var onCancel: () -> Void = { }
    
    
    
    var body: some View {
        VStack{
            Text(title)
            TextField("Name", text: $taskTitle).textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Due date", text: $taskDate).textFieldStyle(RoundedBorderTextFieldStyle())
            
            HStack{
                Button("Cancel"){
                    self.isShown = false
                    self.onCancel()
                }
                Button("Update"){
                    self.isShown = false
                    Task{
                      //  await Api().updateTask(new_id: , params: <#T##NewTask#>)
                    }
                }
            }
        }.padding()
            .frame(width: screenSize.width * 0.7, height: screenSize.height * 0.3)
            .background(Color(#colorLiteral(red: 0.9268686175, green: 0.9416290522, blue: 0.9456014037, alpha: 1)))
            .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
            .offset(y: isShown ? 0 : screenSize.height) //to hide the createview
            .shadow(color: Color(#colorLiteral(red: 0.8596749902, green: 0.854565084, blue: 0.8636032343, alpha: 1)), radius: 6, x: -9, y: -9)
    }
}

struct UpdateView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateView(title: "Update a task", taskTitle: .constant(""), taskDate: .constant(""), isShown: .constant(true))
    }
}
