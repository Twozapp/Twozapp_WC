//
//  IconDownloaderImage.m
//  Twozapp
//
//  Created by Priya on 30/01/16.
//  Copyright © 2016 Priya. All rights reserved.
//

#import "IconDownloaderImage.h"

@implementation IconDownloaderImage
@synthesize userFriends;

- (void)startDownload
{
    // making a data and sending request to url
    self.activeDownload = [NSMutableData data];
    
    // alloc+init and start an NSURLConnection; release on completion/failure
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[[userFriends.fndEmail stringByReplacingOccurrencesOfString:@" " withString:@"%20"] stringByReplacingOccurrencesOfString:@"styles/thumbnail/public/" withString:@""]]] delegate:self];
    
    self.imageConnection = conn;
    
}



- (void)cancelDownload
{
    [self.imageConnection cancel];
    self.imageConnection = nil;
    self.activeDownload = nil;
}


#pragma mark -
#pragma mark Download support (NSURLConnectionDelegate)

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
    
    [self.activeDownload appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // Clear the activeDownload property to allow later attempts
    self.activeDownload = nil;
    
    // Release the connection now that it's finished
    self.imageConnection = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // Set appIcon and clear temporary data/image
    UIImage *image = [[UIImage alloc] initWithData:self.activeDownload];
    
    //userFriends.appIcon = image;
    
    self.activeDownload = nil;
    
    self.imageConnection = nil;
    
    [_delegateProduct appDidDownloadImage:self.indexPathinCollectionView];
    
}

@end
