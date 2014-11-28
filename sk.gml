#define nearestPoint
//x,y
near = 0;
for (i=0; i<ds_list_find_value(data,1); i+=1) {
    if point_distance(sk_getX(i),sk_getY(i),argument0,argument1) <= point_distance(sk_getX(near),sk_getY(near),argument0,argument1)
        near = i;
}
return near;

#define pointDirection
/*

argument0   x1
argument1   y1
argument2   x2
argument3   y2

*/
return ((((arctan2(argument0-argument2,argument1-argument3)* (180/pi))) + 450) mod 360);

#define sk_create
/***************************************************
  Create Skeleton Structure
 ***************************************************
 
 sk_create(Skeleton Data);

 Creates the actual skeleton structure the system uses

 Reference:
 
    Skeleton Structure Data:
    0   parent
    1   x
    2   y
    3   x offset
    4   y offset
    5   angle
    6   target angle
    7   rotation speed
    8   clamp min
    9   clamp max
*/

var iData, pData;

iData = argument0;

if iData != -1 {
    pData = ds_list_find_value(iData,2);
    SK_DATA = ds_grid_create(ds_list_find_value(iData,1),10);
    SK_SCALE = 1;
    sk_setX(0,x);
    sk_setY(0,y);
    for (i=1; i<ds_list_find_value(iData,1); i+=1) {
        sk_setX(i,0);
        sk_setY(i,0);
    }
    for (i=0; i<ds_list_find_value(iData,1); i+=1) {
        sk_setParent(i,ds_grid_get(pData,i,0));
        sk_setXOffset(i,ds_grid_get(pData,i,1));
        sk_setYOffset(i,ds_grid_get(pData,i,2));
        sk_setClampMin(i,ds_grid_get(pData,i,3));
        sk_setClampMax(i,ds_grid_get(pData,i,4));
        sk_setAngle(i,0);
        sk_setTargetAngle(i,0);
        sk_setRotationSpeed(i,10);
        
        sk_updateJoint(i);
    }
}

#define sk_draw
/***************************************************
  Draw Skeleton
 ***************************************************
 
 sk_draw();
 
 Draws the skeleton using the Skeleton Structure Data
 
*/

var xval, yval, par;

for (i=0; i<ds_grid_width(SK_DATA); i+=1) {
    xval = sk_getX(i);
    yval = sk_getY(i);
    draw_circle(xval,yval,5,false);
    if i > 0 {
        par = sk_getParent(i);
        draw_line(xval,yval,sk_getX(par),sk_getY(par));
    }
}

#define sk_getAngle
return ds_grid_get(SK_DATA,argument0,5);

#define sk_getClampMax
return ds_grid_get(SK_DATA,argument0,9);

#define sk_getClampMin
return ds_grid_get(SK_DATA,argument0,8);

#define sk_getParent
return ds_grid_get(SK_DATA,argument0,0);

#define sk_getRotationSpeed
return ds_grid_get(SK_DATA,argument0,7);

#define sk_getTargetAngle
return ds_grid_get(SK_DATA,argument0,6);

#define sk_getX
return ds_grid_get(SK_DATA,argument0,1);

#define sk_getXOffset
return ds_grid_get(SK_DATA,argument0,3);

#define sk_getY
return ds_grid_get(SK_DATA,argument0,2);

#define sk_getYOffset
return ds_grid_get(SK_DATA,argument0,4);

#define sk_import
/***************************************************
  Import Skeleton Data
 ***************************************************
 
 sk_import(filename);
 Returns: Skeleton Data

 Imports a skeleton from a .sk file and converts it to Skeleton Data
 Skeleton Data can be used to create many skeletons
 Skeleton Data is used in sk_create

 Reference:
 
    Skeleton Data:
    0   name
    1   number of joints
    2   point data (Point ID, Value ID)
    
    Value ID:
    0   parent (-1 = root joint)
    1   x offset from parent at angle 0
    2   y offset from parent at angle 0
    3   minimum clamp range
    4   maximum clamp range
*/

var name, noOfJoints, points, data;

