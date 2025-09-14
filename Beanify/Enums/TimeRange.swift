//
//  TimeLength.swift
//  Beanify
//
//  Created by Mohamed Feituri on 9/13/25.
//
// enum for the timeranges needed to get the data from api


enum TimeRange: String, CaseIterable, Identifiable {
    case mediumTerm = "medium_term",
         shortTerm = "short_term",
         longTerm = "long_term"
    
    var id: Self {self}
}


