using Statistics, StatsBase
using GroupSummaries: Group, series2D, datafolder
using GroupSummaries: compute_error, density, frequency, hazard, localregression
using JuliaDB

data = loadtable(joinpath(datafolder, "school.csv"))
t = columns(data)

compute_error(t.School, t.MAch, t.SSS)

compute_error(density, t.School, t.MAch)

compute_error(frequency, t.School, rand(1:100, length(t.School)))

compute_error(hazard, t.School, t.MAch)

compute_error(localregression, t.School, t.MAch, t.SSS)

using Plots

args, kwargs = series2D(
    localregression,
    data,
    Group(color = :Sx, linewidth = :Sector),
    color = [:red, :black],
    across = :School,
    select = (:MAch, :SSS),
    ribbon = true
)

plot(args...; kwargs...)

args, kwargs = series2D(
    data,
    Group(markercolor = :Sx, color = :Sx),
    across = :School,
    select = (:MAch, :SSS),
)

scatter(args...; kwargs...)
