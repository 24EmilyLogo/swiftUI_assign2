//
//  ContentView.swift
//  swiftUI_assign2
//
//  Created by StudentAM on 2/27/24.
//

import SwiftUI

struct ContentView: View {
    //variables
    @State private var taskName: String = ""
    @State private var taskCount: Int = 0
    @State private var taskList: [String] = []
    @State private var showAlert = false
    var body: some View {
        //stacks it vertically
        VStack {
            
            //stacks it horizontally
            HStack{
                //text for to do list
                Text("To-Do List")
                //stylization for to do list
                    .font(.system(size:35, weight: .bold))
                //moves "to-do list" to the left
                Spacer()
            }
            
            //stacks it horizontally
            HStack{
                //text for num of tasks
            Text("Number of tasks: \(taskCount)")
                //pushes it to the left
                Spacer()
            }
            //user input textbox
            TextField("Enter a new task", text:$taskName)
            //stylization for text field
                .textFieldStyle(RoundedBorderTextFieldStyle())
                //padding
                .padding()
            
            //Horizontally stacks
            HStack{
                //button that adds the tasks
                Button("Add Task", action:{addTask()})
                //stylization for add task button
                    //padding on inside of button
                    .padding()
                    //Text color to white
                    .foregroundColor(.white)
                //change button color based on if text field is empty or not
                    .background(
                        //makes button blue or gray depending on enabled
                        taskName == "" ? Color.gray : Color.blue
                    )
                    //Corner radius
                    .cornerRadius(5)
                //makes an alert pop up if text is empty
                    .alert("You can't add a task if there's nothing to add!", isPresented: $showAlert){
                        //button to make the pop up go away
                        Button("OK", role: .cancel){}
                    }
                
                //button to remove all tasks
                Button("Remove All Tasks", action:{removeTasks()})
                //button stylization
                    //padding on inside of the button
                    .padding()
                    //text color to white
                    .foregroundColor(.white)
                //changes to blue or gray if tasks in task area
                    .background(
                        //changes the color to either gray or blue
                        taskList == [] ? Color.gray : Color.blue
                    )
                    //changes corner radius
                    .cornerRadius(5)
                //if nothing is in task area disable button
                    .disabled(taskList == [])
            }
        }
        //padding :D
        .padding()
        
        //Vetical stack
        VStack{
            //list to hold tasks
            List{
                //had to be formatted like this to make the counter agree when deleting singletons; ForEach loop to look over the list and add if called to add
                ForEach($taskList, id:\.self) { $task in
                    Text(task)
                }
                    //when a singleton is deleted it runs the removeTask function
                    .onDelete(perform: removeTask)
            }
            //Navigation title for the list
            .navigationTitle("Task List")
            
            //moves the tasks to the top
            Spacer()
        }
    }
    //function to add task
    func addTask(){
        //if statement to show alert if the textbox to add new task is empty
        if taskName.isEmpty{
            //sets showAlert to true
            showAlert = true
            //else statement to add task to list
        }else{
            //appends to the task list
            taskList.append(taskName)
            //sets textbox back to empty
            taskName = ""
            //increases num of tasks
            taskTicker()
        }
    }
    //func to remove single task
    func removeTask(at offsets: IndexSet){
        //remoces single task
        taskList.remove(atOffsets: offsets)
        //updates ticker
        taskTicker()
    }
    //func to remove all tasks
    func removeTasks(){
        //removes all tasks
        taskList = []
        //updates ticker
        taskTicker()
    }
    //func for ticker
    func taskTicker(){
        //updates count
        taskCount = taskList.count
    }
}

#Preview {
    ContentView()
}
