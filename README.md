# df_to_2dmat

http://stackoverflow.com/questions/9617348/reshape-three-column-data-frame-to-matrix-long-to-wide-format

```R
tmp <- data.frame(x=gl(2,3, labels=letters[24:25]),
                  y=gl(3,1,6, labels=letters[1:3]), 
                  z=c(1,2,3,3,3,2))
library(reshape2)
acast(tmp, x~y, value.var="z")
```
