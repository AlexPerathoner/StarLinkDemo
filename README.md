# StarLinkDemo
Inspired by Starlink.
I reccomend to watch [this video](https://www.youtube.com/watch?v=giQ8xEWjnBs&feature=youtu.be) to better understand what this project is about.

Currently there's just a [pre-release](https://github.com/AlexPerathoner/StarLinkDemo/releases/tag/v1.0.0) available.

## Features:

![](Screens/Example.mov)

Click on the screen to place two points. This demo will connect them along the orbits of the satellites.

### Notes:
**This is just a demo!**
Here's a list of things that are wrong:

- If you place one point in America and the other in Asia the connection will still go through Africa. *Links don't know that the Earth is round.*
- If the two points are in the same sector they will connect directly. However, there should always be at least one satellite involved.
- "Hops" are not optimized. In the video it's well explained but even without having it seen you can image that the greater the number of links that "hop" from an orbit to the other, the worse it is. In the real-world implementation this should be avoided. *But this is just a demo*.
- Links are constantly updated. It's not necessarily wrong, but in the video it's presented differently.

## Future updates!
**If** there will any update or proper release I'll try to fix some of the things written above.
<br>PS: it's higly probable that this update will never come.