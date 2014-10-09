//
//  UIImageView+URL.m
//  JMJUtilities
//
//  Created by J.J. Jackson on 2/27/13.
//

#import "UIImageView+URL.h"
#import <objc/runtime.h>

static char kKeyImageURL;
static char kKeyReceivedData;
static char kKeyConnection;
static char kKeyUseActivityIndicator;
static char kKeyActivityIndicator;

#define TAG_ACTIVITY_INDICATOR 1337

@implementation UIImageView (URL)

#pragma mark - Properties

- (BOOL)useActivityIndicator
{
  NSNumber *number = objc_getAssociatedObject(self, &kKeyUseActivityIndicator);
  return number ? [number boolValue] : NO;
}
- (void)setUseActivityIndicator:(BOOL)value
{
  BOOL turnedOn = !self.useActivityIndicator && value;
  NSNumber *number = [NSNumber numberWithBool:value];
  objc_setAssociatedObject(self, &kKeyUseActivityIndicator, number, OBJC_ASSOCIATION_RETAIN);
  if (turnedOn)
  {
    NSURLConnection *connection = [self connection];
    if (connection)
    {
      [self toggleActivityIndicator:YES];
    }
  }
}

- (NSURL *)imageURL
{
  return objc_getAssociatedObject(self, &kKeyImageURL);
}

- (void)setImageURL:(NSURL *)value
{
  objc_setAssociatedObject(self, &kKeyImageURL, value, OBJC_ASSOCIATION_RETAIN);
  if (!self.image)
  {
    UIImage *image = [UIImage imageNamed:IMG_PLACEHOLDER];
    self.image = image;
  }
  [self fetchImage:value];
}


#pragma mark - Pseudo Properties

- (UIActivityIndicatorView *)activityIndicatorView
{
  UIActivityIndicatorView *aiView = objc_getAssociatedObject(self, &kKeyActivityIndicator);
  if (!aiView)
  { // lazy initializer
    aiView = [[UIActivityIndicatorView alloc]
              initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    aiView.tag = TAG_ACTIVITY_INDICATOR;
    aiView.frame = CGRectMake((self.frame.size.width - aiView.frame.size.width)/2,
                              (self.frame.size.height - aiView.frame.size.height)/2,
                              aiView.frame.size.width, aiView.frame.size.height);
    objc_setAssociatedObject(self, &kKeyActivityIndicator, aiView, OBJC_ASSOCIATION_RETAIN);
    [self addSubview:aiView];
  }

  return aiView;
}

- (NSMutableData *)receivedData
{
  return objc_getAssociatedObject(self, &kKeyReceivedData);
}

- (NSURLConnection *)connection
{
  return objc_getAssociatedObject(self, &kKeyConnection);
}

#pragma mark - Other

- (void)fetchImage:(NSURL *)url
{
  NSURLConnection *connection = [self connection];
  if (connection)
  {
    [connection cancel];
    objc_setAssociatedObject(self, &kKeyConnection, nil, OBJC_ASSOCIATION_RETAIN);
  }

  NSMutableData *data = [[NSMutableData alloc] init];
  objc_setAssociatedObject(self, &kKeyReceivedData, data, OBJC_ASSOCIATION_RETAIN);
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
  connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
  objc_setAssociatedObject(self, &kKeyConnection, connection, OBJC_ASSOCIATION_RETAIN);
  [connection start];

  if (self.useActivityIndicator)
  {
    [self toggleActivityIndicator:YES];
  }
}



- (void)toggleActivityIndicator:(BOOL)active
{
  UIActivityIndicatorView *aiView = [self activityIndicatorView];
  if (active) {

    // re-center
    CGRect frame = CGRectMake((self.frame.size.width - aiView.frame.size.width)/2,
                              (self.frame.size.height - aiView.frame.size.height)/2,
                              aiView.frame.size.width, aiView.frame.size.height);
    aiView.frame = frame;
    [aiView startAnimating];
  } else {
    [aiView stopAnimating];
  }
}

#pragma mark - NSURLConnectionDataDelegate implementation

- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)theData
{
  if (theConnection == [self connection]) {
    [[self receivedData] appendData:theData];
  }
  [self toggleActivityIndicator:YES];
}

- (void)connection:(NSURLConnection *)theConnection didFailWithError:(NSError *)theError
{
  NSLog(@"%@", theError);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)theConnection
{
  if (theConnection == [self connection]) {
    // make sure a new connection hasn't been kicked off
    UIImage *image = [UIImage imageWithData:[self receivedData]];
    self.image = image;
    objc_setAssociatedObject(self, &kKeyReceivedData, nil, OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(self, &kKeyConnection, nil, OBJC_ASSOCIATION_RETAIN);

    if (self.useActivityIndicator) {
      [self toggleActivityIndicator:NO];
    }
  }
}

#pragma mark - Initializers

- (instancetype)initWithImageURL:(NSURL *)url
{
  self = [self initWithImage:[UIImage imageNamed:IMG_PLACEHOLDER]];
  if (self) {
    self.imageURL = url;
  }
  return self;
}

@end
