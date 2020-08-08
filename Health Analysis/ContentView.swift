//
//  ContentView.swift
//  Health Analysis
//
//  Created by Yogesh Sehgal on 03/08/20.
//  Copyright © 2020 Yogesh Sehgal. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            HeartForm().tabItem {
                Image(systemName: "heart.fill").padding()
                Text("Heart").padding()
            }
            DiabetesForm().tabItem {
                Image(systemName: "largecircle.fill.circle").padding()
                Text("Diabetes").padding()
            }
        }.accentColor(.red)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct HeartForm: View {
    @State private var age = 35.0
    @State private var gender = 0
    let sex = ["Female", "Male"]
    @State private var chestpain = 0
    @State private var bloodpressure = 150.0
    @State private var cholestrol = 230.0
    @State private var sugar = false
    @State private var maximumheartrate = 155.0
    @State private var agina = false
    @State private var oldpeak = "0.0"
    @State private var slope = "0.0"
    @State private var ca = "0.0"
    @State private var electrocardiographic = "0.0"
    @State private var alertShown = false
    @State var result = ""
    var body: some View {
        NavigationView {
            Form{
                Section(header: Text("Age: \(Int(age))")){
                    Slider(value: $age, in: 1...100)
                        .accentColor(.red)
                }
                Section() {
                    Picker("Gender", selection: $gender) {
                        ForEach(0 ..< sex.count) {
                            Text("\(self.sex[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Chest Pain: 0 for Min, 3 for Max")) {
                    Stepper(value: $chestpain) {
                        Text("\(chestpain)")
                    }
                }
                Section(header: Text("Blood Pressure: \(Int(bloodpressure))")){
                    Slider(value: $bloodpressure, in: 90...210)
                        .accentColor(.red)
                }
                Section(header: Text("Cholestrol: \(Int(cholestrol))")){
                    Slider(value: $cholestrol, in: 110...570)
                        .accentColor(.red)
                }
                Section(header: Text("Sugar: \(String(sugar).capitalized)")){
                    Toggle("Fasting blood sugar 120 mg/dl?", isOn: $sugar)
                }
                Section(header: Text("Maximum Heart Rate: \(Int(maximumheartrate))")){
                    Slider(value: $maximumheartrate, in: 70...210)
                        .accentColor(.red)
                }
                Section(header: Text("Exercise induced Agina: \(String(agina).capitalized)")){
                    Toggle("Do you have Exercise Induced Agina?", isOn: $agina)
                }
                Group{
                    Section(header: Text("ST Depression induced by exercise relative to rest")){
                        TextField("Enter Your Result", text: $oldpeak).keyboardType(.decimalPad)
                    }
                    Section(header: Text("The slope of the peak exercise ST segment")){
                        TextField("Enter Your Result", text: $slope).keyboardType(.decimalPad)
                    }
                    Section(header: Text("Number of major vessels (0-3) colored by flourosopy")){
                        TextField("Enter Your Result", text: $ca).keyboardType(.decimalPad)
                    }
                    Section(header: Text("Resting Electrocardiographic results")){
                        TextField("Enter Your Result", text: $electrocardiographic).keyboardType(.decimalPad)
                    }
                }
                HStack{
                    Spacer()
                    Button(action: {}, label: {
                        Text("Result")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.red)
                            .cornerRadius(8)
                    }).onTapGesture {
                        let model = Heart()
                        
                        var sugar_conv = 0.0
                        if self.sugar == true{
                            sugar_conv = 1.0
                        }
                        
                        var agina_conv = 0.0
                        if self.agina == true{
                            agina_conv = 1.0
                        }
                        
                        do {
                            let prediction = try model.prediction(age: self.age, sex: Double(self.gender), cp: self.cholestrol, trestbps: self.bloodpressure, chol: self.cholestrol, fbs: sugar_conv, restecg: Double(self.electrocardiographic) ?? 0.0, thalach: self.maximumheartrate, exang: agina_conv, oldpeak: Double(self.oldpeak) ?? 0.0, slope: Double(self.slope) ?? 0.0, ca: Double(self.ca) ?? 0.0)
                            print(prediction.target)
                            if prediction.target == 1{
                                self.result = "You are susceptible to heart disease"
                            }else{
                                self.result = "You are fine"
                            }
                            self.alertShown = true
                        } catch {
                            print("Error")
                        }
                    }.alert(isPresented: $alertShown) { () -> Alert in
                        Alert(title: Text("Your Result"), message: Text("\(self.result)"), dismissButton: .default(Text("OK")))
                    }
                    Spacer()
                }
            }.navigationBarTitle("Heart")
        }
    }
}

struct DiabetesForm: View {
    @State private var age = 35.0
    @State private var bloodpressure = 65.0
    @State private var pregnancies = 0.0
    @State private var glucose = 100.0
    @State private var skin = 5.0
    @State private var insulin = 42.0
    @State private var bmi = "0.0"
    @State private var diabetespedigree = "0.0"
    @State private var alertShown = false
    @State private var result = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Form{
                    Section(header: Text("Age: \(Int(age))")){
                        Slider(value: $age, in: 1...100)
                            .accentColor(.red)
                    }
                    Section(header: Text("Blood Pressure: \(Int(bloodpressure))")){
                        Slider(value: $bloodpressure, in: 0...130)
                            .accentColor(.red)
                    }
                    Section(header: Text("Pregnancies: \(Int(pregnancies))")){
                        Slider(value: $pregnancies, in: 0...20)
                            .accentColor(.red)
                    }
                    Section(header: Text("Glucose: \(Int(glucose))")){
                        Slider(value: $glucose, in: 0...200)
                            .accentColor(.red)
                    }
                    Section(header: Text("Skin Thickness: \(Int(skin))")){
                        Slider(value: $skin, in: 0...100)
                            .accentColor(.red)
                    }
                    Section(header: Text("Insulin: \(Int(insulin))")){
                        Slider(value: $insulin, in: 0...850)
                            .accentColor(.red)
                    }
                    Section(header: Text("Your Body Mass Index:")){
                        TextField("Enter Your Result", text: $bmi).keyboardType(.decimalPad)
                    }
                    Section(header: Text("Diabetes Pedigree Function:")){
                        TextField("Enter Your Result", text: $diabetespedigree).keyboardType(.decimalPad)
                    }
                    HStack {
                        Spacer()
                        Button(action: {
                            let model = Diabetes()
                            
                            do{
                                let prediction = try model.prediction(Pregnancies: self.pregnancies, Glucose: self.glucose, BloodPressure: self.bloodpressure, SkinThickness: self.skin, Insulin: self.insulin, BMI: Double(self.bmi) ?? 0.0, DiabetesPedigreeFunction: Double(self.diabetespedigree) ?? 0.0, Age: self.age)
                                print(prediction.Outcome)
                                if prediction.Outcome == 1{
                                    self.result = "You are susceptible to heart disease"
                                }else{
                                    self.result = "You are fine"
                                }
                                self.alertShown = true
                            }
                            catch{
                                let result = "Error"
                                print(result)
                            }
                            
                        }, label: {
                            Text("Result")
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.red)
                                .cornerRadius(8)
                        }).alert(isPresented: $alertShown) { () -> Alert in
                            Alert(title: Text("Your Result"), message: Text("\(self.result)"), dismissButton: .default(Text("OK")))
                        }
                        Spacer()
                    }
                }.navigationBarTitle("Diabetes")
            }
        }
    }
}
