
dynamic_margin <- function(a_vector, window_size, margin_size) {
     rolling_margin <- rep(NA, length(margin_size))
     window_mid <- round(window_size / 2)
     transition_step <- margin_size / window_mid
     for (i in 1:margin_size) {
          start_idx_diff <- trunc(i / transition_step)
          window_start <- i - start_idx_diff
          window_end <- window_start + window_size - 1
          rolling_margin[i] <- mean(a_vector[window_start:window_end])
          print(c(i, start_idx_diff, window_start, window_start + start_idx_diff, window_end, rolling_margin[i]))
     }
     return(rolling_margin)
}


dynamic_rolling_average <- function(a_vector, window_size, margin_size) {
     # Problem:  Calculating rolling averages across a series of data points
     #    requires trimming the data points at the end so that they are not used
     #    in the calculations
     # Rolling averages are calculated across a moving window of consecutive
     #    data points.  The position of the data point of interest is always in
     #    the middle of the window.
     # Solution:  When the data point of interest is at the start/end/edge of
     #    the data series, allow it to be at the edge of the window.  As the
     #    calculation of the average rolls/advances through the data series,
     #    gradually move the data point's position from the edge to the middle
     #    of the window.
     # 
     # 'a_vector' - a vector containing a numeric data series
     # 'window_size' - the number of data points across which to calculate the
     #    rolling average
     # 'margin_size' - the size of the each margin at either end of the data
     #    series; at the exterior end of the margin, the data point of interest
     #    is at the edge of the window; at the interior end of the margin, the
     #    data point of interest is at the middle of the margin
     # 
     # To clarify and summarize:
     # Thus, a data series is divided into three parts:  a margin, the middle,
     #    and the other margin.  In the middle of the data series, the rolling
     #    average is calculated as it usually is with the data point of interest
     #    in the middle of the window.  In the margins, as one moves from an
     #    edge of the data series towards its middle, the data point of interest
     #    gradually shifts from the edge of the window towards the middle of
     #    the window so that it reaches the middle of the window by the time it
     #    reaches the interior edge of the margin.
     mean_vector <- rep(NA, length(a_vector))
     mean_vector[1:margin_size] <- dynamic_margin(a_vector, window_size, margin_size)
     end <- length(mean_vector)
     end_margin <- length(mean_vector) - margin_size
     reversed_vector <- rev(a_vector)
     mean_vector[end:(end_margin+1)] <- dynamic_margin(reversed_vector,
                                                       window_size, margin_size)
     for (i in (margin_size+1):end_margin) {
          window_half <- round(window_size / 2)
          window_start <- i - window_half
          window_end <- window_start + window_size - 1
          mean_vector[i] <- mean(a_vector[window_start:window_end])
     }
     return(mean_vector)
}


n <- 50
a_vector <- rnorm(n, mean=100, sd=20)
a_vector <- 1:n
window_size <- 10
margin_size <- 20

a_vector
dynamic_rolling_average(a_vector, window_size, margin_size)
