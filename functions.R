#
# BEGIN_COPYRIGHT
#
# PARADIGM4 INC.
# This file is part of the Paradigm4 Enterprise SciDB distribution kit
# and may only be used with a valid Paradigm4 contract and in accord
# with the terms and conditions specified by that contract.
#
# Copyright (C) 2011 - 2017 Paradigm4 Inc.
# All Rights Reserved.
#
# END_COPYRIGHT
#
### Helper scripts for EQTL calculation

# Convert a data-frame with three columns into a matrix
# ordered: is the dataframe already ordered 
df_to_2dmat = function(df, ordered = TRUE)
{
  if (length(names(df)) == 3) # When rownames, and column-names are explicitly provided
  { 
    # Column 1 has the matrix column name info
    # Column 2 has the matrix row name info
    # Column 3 has the matrix data
    if (!ordered)
    {
      # Make sure the data frame is ordered exactly 
      df = df[with(df, order(df[,1], df[,2])), ]
    }
    
    ncols = length(unique(df[, 1]))
    nrows = length(unique(df[, 2]))
    mat = matrix(df[, 3], nrow=nrows, ncol=ncols)
    #dim(mat)  
    
    #### Formulate the rownames and verify
    rowlist = df[, 2]
    rnames = unique(rowlist)
    
    if (ordered) {
      # Verify
      check = all.equal(rep(rnames, ncols), rowlist)
      # print(check)
      stopifnot(check)
    }
    
    #### Formulate the rownames and verify
    collist = df[, 1]
    cnames = unique(collist)
    xx = unlist(lapply(cnames, function(x) {rep(x, nrows)}))
    
    if (ordered) {
      # Verify
      check = all.equal(xx, collist)
      # print(check)
      stopifnot(check)
    }
    
    # now paste the rownames and colnames to the matrix
    rownames(mat) = rnames
    colnames(mat) = cnames
    
    mat
  } else { # Assume that the column names are not provided
    # Column 1 has the matrix row name info
    # Column 2 has the matrix data
    # NOTE: Here we assume that data is always ordered
    stopifnot(ordered == TRUE)
    rowlist = df[, 1]
    rnames = unique(rowlist)
    nrows = length(rnames)
    ncols = nrow(df) / nrows
    
    mat = matrix(df[,2], nrow = nrows)
    rownames(mat) = rnames
    colnames(mat) = c(0: (ncols-1))
    
    mat
  }
}
