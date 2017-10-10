**Problem**:  Calculating rolling averages across a series of data points
   requires trimming the data points at the end so that they are not used
   in the calculations
   
Rolling averages are calculated across a moving window of consecutive
   data points.  The position of the data point of interest is always in
   the middle of the window.
   
**Solution**:  When the data point of interest is at the start/end/edge of
   the data series, allow it to be at the edge of the window.  As the
   calculation of the average rolls/advances through the data series,
   gradually move the data point's position from the edge to the middle
   of the window.
