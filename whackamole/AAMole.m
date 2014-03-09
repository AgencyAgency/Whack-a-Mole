//
//  AAMole.m
//  whackamole
//
//  Created by Kyle Oba on 3/8/14.
//  Copyright (c) 2014 AgencyAgency. All rights reserved.
//

#import "AAMole.h"

@implementation AAMole

+ (NSValue *)keyValueForMole:(AAMole *)mole
{
    return [NSValue valueWithPointer:(__bridge const void *)(mole)];
}

- (id)initAtLocation:(CGPoint)location
{
    CGRect frame = CGRectMake(0.0, 0.0, 20.0, 20.0);
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.center = location;
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (BOOL)isInPlayingField
{
    if (!self.superview) return NO;
    return CGRectIntersectsRect(self.superview.bounds, self.frame);
}

@end
