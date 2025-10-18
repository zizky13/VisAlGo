//
//  File.swift
//  VisualGo
//
//  Created by Zikar Nurizky on 01/08/25.
//
import Foundation

// -- SIMPLE STRUCT FOR APP ALERT --
struct AppAlert: Identifiable {
    let id = UUID()
    let title: String
    let message: String
}
