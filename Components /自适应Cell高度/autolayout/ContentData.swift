//
//  ContentData.swift
//  autolayout
//
//  Created by FanYu on 23/12/2015.
//  Copyright © 2015 FanYu. All rights reserved.
//

import UIKit

struct ContentData {
    static let titles = ["AAAAAAA", "BBBBB", "CCCCC", "DDDDD", "FFFFF", "GGGGGG", "HHHHHH"]
    static let texts = ["What", "The", "Hell HHHHHHHHHHHHHHHHHHH我我我我我哦我我我我我", "Hello World", "为了在“- (CGFloat)tableView:(UITableView )tableView heightForRowAtIndexPath:(NSIndexPath )indexPath ”方法中计算Cell的高度，我们需要一个专门用于计算高度的Cell实例，可以说算是Cell的“模板”。一般来说，这个实例可以设置成函数的static变量，并只在第一次使用时初始化一", "What  ", "What What What What What What What What What What What What"]
}


class RandomData {
    
    var dataArray: [(title: String, body: String)] = []
    
    func addSingleItem()
    {
        let fontFamilies = UIFont.familyNames()
        
        let r = random() % fontFamilies.count
        let familyName: AnyObject = fontFamilies[r]
        
        if let familyNameString = familyName as? String {
            dataArray.append((title: familyNameString, body: randomLengthContent()))
        }
    }
    
    func randomLengthContent() ->String {
        let str = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent non quam ac massa viverra semper. Maecenas mattis justo ac augue volutpat congue. Maecenas laoreet, nulla eu faucibus gravida, felis orci dictum risus, sed sodales sem eros eget risus. Morbi imperdiet sed diam et sodales. Vestibulum ut est id mauris ultrices gravida. Nulla malesuada metus ut erat malesuada, vitae ornare neque semper. Aenean a commodo justo, vel placerat odio. Curabitur vitae consequat tortor. Aenean eu magna ante. Integer tristique elit ac augue laoreet, eget pulvinar lacus dictum. Cras eleifend lacus eget pharetra elementum. Etiam fermentum eu felis eu tristique. Integer eu purus vitae turpis blandit consectetur. Nulla facilisi. Praesent bibendum massa eu metus pulvinar, quis tristique nunc commodo. Ut varius aliquam elit, a tincidunt elit aliquam non. Nunc ac leo purus. Proin condimentum placerat ligula, at tristique neque scelerisque ut. Suspendisse ut congue enim. Integer id sem nisl. Nam dignissim, lectus et dictum sollicitudin, libero augue ullamcorper justo, nec consectetur dolor arcu sed justo. Proin rutrum pharetra lectus, vel gravida ante venenatis sed. Mauris lacinia urna vehicula felis aliquet venenatis. Suspendisse non pretium sapien. Proin id dolor ultricies, dictum augue non, euismod ante. Vivamus et luctus augue, a luctus mi. Maecenas sit amet felis in magna vestibulum viverra vel ut est. Suspendisse potenti. Morbi nec odio pretium lacus laoreet volutpat sit amet at ipsum. Etiam pretium purus vitae tortor auctor, quis cursus metus vehicula. Integer ultricies facilisis arcu, non congue orci pharetra quis. Vivamus pulvinar ligula neque, et vehicula ipsum euismod quis."
        
        // conver to array of words
        let strArray = str.componentsSeparatedByString(" ")
        
        // number of words
        let minNumberOfWords = 3
        let randomNum = max(minNumberOfWords, random() % strArray.count)
        let randomArray = strArray[0 ..< randomNum]
        
        // join the array of words to make a string
        let randomText = randomArray.reduce("") { "\($0) \($1)" }
        
        return "\(randomText)!!!"
    }
}

