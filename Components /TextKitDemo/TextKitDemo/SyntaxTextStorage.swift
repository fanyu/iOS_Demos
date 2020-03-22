//
//  SyntaxTextStorage.swift
//  TextKitDemo
//
//  Created by FanYu on 6/21/16.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit


// 重写NSTextStorage类的子类必须重载以下四个方法

class SyntaxTextStorage: NSTextStorage {
    
    let backingStore = NSMutableAttributedString()
    var replacements: [String : [NSObject : AnyObject]]!

    
    override init() {
        super.init()
        createHighlightPatterns()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // 返回保存的文字
    override var string: String {
        return backingStore.string
    }
    
    // 获取指定范围内的文字属性
    override func attributesAtIndex(index: Int, effectiveRange range: NSRangePointer) -> [String : AnyObject] {
        return backingStore.attributesAtIndex(index, effectiveRange: range)
    }
    
    // 修改指定范围内的文字
    override func replaceCharactersInRange(range: NSRange, withString str: String) {
        print("replaceCharactersInRange:\(range) withString:\(str)")

        beginEditing()
        backingStore.replaceCharactersInRange(range, withString:str)
        edited([.EditedCharacters, .EditedAttributes], range: range, changeInLength: (str as NSString).length - range.length)
        endEditing()
    }
    
    // 设置指定范围内的文字属性
    override func setAttributes(attrs: [String : AnyObject]!, range: NSRange) {
        print("setAttributes:\(attrs) range:\(range)")

        beginEditing()
        backingStore.setAttributes(attrs, range: range)
        edited(.EditedAttributes, range: range, changeInLength: 0)
        endEditing()
    }
    
    // NSTextStorge收到endEditing的通知，则调用processEditing方法进行处理
    override func processEditing() {
        performReplacementsForRange(self.editedRange)
        super.processEditing()
    }
}


// MARK: -
extension SyntaxTextStorage {
    
    // 代替
    func performReplacementsForRange(changedRange: NSRange) {
        var extendedRange = NSUnionRange(changedRange, NSString(string: backingStore.string).lineRangeForRange(NSMakeRange(changedRange.location, 0)))
        extendedRange = NSUnionRange(changedRange, NSString(string: backingStore.string).lineRangeForRange(NSMakeRange(NSMaxRange(changedRange), 0)))
        applyStylesToRange(extendedRange)
    }

    // 根据文字进行匹配 然后做替换
    func applyStylesToRange(searchRange: NSRange) {
        
        // 获取用户偏好字体 Dynamic Type 设置
        let normalAttrs = [NSFontAttributeName : UIFont.preferredFontForTextStyle(UIFontTextStyleBody)]

        // iterate over each replacement
        for (pattern, attributesDict) in replacements {
            
            guard let attributes = attributesDict as? [String : AnyObject] else { return }
            
            let regex = try! NSRegularExpression(pattern: pattern, options: [])
            
            regex.enumerateMatchesInString(backingStore.string, options: [], range: searchRange) {
                match, flags, stop in
                // apply the style
                let matchRange = match!.rangeAtIndex(1)
                self.addAttributes(attributes, range: matchRange)
                
                // reset the style to the original
                let maxRange = matchRange.location + matchRange.length
                if maxRange + 1 < self.length {
                    self.addAttributes(normalAttrs, range: NSMakeRange(maxRange, 1))
                }
            }
        }
    
    }
    
    // 根据字体格式创建特性字体 如 粗体 斜体
    func createAttributesForFontStyle(style: String, withTrait trait: UIFontDescriptorSymbolicTraits) -> [NSObject : AnyObject] {
        let fontDescriptor = UIFontDescriptor.preferredFontDescriptorWithTextStyle(UIFontTextStyleBody)
        let descriptorWithTrait = fontDescriptor.fontDescriptorWithSymbolicTraits(trait)
        let font = UIFont(descriptor: descriptorWithTrait, size: 0)
        return [NSFontAttributeName : font]
    }
    
    // 创建字体格式根据正则表达式来对应
    func createHighlightPatterns() {
        let scriptFontDescriptor = UIFontDescriptor(fontAttributes: [UIFontDescriptorFamilyAttribute : "Zapfino"])
        
        // 1. base our script font on the preferred body font size
        let bodyFontDescriptor = UIFontDescriptor.preferredFontDescriptorWithTextStyle(UIFontTextStyleBody)
        let bodyFontSize       = bodyFontDescriptor.fontAttributes()[UIFontDescriptorSizeAttribute] as! NSNumber
        let scriptFont         = UIFont(descriptor: scriptFontDescriptor, size: CGFloat(bodyFontSize.floatValue))
        
        // 2. create the attributes
        let boldAttributes          = createAttributesForFontStyle(UIFontTextStyleBody, withTrait:.TraitBold)
        let italicAttributes        = createAttributesForFontStyle(UIFontTextStyleBody, withTrait:.TraitItalic)
        let strikeThroughAttributes = [NSStrikethroughStyleAttributeName : 1]
        let scriptAttributes        = [NSFontAttributeName : scriptFont]
        let redTextAttributes       = [NSForegroundColorAttributeName : UIColor.redColor()]
        
        // construct a dictionary of replacements based on regexes
        replacements = [
            "(\\*\\w+(\\s\\w+)*\\*)"    : boldAttributes,               // 粗体
            "(_\\w+(\\s\\w+)*_)"        : italicAttributes,             // 斜体
            "([0-9]+\\.)\\s"            : boldAttributes,               // 数字粗体
            "(-\\w+(\\s\\w+)*-)"        : strikeThroughAttributes,      // 中间横线
            "(~\\w+(\\s\\w+)*~)"        : scriptAttributes,             // 手写体
            "\\s([A-Z]{2,})\\s"         : redTextAttributes             // 红色
        ]
        
    }
    
    func update() {
        // update the highlight patterns
        createHighlightPatterns()
        
        // change the 'global' font
        let bodyFont = [NSFontAttributeName : UIFont.preferredFontForTextStyle(UIFontTextStyleBody)]
        addAttributes(bodyFont, range: NSMakeRange(0, length))
        
        // re-apply the regex matches
        applyStylesToRange(NSMakeRange(0, length))
    }

}
