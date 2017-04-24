<p align="center">
    <img src="http://i.imgur.com/gagL1bk.png" alt="Game Maker skeleton system" width="350" title="Credit to Michael Blue" />
</a>

<h1 align="center">sk</h1>

sk is an easy to use skeletal system for [Game Maker](http://yoyogames.com) Language by Nik Sudan. Please give credit when used, that's all I ask of you!

Massive thanks to [Michael Savchuk](https://twitter.com/ThePixelRobin) for the sk icon!

![Demo](http://i.imgur.com/twQfr0Q.gif)

## Creating Skeletons

You cannot define a skeleton within Game Maker, sk loads in skeletons externally, using .sk files. These are structured like .ini files, and contain information about each joint's properties. [A GUI for creating skeletons is available on itch.io for a very small fee for Windows only](http://nik.itch.io/sk-creator).

![GUI](http://i.imgur.com/ktp9Kwz.png)

## Setting Up The Skeleton

Simply import the .gml file into your project - preferably a folder within your scripts. Nothing else is needed with you and the scripts, you're done.

Skeletons are loaded using <code>sk_import</code> and return the skeleton's data for use with skeleton systems. This way you can load one skeleton that'll be used by loads of entities. Calling this in the **Game Start** or **Room Start** events are recommended. Use this function:

    data = sk_import('pathToFile');
    
Once you've initialised the skeleton, you can now use with objects. You can set an object to become a skeleton by using the following function in it's **Create** event:

    sk_create( data );
    
Now you've set it up, but the skeleton won't move. You need to update it, and this can be done with the **Begin Step** event. You can use an **Alarm** event if you want to call it less often, but it's a lot smoother when you don't do that. Simply call this function:

    sk_update();
    
And that's it!

## Making Joints Move

I take it you want to manipulate the joints and give it a cool, smooth animation. You can move a joint by calling the following function:

    sk_setTargetAngle( jointID, angle );
    
The angle the skeleton is imported in at will be the zero value for <code>angle</code>. You can find out the <code>jointID</code> from your sk file or the creator.

**Note:** There is a function called <code>sk_setAngle()</code> in the library - this will immediately change the angle of the joint. The joint will move back to the target angle after you call this, so don't use it for animation.

You can then set the rotation speed of the joint with the following function:

    sk_setRotationSpeed( jointID, speed );

The bigger the <code>speed</code> is, the faster it'll move (duh).

## Drawing Stuff

Ok, you'll want to see your skeleton, right? You can call a little debugging function to see the skeleton in action:

    sk_draw();
    
I wouldn't recommend using that for your final product. You can get the position and angle of each joint by calling these respective functions:

    jointX = sk_getX( jointID );
    jointY = sk_gety( jointID );
    jointAngle = sk_getAngle( jointID );
    
Draw whatever you want on these, I won't hold you back.

## Examples Of Use

![Demo](http://i.imgur.com/Yh7LZNp.gif)

![Demo](http://i.imgur.com/pz6awr5.gif)

![Demo](http://i.imgur.com/iT6KS7U.gif)

![Demo](http://i.imgur.com/89flKEe.gif)
