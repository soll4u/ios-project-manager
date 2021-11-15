//
//  ModalView.swift
//  ProjectManager
//
//  Created by Dasoll Park on 2021/11/02.
//

import SwiftUI

enum ModalState {
    case add
    case edit
    case inquire
}

struct ModalView: View {

    @EnvironmentObject var taskViewModel: TaskViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State var modalState: ModalState
    
    @State private var title: String
    @State private var date: Date
    @State private var description: String
    @State private var state: TaskState
    
    var task: Task
    var taskIndex: Int {
        taskViewModel.tasks.firstIndex(where: { $0.id == task.id }) ?? 0
    }
    
    init(modalState: ModalState, task: Task) {
        _modalState = State(initialValue: modalState)
        self.task = task
        
        _title = State(initialValue: task.title)
        _date = State(initialValue: task.date)
        _description = State(initialValue: task.description)
        _state = State(initialValue: task.state)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField(
                    "Title",
                    text: $title
                )
                .disabled(modalState == .inquire)
                .frame(height: 44)
                .background(Color.white)
                .shadow(color: .gray, radius: 3, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 2.0)
                .padding(.horizontal)
                
                DatePicker(
                    "",
                    selection: $date,
                    displayedComponents: [.date]
                )
                .disabled(modalState == .inquire)
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
                
                TextField(
                    "Description",
                    text: $description
                )
                .disabled(modalState == .inquire)
                .frame(height: 300, alignment: .top)
                .background(Color.white)
                .shadow(color: .gray, radius: 3, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 2.0)
                .padding(.horizontal)
            }
            .navigationTitle("TODO")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: customLeadingButton,
                                trailing: customTrailingButton)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

extension ModalView {
    
    private func saveNewTask() {
        let newTask = Task(title: title,
                           description: description,
                           date: date,
                           state: .todo)
        taskViewModel.add(task: newTask)
    }
    
    private func updateTask() {
        taskViewModel.updateTask(id: task.id,
                                 title: title,
                                 description: description,
                                 date: date,
                                 state: state)
    }
    
    private var customLeadingButton: some View {
        switch modalState {
        case .add, .edit:
            return Button("Cancel") {
                self.presentationMode.wrappedValue.dismiss()
            }
        case .inquire:
            return Button("Edit") {
                modalState = .edit
            }
        }
    }
    
    private var customTrailingButton: some View {
        switch modalState {
        case .add:
            return Button("Done"){
                saveNewTask()
                self.presentationMode.wrappedValue.dismiss()
            }
        case .edit, .inquire:
            return Button("Done"){
                self.updateTask()
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct ModalView_Previews: PreviewProvider {
    static let viewModel = TaskViewModel()
    static var previews: some View {
        ModalView(modalState: .inquire, task: viewModel.tasks[0])
            .environmentObject(viewModel)
    }
}
