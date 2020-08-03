//
//  Analysis-Heart.swift
//  Health Analysis
//
//  Created by Yogesh Sehgal on 03/08/20.
//  Copyright © 2020 Yogesh Sehgal. All rights reserved.
//

import Foundation
import CoreML


func predict(age: Double, gender: Double, chestpain: Double, bloodpressure: Double, cholestrol: Double, sugar: Bool, maximumheartrate: Double, agina: Bool, oldpeak: Double, slope: Double, ca: Double, electrocardiographic: Double)
{
    let model = Heart()
    
    var sugar_conv = 0.0
    if sugar == true{
        sugar_conv = 1.0
    }
    
    var agina_conv = 0.0
    if agina == true{
        agina_conv = 1.0
    }
    
    
do {
    let prediction = try model.prediction(age: age, sex: gender, cp: chestpain, trestbps: bloodpressure, chol: cholestrol, fbs: sugar_conv, restecg: electrocardiographic, thalach: maximumheartrate, exang: agina_conv, oldpeak: oldpeak, slope: slope, ca: ca)
    print(prediction)
} catch {
    print("Error")
    }
}
//predict(age: self.age, gender: self.gender, chestpain: self.chestpain, bloodpressure: self.bloodpressure, cholestrol: self.cholestrol, sugar: self.sugar, maximumheartrate: self.maximumheartrate, agina: self.agina, oldpeak: Double(self.oldpeak), slope: Double(self.slope), ca: Double(self.ca), electrocardiographic: Double(self.electrocardiographic))

