## Pair of functions that cache the inverse of a matrix. 
# Sample run: Computing the inverse in the first run
# > x<- matrix(rnorm(9), nrow= 3, ncol= 3)
# > y<- makeCacheMatrix(x)
# > cacheSolve(y)
## Retrieving the inverse from the cache in the second run
# >cacheSolve(y)

## makeCacheMatrix creates a special "matrix" object that can cache its inverse.
## It is a list containing a function to set the entries of the matrix, get those entries,
## set the inverse of the matrix and get it.

makeCacheMatrix <- function(x = matrix()) {
        inverseX <- NULL
        set <- function(y) {                            # set the Matrix 
                x <<- y
                inverseX <<- NULL
        }
        get <- function() x                             # get the Matrix
        setinverse <- function(inv) inverseX <<- inv   # set the inverse
        getinverse <- function() inverseX               # get the inverse
        list(set = set, get = get,                      # return a list
             setinverse = setinverse,
             getinverse = getinverse)
}


## cacheSolve computes the inverse of the special "matrix" returned by makeCacheMatrix above. 
## This function assumes the matrix is always invertible.
## If the inverse has already been calculated (and the matrix has not changed), then the cachesolve 
## should retrieve the inverse from the cache.

cacheSolve <- function(x, ...) {
        inverseX <- x$getinverse()
        if(!is.null(inverseX)) {
                message("getting cached data")
                return(inverseX)
                
        }
        data <- x$get()
        inverseX <- solve(data, ...)
        x$setinverse(inverseX)
        inverseX
}
