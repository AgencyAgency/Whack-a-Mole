//
//  AAViewController.m
//  whackamole
//
//  Created by Kyle Oba on 3/8/14.
//  Copyright (c) 2014 AgencyAgency. All rights reserved.
//

#import "AAFieldVC.h"
#import "AAMole.h"

@interface AAFieldVC ()
@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (assign, nonatomic) CGPoint moleDirection;

@property (strong, nonatomic) CADisplayLink *displayLink;
@property (strong, nonatomic) NSMutableDictionary *behaviors;
@end

@implementation AAFieldVC

- (NSMutableDictionary *)behaviors
{
    if (!_behaviors) {
        _behaviors = [NSMutableDictionary dictionary];
    }
    return _behaviors;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Add animator:
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self startTickerLoop];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self.displayLink invalidate];
    self.displayLink = nil;
}

- (void)addMoleAtLocation:(CGPoint)location
{
    AAMole *mole = [[AAMole alloc] initAtLocation:location];
    [self.view addSubview:mole];
    [self flickMole:mole];
}

- (void)flickMole:(AAMole *)mole
{
    UIPushBehavior *flickBehavior = [[UIPushBehavior alloc] initWithItems:@[mole] mode:UIPushBehaviorModeInstantaneous];
    CGPoint moleDirection = [[self valueForKey:@"moleDirection"] CGPointValue];
    flickBehavior.pushDirection = CGVectorMake(moleDirection.x, moleDirection.y);
    
    // Must set magnitude *after* setting direction:
    flickBehavior.magnitude = 0.1f;
    
    [self.animator addBehavior:flickBehavior];
    self.behaviors[[AAMole keyValueForMole:mole]] = flickBehavior;
}

- (IBAction)handleFieldTap:(UITapGestureRecognizer *)sender
{
    NSLog(@"tap");
    [self addMoleAtLocation:[sender locationInView:self.view]];
}

#pragma mark - Display Link Tick-Tock

- (CADisplayLink *)displayLink{
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self
                                                   selector:@selector(tick:)];
        _displayLink.frameInterval = 60;
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop]
                           forMode:NSDefaultRunLoopMode];
        _displayLink.paused = YES;
    }
    return _displayLink;
}

- (void)startTickerLoop
{
    self.displayLink.paused = NO;
}

- (void)stopTickerLoop
{
    self.displayLink.paused = YES;
}

- (void)tick:(CADisplayLink *)sender
{
    NSLog(@"behaviors added: %i", [[self.animator behaviors] count]);
    
    NSMutableArray *deadMoles = [NSMutableArray array];
    NSUInteger moleCount = 0;
    for (UIView *subview in self.view.subviews) {
        if ([subview isKindOfClass:[AAMole class]]) {
            AAMole *mole = (AAMole *)subview;
            moleCount++;
            if (![mole isInPlayingField]) {
                [deadMoles addObject:mole];
            }
        }
    }
    NSLog(@"moles added: %i", moleCount);
    
    [self removeDeadMoles:deadMoles];
}


# pragma mark - Moles

- (void)removeDeadMoles:(NSArray *)deadMoles
{
    for (AAMole *mole in deadMoles) {
        NSValue *key = [AAMole keyValueForMole:mole];
        UIDynamicBehavior *behavior = self.behaviors[key];
        [self.animator removeBehavior:behavior];
        [self.behaviors removeObjectForKey:key];
        
        [mole removeFromSuperview];
    }
}

@end
