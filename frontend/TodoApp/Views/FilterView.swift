////
////  FilterView.swift
////  TodoApp
////
////  Created by Liam Gleeson on 3/9/22.
////
//
import SwiftUI

//View for creating a Radio Button
struct RadioButton: View {
    
    let id: String
    let label: String
    let isSelected: Bool
    let callback: (String) -> ()
    
    init(
        id: String,
        label: String,
        isSelected: Bool = false,
        callback: @escaping (String) -> ()
    ){
        self.id = id
        self.label = label
        self.isSelected = isSelected
        self.callback = callback
    }
    
    var body: some View {
        Button(action: {
            self.callback(self.id)
        }) {
            HStack(alignment: .center, spacing: 10) {
                Image(systemName: isSelected ?
                      "largecircle.fill.circle" : "circle")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                Text(label).font(Font.system(size: 14))
                Spacer()
            }
            .foregroundColor(.black)
        }.foregroundColor(.white)
    }
}


enum Filter: String {
    case all = "All Tasks"
    case Completed = "Completed Tasks"
    case Incompleted = "Incomplete Tasks"
}

enum Sort: String {
    case Name = "Name"
    case DueDate = "Due Date"
    case CreatedAt = "Created At"
}

enum Order: String {
     case Ascending = "Ascending"
     case Descending = "Descending"
}

//View for creating all buttons needed in filterview
struct FilterView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var todoManager =  TaskViewModel()
    let callback: (String, String, String) -> ()
    
    @State var selectedFilter: String = ""
    @State var selectedSort: String = ""
    @State var selectedOrder: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Spacer()
                Text("Filter by").fontWeight(.bold)
                HStack {
                    radioAllTask
                    radioCompletedTask
                    radioIncompletedTask
                }
                Spacer()
                Text("Sort by").fontWeight(.bold)
                HStack {
                    radioNameTask
                    radioDueDatedTask
                    radioCreatedAtTask
                }
                Spacer()
                Text("Order by").fontWeight(.bold)
                HStack {
                    radioAscendingTask
                    radioDescendingTask
                }
            }
            .navigationTitle("Search By")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: cancelButton, trailing: updateSaveButton)
        }
        
    }
    
    var cancelButton: some View {
        Button("Cancel") {
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    var updateSaveButton: some View {
        Button("Apply") {
            callback(selectedFilter, selectedSort, selectedOrder)
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    //RadioTasks for each Filter button that will return its data and set the others as false
    var radioAllTask: some View {
        RadioButton(
            id: Filter.all.rawValue,
            label: Filter.all.rawValue,
            isSelected: selectedFilter == Filter.all.rawValue ? true : false,
            callback: radioGroupCallBackFilter)
    }
    var radioCompletedTask: some View {
        RadioButton(
            id: Filter.Completed.rawValue,
            label: Filter.Completed.rawValue,
            isSelected: selectedFilter == Filter.Completed.rawValue ? true : false,
            callback: radioGroupCallBackFilter)
    }
    var radioIncompletedTask: some View {
        RadioButton(
            id: Filter.Incompleted.rawValue,
            label: Filter.Incompleted.rawValue,
            isSelected: selectedFilter == Filter.Incompleted.rawValue ? true : false,
            callback: radioGroupCallBackFilter)
    }
    //RadioTasks for each Sort button that will return its data and set the others as false
    var radioNameTask: some View {
        RadioButton(
            id: Sort.Name.rawValue,
            label: Sort.Name.rawValue,
            isSelected: selectedSort == Sort.Name.rawValue ? true : false,
            callback: radioGroupCallBackSort)
    }
    var radioDueDatedTask: some View {
        RadioButton(
            id: Sort.DueDate.rawValue,
            label: Sort.DueDate.rawValue,
            isSelected: selectedSort == Sort.DueDate.rawValue ? true : false,
            callback: radioGroupCallBackSort)
    }
    var radioCreatedAtTask: some View {
        RadioButton(
            id: Sort.CreatedAt.rawValue,
            label: Sort.CreatedAt.rawValue,
            isSelected: selectedSort == Sort.CreatedAt.rawValue ? true : false,
            callback: radioGroupCallBackSort)
    }
    //RadioTasks for the Order buttons that will return its data and set the others as false
    var radioAscendingTask: some View {
        RadioButton(
            id: Order.Ascending.rawValue,
            label: Order.Ascending.rawValue,
            isSelected: selectedOrder == Order.Ascending.rawValue ? true : false,
            callback: radioGroupCallBackOrder)
    }
    var radioDescendingTask: some View {
        RadioButton(
            id: Order.Descending.rawValue,
            label: Order.Descending.rawValue,
            isSelected: selectedOrder == Order.Descending.rawValue ? true : false,
            callback: radioGroupCallBackOrder)
    }
    
    //Returns the three separate ids that will be sent back to content view for todoManager to use in an Api call for filtered tasks
    func radioGroupCallBackFilter(id: String) {
        selectedFilter = id
    }
    func radioGroupCallBackSort(id: String) {
        selectedSort = id
    }
    func radioGroupCallBackOrder(id: String) {
        selectedOrder = id
    }
}

