//
//  ListTitle.swift
//  ProjectManager
//
//  Created by Dasoll Park on 2021/10/29.
//

import SwiftUI

struct ListTitle: View {
    
    var title: String
    var countOfTask: String
    
    var body: some View {
        ZStack {
            Color(red: 242 / 255, green: 242 / 255, blue: 247 / 255)
            HStack(alignment: .center, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/) {
                Text(title)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                ZStack {
                    Capsule()
                        .frame(width: 28, height: 28, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Text(countOfTask)
                        .foregroundColor(Color.white)
                }
                Spacer()
            }
            .padding()
        }
    }
}

struct ListTitle_Previews: PreviewProvider {
    static var previews: some View {
        ListTitle(title: String(describing: TaskState.todo), countOfTask: "1")
            .previewLayout(.fixed(width: 400, height: 40))
    }
}
