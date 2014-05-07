#use kplr interface to access the data at MAST, note that it is a pythonic interface
#hence we need to use PyCall to adapt it to Julia.
using PyCall;
@pyimport kplr
@pyimport matplotlib.pyplot as pl

#download lightcurves
client = kplr.API()
koi = client[:koi](97.01)
lcs = koi[:get_light_curves](short_cadence=false)
n = length(lcs)

#array to store finalised data
time, flux, ferr, quality = [], [], [], []

for i=1:n
        hdu = lcs[i][:open]();
        hdu_data = hdu[2][:data]; #extract the relevant data from the hdu

     #Time
     time_temp = convert(Array{Float64,1},hdu_data[:field]("TIME"));

     #Flux
     sap_flux_temp = convert(Array{Float64,1},hdu_data[:field]("SAP_FLUX"));

     #Quality
     sap_quality = convert(Array{Float64,1},hdu_data[:field]("SAP_QUALITY"));
