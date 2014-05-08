Transiting Planet Candidates Search
===============

One of the methods to detect exoplanets is the transit method. In this method, we observe the light curve data (such as ones collected by Kepler) and look for characteristic transiting curves. Whenever a planet transits in front of its parent star's disk, the observed flux of the star decreases. Observed over a long period of time, this results in a characteristic curve from which one can obtain important information about the exoplanet such as its period, mass, etc.

In this project, we analyze data collected by Kepler and search for possible transiting planet candidates. This is done in following steps:


1. Load Light Curves:
   
Using kplr package, we can conveniently access the Kepler data available at MAST for our analysis. These are stored in FITS files and we need to extract the relevant portion, ie, (time, flux, quality).

We started with


2. Apply Search Algorithm:

