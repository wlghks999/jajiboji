//
//  extensions.swift
//  Honnmin
//
//  Created by 오현우 on 2022/11/09.
//

import SwiftUI

extension View{
    func endTextEditing(){
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to :  nil, from : nil, for : nil
        )
    }
}
