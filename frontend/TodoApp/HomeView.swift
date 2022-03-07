//
//  HomeView.swift
//  TodoApp
//
//  Created by Liam Gleeson on 3/7/22.
//

import SwiftUI

struct HomeView: View {
    
    @State var tasks: [Todo] = []
    //state variables for creating a task
    @State private var isPresented: Bool = false
    @State private var titleInput: String = ""
    @State private var dateInput: String = ""
    
    var body: some View {

        NavigationView {
            
            ZStack {
                VStack{
                    List(tasks) { task in
                        
                        HStack{
                            VStack(alignment: .leading, spacing: 10){
                                Text(task.title).fontWeight(.bold)
                                Text("Created at:  \(task.createdAt)").font(.callout)
                                Text("Due date:  \(task.dueDate)").font(.callout)
                            }
                            Spacer()
                            VStack{
                                //change status to complete
                                Button {
                                    Task {
                                        await Api().compeleteTask(new_id: task.id)
                                        //compeleteTask(new_id: task.id)
                                    }
                                } label: {
                                    Image(systemName: "checkmark")
                                }.buttonStyle(.bordered).foregroundColor(Color.green)
                                    
                                //delete task
                                Button {
                                    Task {
                                        await Api().deleteTask(new_id: task.id)
                                    }
                                    
                                } label: {
                                    Image(systemName: "trash.fill")
                                }.buttonStyle(.bordered).foregroundColor(Color.red)
                                
                                //update task
                                Button {
                                    
                                  //  UpdateView(title: "Create a task", taskTitle: $titleInput, taskDate: $dateInput,  isShown: $isPresented, id: task.id)
                                     
                                    
                                } label: {
                                    Image(systemName: "pencil")
                                }.buttonStyle(.bordered).foregroundColor(Color.blue)
                            }
                        }
                        
                    }.task {
                        tasks = await Api().getTasks()
                    }
                    
                }
                
                CreateView(title: "Create a task", taskTitle: $titleInput, taskDate: $dateInput,  isShown: $isPresented)
                
            }
            
            .navigationBarTitle("Task Tracker").navigationBarTitleDisplayMode(.inline)
            /*
            .navigationBarItems(trailing: Button {
                self.titleInput = ""
                self.dateInput = ""
                self.isPresented = true
                
                /*
                Task{
                    await Api().createTask(NewTask(title: titleInput, dueDate: dateInput))
                }
                 */
                
                
            } label: {
                Image(systemName: "plus")
            }.buttonStyle(.bordered)
            )
             */
            .navigationBarItems(trailing:
                                    Button(action: {
                self.titleInput = ""
                self.dateInput = ""
                self.isPresented = true
                print("button")
                Task {
                    
                }
                
            }) {
                Image(systemName: "plus")
            }.buttonStyle(.bordered)
            )
                                
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
