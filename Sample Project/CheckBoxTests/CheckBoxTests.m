//
//  CheckBoxTests.m
//  CheckBoxTests
//
//  Created by Bobo on 8/29/15.
//  Copyright (c) 2015 Boris Emorine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <CheckBox/CheckBox-Swift.h>

@interface CheckBoxTests : XCTestCase

@property (strong, nonatomic) CheckBox *checkBox;

@end

@implementation CheckBoxTests

- (void)setUp {
    [super setUp];
    
    self.checkBox = [CheckBox new];
}

- (void)tearDown {
    self.checkBox = nil;
    
    [super tearDown];
}

- (void)testInit {
    
    XCTAssertNotNil(self.checkBox);
    
    // Default values
    XCTAssert(self.checkBox.on == NO, @"The default value for 'on' should be 'NO'");
    XCTAssert(self.checkBox.hideBox == NO, @"The box shouldn't be hidden by default");
    XCTAssert([self.checkBox.onTintColor isEqual:[UIColor colorWithRed:0 green:122.0/255.0 blue:255/255 alpha:1]], @"Default on tint color");
    XCTAssert([self.checkBox.onFillColor isEqual:[UIColor clearColor]], @"Default on fill color");
    XCTAssert([self.checkBox.onCheckColor isEqual:[UIColor colorWithRed:0 green:122.0/255.0 blue:255/255 alpha:1]], @"Default on check color");
    XCTAssert([self.checkBox.tintColor isEqual:[UIColor lightGrayColor]], @"Default tint color");
    XCTAssert(self.checkBox.lineWidth == 2.0, @"Default line width should be 2.0");
    XCTAssert(self.checkBox.animationDuration == 0.5, @"Default animation duration should be 0.5");
    XCTAssert(self.checkBox.onAnimationType == AnimationTypeStroke, @"Default on animation should be of type stroke");
    XCTAssert(self.checkBox.offAnimationType == AnimationTypeStroke, @"Default off animation should be of type stroke");
    XCTAssert([self.checkBox.backgroundColor isEqual:[UIColor clearColor]], @"Background color should be transparent");
}

- (void)testSetOnAnimated {
    [self.checkBox setOn:YES animated:NO];
    XCTAssertTrue(self.checkBox.on);
    [self.checkBox layoutIfNeeded];
    XCTAssertEqual(self.checkBox.layer.sublayers.count, 3);
    
    [self.checkBox setOn:NO animated:NO];
    XCTAssertFalse(self.checkBox.on);
    [self.checkBox layoutIfNeeded];
    XCTAssertEqual(self.checkBox.layer.sublayers.count, 1);
    
    [self.checkBox setOn:YES animated:YES];
    XCTAssertTrue(self.checkBox.on);
    XCTAssertEqual(self.checkBox.layer.sublayers.count, 3);
    
    [self.checkBox setOn:NO animated:YES];
    XCTAssertFalse(self.checkBox.on);
}

- (void)testOn {
    self.checkBox.on = YES;
    XCTAssertTrue(self.checkBox.on);
    [self.checkBox layoutIfNeeded];
    XCTAssertEqual(self.checkBox.layer.sublayers.count, 3);
    
    self.checkBox.on = NO;
    XCTAssertFalse(self.checkBox.on);
    [self.checkBox layoutIfNeeded];
    XCTAssertEqual(self.checkBox.layer.sublayers.count, 1);
}

- (void)testReload {
    self.checkBox.on = NO;
    XCTAssertFalse(self.checkBox.on);
    
    [self.checkBox setNeedsDisplay];
    XCTAssertFalse(self.checkBox.on);
    
    self.checkBox.on = YES;
    XCTAssertTrue(self.checkBox.on);
    
    [self.checkBox setNeedsDisplay];
    XCTAssertTrue(self.checkBox.on);
}

@end
