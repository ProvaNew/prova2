library(foreach)
library(doParallel)

#number of iterations
iters = 1000

#setup parallel backend to use all except one processors
runOnCores = detectCores() - 1
if (runOnCores < 1) {
  runOnCores = 1
}
mycluster = makeCluster(runOnCores)
registerDoParallel(mycluster, cores=runOnCores)

#run parallel code
results = foreach(i=icount(iters)) %dopar% {
  randomlist = rnorm(i, mean=0, sd=1)
  otherlistnotreturned = rnorm(300000, mean=0, sd=1)
  randomlist
}

#clean resources
stopCluster(mycluster)