//
//  IMIBreadCrumbNode.m
//  BreadCrumbSample
//
//  Created by Muhammad Idris on 12/23/15.
//  Copyright © 2015 ABC-Company. All rights reserved.
//

#import "IMIBreadCrumbNode.h"

static const int kBreadCrumbNodeHeight = 40.0;

@interface IMIBreadCrumbNode ()
{
    
}

@property (nonatomic ,readwrite) BOOL isRootNode;
@property (nonatomic ,readwrite) BOOL isNodeSelected;

@property (nonatomic ,strong) NSDictionary *attributes;


@end

@implementation IMIBreadCrumbNode

@synthesize nodeTitle , attributes , isNodeSelected;

-(id)init{
    
    if(self = [super init]){
        // properties initialized here.
        
        static NSMutableDictionary *attr = nil;
        if(attr == nil){
            attr = [NSMutableDictionary new];
            attr[NSFontAttributeName] = [UIFont fontWithName:@"Arial" size:14.5];
        }
        
        self.attributes = attr;
        self.opaque = NO;
    }
    return self;
}


+(id)nodeWithTitle:(NSString *)titleString andIsRootNode:(BOOL)isRoot{
    
    IMIBreadCrumbNode *node = [IMIBreadCrumbNode new];
    node.nodeTitle = titleString;
    node.isRootNode = isRoot;
    // set frame w.r.t string length
    node.frame = CGRectMake(0, 0, [titleString sizeWithAttributes:node.attributes].width + 50, kBreadCrumbNodeHeight);
    
    return node;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

-(void)setIsTopNode:(BOOL)topNode{
    self.isNodeSelected = topNode;
    
    // [self setNeedsDisplayInRect:self.frame];
    [self setNeedsDisplay];
}
-(BOOL)topNode{
    return self.isNodeSelected;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    

    
    if(self.isNodeSelected){
        [[UIColor colorWithRed:244.0/255.0 green:135.0/255.0 blue:40.0/255 alpha:1.0] setFill];
    }
    else{
        [[UIColor colorWithRed:209.0/255.0 green:211.0/255.0 blue:212.0/255 alpha:1.0] setFill];
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextClearRect(context, rect);
    
    CGContextSetLineWidth(context, 5.0);
    
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    aPath.lineJoinStyle = kCGLineJoinRound;
    
    // Intended Shape
    
    /*
     // When Not Root
     
     A*************B
     *             *
     F             C
     *             *
     E*************D
     
     // When Root
     
     A*************B
     *             *
     *               C
     *             *
     E*************D
     
     */
    
    CGFloat minX = 0.0;
    CGFloat minY = 0.0;
    
    CGFloat width = CGRectGetWidth(rect);
    CGFloat height = CGRectGetHeight(rect);
    
    CGFloat maxX = width;
    CGFloat maxY = height;
    
    // CGFloat edgeOffset = (kBreadCrumbEdgeMultiplier*width);
    CGFloat edgeOffset = 20.0;
    
    if(self.isRootNode){
        // kBreadCrumbEdgeMultiplier = 0;
    }
    
    // initializing points
    CGPoint pointA = CGPointMake(minX , minY);
    
    // CGPoint pointB = CGPointMake(width - (kBreadCrumbEdgeMultiplier*width), minY);
    CGPoint pointB = CGPointMake(width - (edgeOffset), minY);
    
    CGPoint pointC = CGPointMake(maxX, maxY/2);
    
    CGPoint pointD = CGPointMake(width - (edgeOffset), maxY);
    
    CGPoint pointE = CGPointMake(minX , maxY);
    
    // CGPoint pointF = CGPointMake(minX + (kBreadCrumbEdgeMultiplier*width) , height/2);
    CGPoint pointF = CGPointMake(minX + (edgeOffset) , height/2);
    
    // Start from A
    [aPath moveToPoint:pointA];
    
    // Move to B
    [aPath addLineToPoint:pointB];
    
    // Move to C
    [aPath addLineToPoint:pointC];
    
    // Move to D
    [aPath addLineToPoint:pointD];
    
    // Move to E
    [aPath addLineToPoint:pointE];
    
    if(self.isRootNode == NO){
        // Move to F
        [aPath addLineToPoint:pointF];
    }
    // Move back to A
    [aPath addLineToPoint:pointA];
    [aPath closePath];
    
    [aPath fill];
    
    
    CGRect frame = rect;
    
    CGSize size = [self.nodeTitle sizeWithAttributes:attributes];
    
    /*
    if(self.isRootNode){
        frame.origin.x = (CGRectGetMidX(frame) - (size.width/2))-3;
    }
    else{
        frame.origin.x = (CGRectGetMidX(frame) - (size.width/2)) + 3;
    }
    */
    frame.origin.x = (CGRectGetMidX(frame) - (size.width/2));
    
    frame.origin.y = CGRectGetMidY(frame) - (size.height/2);
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithDictionary:attributes];
    
    UIColor *textColor = [UIColor blackColor];
    if(self.isNodeSelected){
        textColor = [UIColor whiteColor];
    }
    
    dictionary[NSForegroundColorAttributeName] = textColor;
    
    [self.nodeTitle drawInRect:frame withAttributes:dictionary];
}


@end
