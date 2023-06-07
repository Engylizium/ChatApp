//
//  ContentView.swift
//  chatOnline
//
//  Created by Соболев Пересвет on 6/6/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var messages: [(message: String, isUserMessage: Bool)] = []
    @State private var newMessage: String = ""
    @State private var senderName: String = "ChatBot"
    
    private let backgroundColor = Color.blue
       private let senderNameColor = Color.white
       private let userMessageBackgroundColor = Color.blue
       private let testMessageBackgroundColor = Color.gray
    
    var body: some View {
        VStack {
            
            HStack {
                Text("\(senderName)")
                    .font(.title3)
                    .padding(.top)
                    .foregroundColor(senderNameColor)
                
                Spacer()
            }
            
            List(messages, id: \.message) { message in
                MessageBubble(
                    message: message.message,
                    isUserMessage: message.isUserMessage,
                    backgroundColor: message.isUserMessage ? userMessageBackgroundColor : testMessageBackgroundColor,
                    foregroundColor: message.isUserMessage ? .white : .black
                )
            }
            .listStyle(.plain)
            .cornerRadius(16)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            
            HStack {
                            TextField("Type a message", text: $newMessage)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()

                            Button(action: sendMessage) {
                                Text("Send")
                                    .padding()
                                    .background(userMessageBackgroundColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                        }
        }
        .padding()
                .background(backgroundColor)
                .edgesIgnoringSafeArea(.all)
    }
    
    func sendMessage() {
        guard !newMessage.isEmpty else {
            return
        }
        
        messages.append((message: newMessage, isUserMessage: true))
        
        if newMessage == "Test" {
            sendTestResponse()
        }
        
        newMessage = ""
    }
    
    func sendTestResponse() {
        let response = "This is a test response."
        messages.append((message: response, isUserMessage: false))
    }
    
}

struct MessageBubble: View {
    let message: String
    let isUserMessage: Bool
    let backgroundColor: Color
    let foregroundColor: Color

    var body: some View {
        HStack {
            if isUserMessage {
                Spacer()
                Text(message)
                    .padding()
                    .background(backgroundColor)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            } else {
                Text(message)
                    .padding()
                    .background(backgroundColor)
                    .foregroundColor(foregroundColor)
                    .cornerRadius(8)
                Spacer()
            }
        }
        .padding(.horizontal, 8)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
