//
//  AAMole.h
//  whackamole
//
//  Created by Kyle Oba on 3/8/14.
//  Copyright (c) 2014 AgencyAgency. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AAMoleDelegate.h"

@interface AAMole : UIView

@property (weak, nonatomic) id<AAMoleDelegate> delegate;

+ (NSValue *)keyValueForMole:(AAMole *)mole;
- (id)initAtLocation:(CGPoint)location;
- (BOOL)isInPlayingField;
@end
