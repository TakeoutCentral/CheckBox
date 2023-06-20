//
//  GroupTests.m
//  CheckBox
//
//  Created by Bobo on 10/18/16.
//  Copyright © 2016 Boris Emorine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <CheckBox/CheckBox-Swift.h>

@interface GroupTests : XCTestCase

@property (strong, nonatomic) NSArray <CheckBox *> *checkBoxes;

@end

@implementation GroupTests

- (void)setUp {
    [super setUp];
    
    NSMutableArray <CheckBox *> *checkBoxes = [NSMutableArray new];
    
    for (NSInteger i = 0; i < 5; i++) {
        [checkBoxes addObject:[CheckBox new]];
    }
    self.checkBoxes = [NSArray arrayWithArray:checkBoxes];
}

- (void)testSelectedCheckBox {
    CheckBoxGroup *group = [[CheckBoxGroup alloc] initWithCheckBoxes:self.checkBoxes];
    XCTAssertNotNil(group);
    XCTAssertNil(group.selectedCheckBox);
    
    group.selectedCheckBox = [CheckBox new];
    XCTAssertNil(group.selectedCheckBox);
    XCTAssertEqual([self selectedCheckBoxForGroup:group], group.selectedCheckBox);
    XCTAssertEqual([self numberOfSelectedCheckBoxesForGroup:group], 0);
    
    group.selectedCheckBox = self.checkBoxes[1];
    XCTAssertEqual(group.selectedCheckBox, self.checkBoxes[1]);
    XCTAssertEqual([self selectedCheckBoxForGroup:group], group.selectedCheckBox);
    XCTAssertEqual([self numberOfSelectedCheckBoxesForGroup:group], 1);
    
    group.selectedCheckBox = self.checkBoxes[2];
    XCTAssertEqual(group.selectedCheckBox, self.checkBoxes[2]);
    XCTAssertEqual([self selectedCheckBoxForGroup:group], group.selectedCheckBox);
    XCTAssertEqual([self numberOfSelectedCheckBoxesForGroup:group], 1);
    
    group.selectedCheckBox = self.checkBoxes[0];
    XCTAssertEqual(group.selectedCheckBox, self.checkBoxes[0]);
    XCTAssertEqual([self selectedCheckBoxForGroup:group], group.selectedCheckBox);
    XCTAssertEqual([self numberOfSelectedCheckBoxesForGroup:group], 1);
    
    group.selectedCheckBox = nil;
    XCTAssertNil(group.selectedCheckBox);
    XCTAssertEqual([self selectedCheckBoxForGroup:group], nil);
    XCTAssertEqual([self numberOfSelectedCheckBoxesForGroup:group], 0);
}

- (void)testAutoSelectFirstCheckBox {
    CheckBoxGroup *group = [[CheckBoxGroup alloc] initWithCheckBoxes:self.checkBoxes];
    XCTAssertNotNil(group);
    XCTAssertNil(group.selectedCheckBox);
    
    group.mustHaveSelection = YES;
    XCTAssertNotNil(group.selectedCheckBox);
    
    group.selectedCheckBox = nil;
    XCTAssertNotNil(group.selectedCheckBox);
}

- (void)testAddCheckBox {
    CheckBoxGroup *group = [[CheckBoxGroup alloc] initWithCheckBoxes:self.checkBoxes];
    XCTAssertNotNil(group);
    XCTAssertEqual(group.checkBoxes.count, self.checkBoxes.count);
    
    CheckBox *checkBox = [CheckBox new];
    [group addCheckBoxToGroup:checkBox];

    XCTAssertEqual(group.checkBoxes.count, self.checkBoxes.count + 1);
}

- (void)testRemoveCheckBox {
    CheckBoxGroup *group = [[CheckBoxGroup alloc] initWithCheckBoxes:self.checkBoxes];
    XCTAssertNotNil(group);
    XCTAssertEqual(group.checkBoxes.count, self.checkBoxes.count);
    
    [group removeCheckBoxFromGroup:[self.checkBoxes firstObject]];
    XCTAssertEqual(group.checkBoxes.count, self.checkBoxes.count - 1);
}

- (void)testEmptyGroup {
    CheckBoxGroup *emptyGroup = [[CheckBoxGroup alloc] initWithCheckBoxes: @[]];
    XCTAssertNotNil(emptyGroup);
    XCTAssertEqual(emptyGroup.checkBoxes.count, 0);
    
    [emptyGroup removeCheckBoxFromGroup:[CheckBox new]];
    XCTAssertEqual(emptyGroup.checkBoxes.count, 0);
    
    emptyGroup.mustHaveSelection = YES;
    XCTAssertEqual(emptyGroup.checkBoxes.count, 0);
    
    [emptyGroup addCheckBoxToGroup:[CheckBox new]];
    XCTAssertEqual(emptyGroup.checkBoxes.count, 1);
}

#pragma mark Helper Methods

- (NSInteger)numberOfSelectedCheckBoxesForGroup:(CheckBoxGroup *)group {
    NSInteger numberOfSelectedCheckBoxes = 0;
    for (CheckBox *checkBox in group.checkBoxes) {
        if (checkBox.on == YES) {
            numberOfSelectedCheckBoxes++;
        }
    }

    return numberOfSelectedCheckBoxes;
}

- (CheckBox *)selectedCheckBoxForGroup:(CheckBoxGroup *)group {
    for (CheckBox *checkBox in group.checkBoxes) {
        if (checkBox.on == YES) {
            return checkBox;
        }
    }
    
    return nil;
}

- (void)tearDown {
    [super tearDown];
}

@end
