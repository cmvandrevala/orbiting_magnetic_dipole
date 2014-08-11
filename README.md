Orbiting Magnetic Dipole
========================

Background
----------

This simulation calculates the path and orientation of a bar magnet as it orbits around the Earth. It creates a short Matlab animation of the bar magnet as it moves, followed by a plot of all of the superimposed positions and orientations.

The simulation is supposed to be completely self-contained in one Matlab script file so that anybody can open it in Matlab and immediately see results.

**IMPORTANT NOTE:** The animation is NOT supposed to give the correct time dependence of the path.  We are simply interested in the sequence of positions and orientations of the dipole rather than their values as a function of time.  If you want the actual time dependence of the path, the code would have to be modified to slow down the animation by a factor of the time step.


Assumptions
-----------

* We use SI units for all variables.
* The Earth is modeled as a point mass at the origin (0,0,0).
* The Earth is completely unaffected by the gravitational pull of the bar magnet.
* The moment of intertia of the bar magnet about an axis perpendicular to the length of the bar magnet must be non-zero.


Variables
---------

**Remember, all variables are in SI units**

moment\_of\_inertia => The moment of inertia of the bar magnet about an axis perpendicular to the length of the bar, passing through its center (default 10).

magnet\_moment => The magnetic moment of the bar magnet along the x-, y-, and z-directions (default of [0; 1; 0]).

earth\_moment => The magnetic moment of the Earth (default of [0; 7.94e22; 0]).

initial\_position => The initial position of the magnet (default of [0; 2000000; 0]).

initial\_velocity => The intial velocity of the magnet (default of [10000; 1000; 1000]).

gravitational\_constant => Newton's gravitational constant (default of 6.67384e-11).

mass\_of\_earth => The mass of the Earth (default of 5.97219e24).

number\_of\_data_points => Number of steps to take in the simulation (default 500).

time\_step => Time step in seconds (default 5).
