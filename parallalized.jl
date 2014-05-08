
#  //Since the project requires analyzing over a large number of lightcurve data, fetching the data and storing them in arrays takes
#     considerable amount of time. This step could be parallelized which I have tried to do here with @spawn method.//


using PyCall;
@pyimport kplr
@pyimport matplotlib.pyplot as pl

#download lightcurves
client = kplr.API();
koi = client[:koi](97.01);
lcs = koi[:get_light_curves](short_cadence=false);
n_lcs = length(lcs);

@everywhere function fetch_lightcurve_data(n_lcs::Int64)
  tic();
     for i=1:n_lcs
        hdu = lcs[i][:open]();
        hdu_data = hdu[2][:data]; #extract the relevant data from the hdu

        time_temp = @spawn convert(Array{Float64,1},hdu_data[:field]("TIME"));                 #Time
        sap_flux_temp = @spawn convert(Array{Float64,1},hdu_data[:field]("SAP_FLUX"));         #Flux
        sap_flux_temp_err = @spawn convert(Array{Float64,1},hdu_data[:field]("SAP_FLUX_ERR")); #Flux_Error
        sap_quality = @spawn convert(Array{Float64,1},hdu_data[:field]("SAP_QUALITY"));        #Quality
    end
  toc();

end
