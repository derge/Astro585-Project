#Use kplr interface to access the data at MAST; note that it is a pythonic interface.
#Hence we need to use PyCall to adapt it to Julia.
using PyCall;
@pyimport kplr
@pyimport matplotlib.pyplot as pl

#download lightcurves
client = kplr.API()
koi = client[:koi](97.01)
lcs = koi[:get_light_curves](short_cadence=false)
n_lcs = length(lcs)

#array to store finalised data
time, flux, quality = [], [], []

for i=1:n
   hdu = lcs[i][:open]();
   hdu_data = hdu[2][:data]; #extract the relevant data from the hdu
   time_temp = convert(Array{Float64,1},hdu_data[:field]("TIME"));                 #Time
   sap_flux_temp = convert(Array{Float64,1},hdu_data[:field]("SAP_FLUX"));         #Flux
   sap_flux_temp_err = convert(Array{Float64,1},hdu_data[:field]("SAP_FLUX_ERR")); #Flux_Error

   sap_quality = convert(Array{Float64,1},hdu_data[:field]("SAP_QUALITY"));        #Quality

   idx_good = [];               #an array to store the indices of good data points
   n_time = length(time_temp)
   for i = 1:n_time
       if (is(sap_flux_temp[i],NaN) || is(sap_flux_temp[i],Inf) || is(time_temp[i],NaN)|| is(time_temp[i],Inf) || sap_quality[i]!=0 || in(floor(mjd[i]),first_day_quarter))

       else
        append!(idx_good,[i])
       end
   end

  #Net N_good and N_bad, min of good points needed to qualify as a segment and bad points to qualify as a segment break
  N_good = 300;
  N_bad = 5;

  seg_idx = get_segment(N_good,N_bad,idx_good);

  #Normalize segments before combining and plotting them
  n_seg = length(seg_idx);

  for i=1:n_seg
        mean_flux = mean(sap_flux_temp[seg_idx[i]]);
        sap_flux_temp[seg_idx[i]]= (sap_flux_temp[seg_idx[i]]-mean_flux)/mean_flux;		# normalize each segment
        append!(time,time_temp[seg_idx[i]]);
          append!(flux,sap_flux_temp[seg_idx[i]]);
  end


end

