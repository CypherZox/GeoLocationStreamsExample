# geo_loc_stream

A simple Flutter project I used to practice using Streams.

## Getting Started

What are Streams in Flutter?
Streams are used when you want your app to receive/ interact with asynchronous data.
For example, if we’ll be receiving changing data from a server, and we want our app to be alerted when the changes happen instead of making the app check for the changes we can use streams that we can subscribe to and once the changes happen the stream controller will listen to the changes and the app will respond to that according to how we program the response.
To use streams in our UI we simply wrap the widget with StreamBuilder, but how are we going to set our stream?
First create a StreamController (”This controller allows sending data, error and done events on its stream”) and to be able to listen to the data of your stream we use StreamSubscription (”A subscription on events from a Stream. When you listen on a Stream using Stream.listen, a StreamSubscription object is returned.”)
To stop your stream from sending data we use .close(), and to cancel a subscription we use .cancel() these two functions are usually placed in the dispose method.
I have never used Stream directly as they are, it’s always used through a package or with a package/library like(RxDart), but it’s better to get an understanding of what streams are to be able to work with the packages that have Streams underneath them.
Here’s a very simple example I created using the GeoLocation with Streams(the color of the text changes whenever the stream listens to a new even - if I was changing locations it would change the values too)

