//
//  AAMole.h
//  whackamole
//
//  Created by Kyle Oba on 3/8/14.
//  Copyright (c) 2014 AgencyAgency. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AAMole : UIButton
+ (NSValue *)keyValueForMole:(AAMole *)mole;
- (id)initAtLocation:(CGPoint)location;
- (BOOL)isInPlayingField;
@end
