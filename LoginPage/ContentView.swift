//
//  ContentView.swift
//  LoginPage
//
//  Created by Richa Mangukiya on 17/11/21.
//

import SwiftUI

struct ContentView: View {
    @State private var text: String = ""
    @State private var emailtext: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            Image("edvora")
            Spacer()
            VStack (spacing: 15) {
                AnimatedTextField(placeholder: "Username", text: self.$text, firstImage: "account", secondImage: "")
                AnimatedTextField(placeholder: "Email", text: self.$emailtext, firstImage: "account", secondImage: "")
                AnimatedTextField(placeholder: "Password", text: self.$password, firstImage: "key", secondImage: "eye")
            }
            .padding()
            HStack {
                Spacer()
                Button("Forgotten Password?") {
                    
                }
                .foregroundColor(Color(red: 115/255, green: 61/255, blue: 71/255, opacity: 0.7))
                .padding()
            }
            
            Spacer()
            Button(action: {
                if text == "" {
                    self.showAlert(message: "Name should not be empty.")
                } else if !isValidName(text) {
                    self.showAlert(message: "Name should be valid.")
                } else if emailtext == "" {
                    self.showAlert(message: "Email should not be empty.")
                } else if !isValidEmail(emailtext) {
                    self.showAlert(message: "Email should be valid.")
                } else if password == "" {
                    self.showAlert(message: "Password should not be empty.")
                } else if !isValidPassword(password) {
                    self.showAlert(message: "Password should be valid with 8 characters, 1 number, 1 upper case alphabet, 1 lower case alphabet.")
                } else {
                    self.showAlert(message: "Login Successfully")
                }
            }) {
              Text("LOGIN")
                .font(.title3)
                .foregroundColor(.white)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color(red: 115/255, green: 61/255, blue: 71/255, opacity: 1))
                .cornerRadius(11.0)
            }
            Spacer()
            HStack {
                Text("Don't have an account?")
                    .foregroundColor(.secondary)
                Button("SignUp") {
                    
                }
                .foregroundColor(Color(red: 115/255, green: 61/255, blue: 71/255, opacity: 0.7))
            }
        }
    }
    
    //MARK: - Method for validation for name
    func isValidName(_ name: String) -> Bool {
        let usernamePattern = #"^[a-zA-Z-]+$"#
        let namePred = NSPredicate(format:"SELF MATCHES %@", usernamePattern)
        return namePred.evaluate(with: name)
    }
    
    //MARK: - Method for validation for password
    func isValidPassword(_ password: String) -> Bool {
        let passwordPattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$"
        let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordPattern)
        return passwordPred.evaluate(with: password)
    }
    
    //MARK: - Method for validation for email
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    //MARK: - Method for showing alert
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Message", message: message, preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "OK", style: .cancel, handler: { alert -> Void in
        })
        
        alertController.addAction(saveAction)
        
        UIApplication.shared.windows.first?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//MARK: - TextField View
struct AnimatedTextField: View {
    let placeholder: String
    @Binding var text: String
    let firstImage: String
    let secondImage: String
    
    var body: some View {
        HStack {
            Image(firstImage)
            ZStack (alignment: .leading) {
                Text(placeholder)
                    .foregroundColor(Color.gray.opacity(1))
                    .padding(.horizontal, 10)
                    .background(Color.white)
                    .offset(y: -28)
                    .scaleEffect(0.9, anchor: .leading)
                    .font(.system(.subheadline, design: .rounded))
                TextField("", text: self.$text)
                    .font(.system(.title3, design: .rounded))
                    .foregroundColor(.black)
                    .padding(.horizontal, self.text.isEmpty ? 0 : 10)
                }
            Image(secondImage)
        }
        .padding(.horizontal)
        .animation(.easeOut)
        .padding(.vertical, 10)
        .frame(height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(text.isEmpty ? Color(red: 240/255, green: 240/255, blue: 240/255, opacity: 1) : Color(red: 115/255, green: 61/255, blue: 71/255, opacity: 1), lineWidth: 0.5)
                .background(Color(red: 250/255, green: 250/255, blue: 250/255, opacity: 1))
        )
    }
}