if file_exists(argument0) {
    ini_open(argument0);
    
    name = ini_read_string("Skeleton","id","Skeleton");
    noOfJoints = ini_read_real("Skeleton","joints",0);
    points = ds_grid_create(noOfJoints,5);
    
    ds_grid_set(points,0,0,-1);
    for (i=1; i<5; i+=1)
        ds_grid_set(points,0,i,0);
    
    for (i=1; i<noOfJoints; i+=1) {
        ds_grid_set(points,i,0,ini_read_real(string(i),"parent",0));
        ds_grid_set(points,i,1,ini_read_real(string(i),"xoffset",0));
        ds_grid_set(points,i,2,ini_read_real(string(i),"yoffset",0));
        ds_grid_set(points,i,3,ini_read_real(string(i),"clampmin",0));
        ds_grid_set(points,i,4,ini_read_real(string(i),"clampmax",0));
    }
    ini_close();
    
    data = ds_list_create();
    ds_list_insert(data,0,name);
    ds_list_insert(data,1,noOfJoints);
    ds_list_insert(data,2,points);
    
    return data;
} else {
    show_message("Error - Could not open skeleton file "+argument0);
    return -1;
}

#define sk_pointX
// sk_pointX(parent x, x offset, y offset, angle)
return ((argument1*cos(degtorad(-argument3)))-(argument2*sin(degtorad(-argument3))))+argument0;

#define sk_pointY
//sk_pointY(parent y, x offset, y offset, angle)
return ((argument1*sin(degtorad(-argument3)))+(argument2*cos(degtorad(-argument3))))+argument0;

#define sk_rotate
//angle = sk_rotate(angle,target angle,speed)
return (argument0+(sin(degtorad((argument1)-argument0))*argument2));

#define sk_setAngle
ds_grid_set(SK_DATA,argument0,5,argument1);

#define sk_setClampMax
ds_grid_set(SK_DATA,argument0,9,argument1);

#define sk_setClampMin
ds_grid_set(SK_DATA,argument0,8,argument1);

#define sk_setParent
ds_grid_set(SK_DATA,argument0,0,argument1);

#define sk_setRotationSpeed
ds_grid_set(SK_DATA,argument0,7,argument1);

#define sk_setTargetAngle
ds_grid_set(SK_DATA,argument0,6,argument1);

#define sk_setX
ds_grid_set(SK_DATA,argument0,1,argument1);

#define sk_setXOffset
ds_grid_set(SK_DATA,argument0,3,argument1);

#define sk_setY
ds_grid_set(SK_DATA,argument0,2,argument1);

#define sk_setYOffset
ds_grid_set(SK_DATA,argument0,4,argument1);

#define sk_update
/***************************************************
  Update Skeleton Structure
 ***************************************************
 
 sk_update();
 
 Used in the step event of an object with a skeleton in it
 It keeps the structure updated due to rotations
 
*/

sk_setX(0,x);
sk_setY(0,y);
for (i=0; i<ds_grid_width(SK_DATA); i+=1) {
    sk_updateJoint(i);
}

#define sk_updateJoint
/***************************************************
  Update a Joint
 ***************************************************

 sk_updateJoint(point ID);
 
 Updates an individual joint's positioning and angle
 
*/

var point, par, xoff, yoff, xpar, ypar;

point = argument0;
par = sk_getParent(point);
xoff = sk_getXOffset(point)*SK_SCALE;
yoff = sk_getYOffset(point)*SK_SCALE;
xpar = sk_getX(par);
ypar = sk_getY(par);
curAng = sk_getAngle(point);
parAng = sk_getAngle(par);

sk_setAngle(point,sk_rotate(curAng,sk_getTargetAngle(point)+parAng,sk_getRotationSpeed(point)));

if point != 0 {
    sk_setX(point,sk_pointX(xpar,xoff,yoff,curAng));
    sk_setY(point,sk_pointY(ypar,xoff,yoff,curAng));
    sk_setTargetAngle(point,clamp(sk_getTargetAngle(point),sk_getClampMin(point),sk_getClampMax(point)));
} else {
    sk_setX(0,x);
    sk_setY(0,y);
}
