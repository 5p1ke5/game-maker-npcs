/// @function Point2(_x, _y) constructor
/// @desc data structure for a 2d point.
/// @param _x x coordinate of point.
/// @param _y y coordinate of point.
function Point2(_x, _y) constructor
{
	x = _x;
	y = _y;
}


/// @function Point3(_x, _y) constructor
/// @desc data structure for a 3d point. Inherits from 3d point.
/// @param _x x coordinate of point.
/// @param _y y coordinate of point.
function Point3(_x, _y, _z) : Point2 (_x, _y) constructor
{
	z = _z;
}