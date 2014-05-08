function plot(TIME::Array,FLUX::Array)
        pl.scatter(TIME,FLUX);

        pl.savefig(fig_name)
        pl.show()


end
