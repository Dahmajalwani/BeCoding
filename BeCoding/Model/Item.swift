//
//  Item.swift
//  BeCoding
//
//  Created by dahma alwani on 08/06/1443 AH.


import Foundation
struct Item {
    var theName:String
    var theDetails:String
    var theImage:String

    static var all = [

        [Item(theName: "What's the difference between using let & var?", theDetails: "The main difference between let and var is that scope of a variable defined with let is limited to the block in which it is declared while variable declared with var has the global scope. So we can say that var is rather a keyword which defines a variable globally regardless of block scope.The scope of let not only limited to the block in which it is defined but variable with let also do not get added with global window object even if it get declared outside of any block. But we can access variable with var from window object if it is defined globally.Due to limited scope let variables are usually used when there is limited use of those variables such as in for loops, while loops or inside the scope of if conditions etc while var variable is used when value of variable need to be less change and used to accessed globally.Also, one difference between var and let is variable with var can be redeclared to some other value while variable could not be redeclared if it is defined with let.", theImage: "varLet"),
        Item(theName: "what are the Data Types?", theDetails: "Swift includes many predefined types you can use to more easily write clean code. Whether your program needs to include numbers, strings, or Boolean (true or false) values, you can use types to represent a specific kind of information.", theImage: "dataType")],
        [Item(theName: "what are the collection types?", theDetails: "group multiple values into a single constant or variable. One collection type is named an Array, which stores an ordered list of values. Another collection type is named a Dictionary, which has keys that help you look up specific values. You’ll learn more about collections in a future lesson.The type of a Swift set is written as Set<Element>, where Element is the type that the set is allowed to store. Unlike arrays, sets don’t have an equivalent shorthand form.", theImage: "CollectionTypes")],
        [Item(theName: "what are the Logical and Comparison Operators?", theDetails: "Each if statement uses a logical or comparison operator to decide if something is true or false. The result determines whether to run the block of code or to skip it", theImage: "equal")]
    ]
}
