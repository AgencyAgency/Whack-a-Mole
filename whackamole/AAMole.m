//
//  AAMole.m
//  whackamole
//
//  Created by Kyle Oba on 3/8/14.
//  Copyright (c) 2014 AgencyAgency. All rights reserved.
//

#import "AAMole.h"

#define MOLE_WIDTH 50.0

@interface AAMole ()
@property (strong, nonatomic) UITapGestureRecognizer *tapGesture;
@end

@implementation AAMole

+ (NSValue *)keyValueForMole:(AAMole *)mole
{
    return [NSValue valueWithPointer:(__bridge const void *)(mole)];
}

- (UITapGestureRecognizer *)tapGesture
{
    if (!_tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    }
    return _tapGesture;
}

- (id)initAtLocation:(CGPoint)location
{
    CGRect frame = CGRectMake(0.0, 0.0, MOLE_WIDTH, MOLE_WIDTH);
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.center = location;
        self.backgroundColor = [UIColor redColor];
        [self addGestureRecognizer:self.tapGesture];
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

- (void)handleTapGesture:(UITapGestureRecognizer *)tapGesture
{
    NSLog(@"tap mole!");
    if (self.delegate && [self.delegate respondsToSelector:@selector(hasBeenWhacked:)]) {
        [self.delegate hasBeenWhacked:self];
    }
}

@end
