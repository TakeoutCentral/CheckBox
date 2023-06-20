//
//  CheckBoxGroup.swift
//  CheckBox
//
//  Created by Bobo on 9/19/15.
//  Copyright (c) 2015 Boris Emorine. All rights reserved.
//

import UIKit

@objc
public class CheckBoxGroup: NSObject {
    /** An array of check boxes in this group.
     */
    @objc public private(set) var checkBoxes = NSHashTable<CheckBox>(options: .weakMemory)
    
    /** The currently selected check box. Only can be nil if mustHaveSelection is NO. Setting this value will cause the other check boxes to deselect automatically.
     */
    @objc public var selectedCheckBox: CheckBox? {
        get {
            var selected: CheckBox? = nil
            
            for checkBox in checkBoxes.allObjects {
                if checkBox.on {
                    selected = checkBox
                    break
                }
            }
            
            return selected
        }
        set {
            if newValue != nil {
                for checkBox in checkBoxes.allObjects {
                    let shouldBeOn = checkBox == newValue
                    if checkBox.on != shouldBeOn {
                        checkBox.setOn(shouldBeOn, animated: true, notifyGroup: false)
                    }
                }
            } else {
                // Selection is nil
                if mustHaveSelection && checkBoxes.count > 0 {
                    // We must have a selected checkbox, so re-call this method with the first checkbox
                    self.selectedCheckBox = checkBoxes.allObjects.first
                } else {
                    for checkBox in checkBoxes.allObjects {
                        let shouldBeOn = false
                        if checkBox.on != shouldBeOn {
                            checkBox.setOn(shouldBeOn, animated: true, notifyGroup: false)
                        }
                    }
                }
            }
        }
    }
    
    /** If YES, don't allow the user to unselect all options, must have single selection at all times. Default to NO.
     */
    @objc public var mustHaveSelection = false {
        didSet {
            // If it must have a selection and we currently don't, select the first box
            if mustHaveSelection && selectedCheckBox == nil {
                selectedCheckBox = checkBoxes.allObjects.first
            }
        }
    }
    
    @objc override public init() {
        super.init()
    }
    
    /** Creates a new group with the list of check boxes.
     */
    @objc convenience public init(checkBoxes: [CheckBox]) {
        self.init()
        
        for checkbox in checkBoxes {
            addCheckBoxToGroup(checkbox)
        }
    }
    
    /** Tests whether the checkbox is in this group */
    @objc public func contains(_ checkBox: CheckBox) -> Bool {
        return checkBoxes.contains(checkBox)
    }
    
    /** Adds a check box to this group. Check boxes can only belong to a single group, adding to a group removes it from its current group.
     */
    @objc public func addCheckBoxToGroup(_ checkBox: CheckBox) {
        if checkBoxes.contains(checkBox) { return }
        
        if checkBox.group != nil {
            checkBox.group?.removeCheckBoxFromGroup(checkBox)
        }
        
        checkBoxes.add(checkBox)
        
        checkBox.setOn(false, animated: false, notifyGroup: false)
        checkBox.group = self
    }
    
    /** Removes a check box from this group. */
    @objc public func removeCheckBoxFromGroup(_ checkBox: CheckBox) {
        if !checkBoxes.contains(checkBox) {
            // Not in this group
            return
        }
        
        checkBoxes.remove(checkBox)
        checkBox.group = nil
    }
    
    // MARK: Private methods called by CheckBox
    
    internal func notifyCheckBoxSelectionChanged(_ checkBox: CheckBox) {
        if checkBox.on {
            // Change selected checkbox to this one
            selectedCheckBox = checkBox
        } else if checkBox == selectedCheckBox {
            // Selected checkbox was this one, clear it
            selectedCheckBox = nil
        }
    }
}
